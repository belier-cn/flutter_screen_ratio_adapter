import 'dart:async';
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
    ValueChanged<Info> onEnsureInitialized,
    bool enableLog = false}) {
  _FxWidgetsFlutterBinding.ensureInitialized(
      uiBlueprints, onEnsureInitialized, enableLog)
    // ignore: invalid_use_of_protected_member
    ..scheduleAttachRootWidget(app)
    ..scheduleWarmUpFrame();
}

Info _info;

Info get info {
  assert(_info != null, "$_TAG no Ensure Initialized");
  return _info;
}

bool _enableLog = false;

///还原为设备原始实际值,使用系统像素密度
double restore2DeviceValue(double dpValue) {
  return dpValue * info.restoreRatio;
}

EdgeInsets restore2DeviceEdgeInsets(EdgeInsets dpEdgeInsets) {
  return dpEdgeInsets * info.restoreRatio;
}

Size restore2DeviceSize(Size dpSize) {
  return dpSize * info.restoreRatio;
}

double _adapterDevicePixelRatio;
// ignore: non_constant_identifier_names
TransitionBuilder FxTransitionBuilder({TransitionBuilder builder}) {
  return (context, child) {
    assert(_info != null, "$_TAG no Ensure Initialized,you need runFxApp");
    var old = MediaQuery.of(context);
    if (builder == null) builder = (__, _) => _;
    return TransitionBuilderWidget(
        builder: builder,
        didChangeMetricsCallBack: () {
          _adapterDevicePixelRatio = null;
          _info.onScreenMetricsChange(old);
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

class _FxWidgetsFlutterBinding extends WidgetsFlutterBinding {
  final ValueChanged<Info> onEnsureInitialized;
  final BlueprintsRectangle uiBlueprints;

  _FxWidgetsFlutterBinding(this.uiBlueprints, this.onEnsureInitialized);

  static WidgetsFlutterBinding ensureInitialized(
      BlueprintsRectangle uiBlueprints,
      ValueChanged<Info> onEnsureInitialized,
      bool enableLog) {
    assert(uiBlueprints != null &&
        uiBlueprints.width != null &&
        uiBlueprints.width > 0);
    _enableLog = enableLog;
    if (WidgetsBinding.instance == null)
      _FxWidgetsFlutterBinding(uiBlueprints, onEnsureInitialized);
    double actualPixelRatio = ui.window.physicalSize.width / uiBlueprints.width;
    _info = Info(
        actualPixelRatio: actualPixelRatio,
        uiBlueprints: uiBlueprints,
        enableLog: enableLog);
    print("$_TAG $_info");
    if (onEnsureInitialized != null) onEnsureInitialized(_info);
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
      return; // We currently ignore add, remove, and hover move events.
    }
    if (result != null) dispatchEvent(event, result);
  }

  double get adapterDevicePixelRatio {
    if (_adapterDevicePixelRatio == null) {
      var deviceShortWidth =
          ui.window.physicalSize.width <= ui.window.physicalSize.height
              ? ui.window.physicalSize.width
              : ui.window.physicalSize.height;
      _adapterDevicePixelRatio = deviceShortWidth / uiBlueprints.width;
    }
    return _adapterDevicePixelRatio;
  }
}

class _RoorRenderObjectWidget extends SingleChildRenderObjectWidget {
  _RoorRenderObjectWidget(Widget rootChild) : super(child: rootChild);

  @override
  RenderObject createRenderObject(BuildContext context) {
    assert(
        _checkApp(super.child, context),
        "\nError:'FxTransitionBuilder' is not configured"
        "\nMaterialApp("
        "\n  ......"
        "\n  builder: FxTransitionBuilder(builder: null),"
        "\n  ......"
        "\n);");
    return _RenderInner();
  }

  bool _checkApp(Widget child, BuildContext context) {
    // if(_enableLog) return true;
    MaterialApp app = _findMaterialOrCupertino<MaterialApp>(child, context);
    if (app != null) return app.builder != null;

    CupertinoApp cApp = _findMaterialOrCupertino<CupertinoApp>(child, context);
    if (cApp != null) return cApp.builder != null;
    assert(true, "MaterialApp or CupertinoApp not find🙃");
    return false;
  }

  Widget _findMaterialOrCupertino<T>(Widget widget, BuildContext context) {
    if (widget is StatelessWidget) {
      // ignore: invalid_use_of_protected_member
      Widget child = widget.build(context);
      if (child is T) {
        return child;
      } else {
        return _findMaterialOrCupertino<T>(child, context);
      }
    } else if (widget is StatefulBuilder) {
      // ignore: invalid_use_of_protected_member
      Widget child = widget.createState().build(context);
      if (child is T) {
        return child;
      } else {
        return _findMaterialOrCupertino<T>(child, context);
      }
    } else if (widget is SingleChildRenderObjectWidget) {
      Widget child = widget.child;
      if (child is T) {
        return child;
      } else {
        return _findMaterialOrCupertino<T>(child, context);
      }
    } else {
      return null;
    }
  }
}

class _RenderInner extends RenderPadding {
  _RenderInner() : super(padding: EdgeInsets.all(0));
}
