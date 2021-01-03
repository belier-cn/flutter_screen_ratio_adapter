import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:screen_ratio_adapter/src/ui_blueprints_rectangle.dart';
import 'dart:collection';
import 'dart:ui' as ui show window, PointerDataPacket;
import 'info.dart';
import 'print.dart';
import 'transition_builder_widget.dart';

const _TAG = "【_Fx】";

void runFxApp(Widget app,
    {@required BlueprintsRectangle uiBlueprints,
    VoidCallback onEnsureInitialized,
    bool enableLog = false}) {
  assert(uiBlueprints != null &&
      uiBlueprints.width != null &&
      uiBlueprints.width > 0);
  _enableLog = enableLog ?? false;
  _uiBlueprints = uiBlueprints;
  _FxWidgetsFlutterBinding.ensureInitialized(onEnsureInitialized, enableLog)
    // ignore: invalid_use_of_protected_member
    ..scheduleAttachRootWidget(app)
    ..scheduleWarmUpFrame();
}

// Info _info;
BlueprintsRectangle _uiBlueprints;

bool _enableLog;

///还原为设备原始实际值,使用系统像素密度
double restore2DeviceValue(double dpValue) {
  return dpValue * Info.instance.restoreRatio;
}

EdgeInsets restore2DeviceEdgeInsets(EdgeInsets dpEdgeInsets) {
  return dpEdgeInsets * Info.instance.restoreRatio;
}

Size restore2DeviceSize(Size dpSize) {
  return dpSize * Info.instance.restoreRatio;
}

// ignore: non_constant_identifier_names
TransitionBuilder FxTransitionBuilder({TransitionBuilder builder}) {
  return (context, child) {
    var old = MediaQuery.of(context);
    var deviceShortWidth =
    ui.window.physicalSize.width <= ui.window.physicalSize.height
        ? ui.window.physicalSize.width
        : ui.window.physicalSize.height;
    double actualPixelRatio =
        deviceShortWidth / _uiBlueprints.width;
    Info.init(
        actualPixelRatio: actualPixelRatio,
        uiBlueprints: _uiBlueprints,
        enableLog: _enableLog);
    if (builder == null) builder = (__, _) => _;
    return TransitionBuilderWidget(
        builder: builder,
        didChangeMetricsCallBack: () {
          Info.instance.onScreenMetricsChange(old);
          if (_enableLog) print("$_TAG Info=${Info.instance}");
        },
        child: MediaQuery(
          data: old.copyWith(
            textScaleFactor: 1,
            padding: restore2DeviceEdgeInsets(old.padding),
            viewPadding: restore2DeviceEdgeInsets(old.viewPadding),
            viewInsets: restore2DeviceEdgeInsets(old.viewInsets),
            systemGestureInsets:
                restore2DeviceEdgeInsets(old.systemGestureInsets),
          ),
          child: child,
        ));
  };
}

// final bool _isRelease = const bool.fromEnvironment("dart.vm.product");

class _FxWidgetsFlutterBinding extends WidgetsFlutterBinding {
  final VoidCallback onEnsureInitialized;

  _FxWidgetsFlutterBinding(this.onEnsureInitialized);

  static WidgetsFlutterBinding ensureInitialized(
      VoidCallback onEnsureInitialized, bool enableLog) {
    if (WidgetsBinding.instance == null)
      _FxWidgetsFlutterBinding(onEnsureInitialized);
    if (onEnsureInitialized != null) onEnsureInitialized();
    return WidgetsBinding.instance;
  }

  @protected
  void scheduleAttachRootWidget(Widget rootWidget) {
    Timer.run(() {
      attachRootWidget(_RoorRenderObjectWidget(rootWidget));
    });
  }

  ///override RendererBinding
  @override
  ViewConfiguration createViewConfiguration() {
    //super.createViewConfiguration();
    return ViewConfiguration(
      size: window.physicalSize / adapterDevicePixelRatio,
      devicePixelRatio: adapterDevicePixelRatio,
    );
  }

  ///override GestureBinding
  @override
  void initInstances() {
    super.initInstances();
    ui.window.onPointerDataPacket = _handlePointerDataPacket;
  }

  @override
  void unlocked() {
    super.unlocked();
    _flushPointerEventQueue();
  }

  final Queue<PointerEvent> _pendingPointerEvents = Queue<PointerEvent>();

  void _handlePointerDataPacket(ui.PointerDataPacket packet) {
    _pendingPointerEvents.addAll(
        PointerEventConverter.expand(packet.data, adapterDevicePixelRatio));
    if (!locked) _flushPointerEventQueue();
  }

  @override
  void cancelPointer(int pointer) {
    if (_pendingPointerEvents.isEmpty && !locked)
      scheduleMicrotask(_flushPointerEventQueue);
    _pendingPointerEvents.addFirst(PointerCancelEvent(pointer: pointer));
  }

  void _flushPointerEventQueue() {
    assert(!locked);
    while (_pendingPointerEvents.isNotEmpty)
      _handlePointerEvent(_pendingPointerEvents.removeFirst());
  }

  final Map<int, HitTestResult> _hitTests = <int, HitTestResult>{};

  void _handlePointerEvent(PointerEvent event) {
    assert(!locked);
    HitTestResult result;
    if (event is PointerDownEvent) {
      assert(!_hitTests.containsKey(event.pointer));
      result = HitTestResult();
      hitTest(result, event.position);
      _hitTests[event.pointer] = result;
      assert(() {
        if (debugPrintHitTestResults) debugPrint('$event: $result');
        return true;
      }());
    } else if (event is PointerUpEvent || event is PointerCancelEvent) {
      result = _hitTests.remove(event.pointer);
    } else if (event.down) {
      result = _hitTests[event.pointer];
    } else {
      print("@We currently ignore add, remove, and hover move events.");
      return; // We currently ignore add, remove, and hover move events.
    }
    if (result != null) dispatchEvent(event, result);
  }

  double get adapterDevicePixelRatio {
    if (Info.instance != null) return Info.instance.actualPixelRatio;
    double _adapterDevicePixelRatio;
    var deviceShortWidth =
        ui.window.physicalSize.width <= ui.window.physicalSize.height
            ? ui.window.physicalSize.width
            : ui.window.physicalSize.height;
    _adapterDevicePixelRatio = deviceShortWidth / _uiBlueprints.width;
    return _adapterDevicePixelRatio;
  }
}

class _RoorRenderObjectWidget extends SingleChildRenderObjectWidget {
  _RoorRenderObjectWidget(Widget rootChild) : super(child: rootChild);

  @override
  RenderObject createRenderObject(BuildContext context) {
    _assertOnFuture(() => Info.instance == null,
        errorMsg: "\nError:'FxTransitionBuilder' is not configured"
            "\nMaterialApp("
            "\n  ......"
            "\n  builder: FxTransitionBuilder(builder: null),"
            "\n  ......"
            "\n);");
    return RenderPadding(padding: EdgeInsets.all(0));
  }

  void _assertOnFuture(ValueGetter<bool> conditions,
      {String errorMsg, int time = 1000}) {
    if (Info.isRelease) return;
    Future.delayed(Duration(milliseconds: time), () {
      if (conditions.call()) throw FormatException(errorMsg ?? "");
    });
    Future.delayed(Duration(milliseconds: (time * 1.5).toInt()), () {
      if (conditions.call()) exit(0);
    });
  }
}
