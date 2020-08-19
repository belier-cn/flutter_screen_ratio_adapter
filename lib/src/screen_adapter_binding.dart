import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'dart:collection';
import 'dart:ui' as ui show window, PointerDataPacket;
import 'info.dart';
import 'print.dart';
import 'transition_builder_widget.dart';

const _TAG = "【_Fx】";

typedef InfoCallback = void Function(Info duration);

void runFxApp(Widget app,
    {@required Size uiSize, InfoCallback onEnsureInitialized}) {
  _FxWidgetsFlutterBinding.ensureInitialized(uiSize, onEnsureInitialized)
    // ignore: invalid_use_of_protected_member
    ..scheduleAttachRootWidget(app)
    ..scheduleWarmUpFrame();
}

Info _info;

Info get info {
  assert(_info != null, "$_TAG no Ensure Initialized");
  return _info;
}

///还原为设备原始实际值
double restore2DeviceValue(double dpValue) {
  return (dpValue / info.actualPixelRatio) * info.devicePixelRatio;
}

EdgeInsets restore2DeviceEdgeInsets(EdgeInsets dpEdgeInsets) {
  return dpEdgeInsets * (info.devicePixelRatio / info.actualPixelRatio);
}

Size restore2DeviceSize(Size dpSize) {
  return dpSize * (info.devicePixelRatio / info.actualPixelRatio);
}

// ignore: non_constant_identifier_names
TransitionBuilder FxTransitionBuilder({TransitionBuilder builder}) {
  return (context, child) {
    assert(_info != null, "$_TAG no Ensure Initialized");
    var old = MediaQuery.of(context);
    print("原MediaQueryData$old");
    if (builder == null) builder = (__, _) => _;
    return TransitionBuilderWidget(
      builder: builder,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1,
          padding: restore2DeviceEdgeInsets(old.padding),
          viewPadding: restore2DeviceEdgeInsets(old.viewPadding),
          viewInsets: restore2DeviceEdgeInsets(old.viewInsets),
          systemGestureInsets:
              restore2DeviceEdgeInsets(old.systemGestureInsets),
        ),
        child: child,
      ),
    );
  };
}

class _FxWidgetsFlutterBinding extends WidgetsFlutterBinding {
  final InfoCallback onEnsureInitialized;
  final Size uiSize;

  _FxWidgetsFlutterBinding(this.uiSize, this.onEnsureInitialized);

  static WidgetsFlutterBinding ensureInitialized(
      Size uiSize, InfoCallback onEnsureInitialized) {
    assert(uiSize != null && uiSize.width != null && uiSize.width > 0);
    if (WidgetsBinding.instance == null)
      _FxWidgetsFlutterBinding(uiSize, onEnsureInitialized);
    double devicePixelRatio = ui.window.devicePixelRatio;
    double actualPixelRatio = ui.window.physicalSize.width / uiSize.width;
    _info = Info(
        devicePixelRatio: devicePixelRatio,
        actualPixelRatio: actualPixelRatio,
        uiSize: uiSize,
        devicePhysicalSize: ui.window.physicalSize);
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
      size: window.physicalSize / _getAdapterDevicePixelRatio(),
      devicePixelRatio: _getAdapterDevicePixelRatio(),
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
    _pendingPointerEvents.addAll(PointerEventConverter.expand(
        packet.data, _getAdapterDevicePixelRatio()));
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

  double _getAdapterDevicePixelRatio() {
    return ui.window.physicalSize.width / uiSize.width;
  }
}

class _RoorRenderObjectWidget extends SingleChildRenderObjectWidget {
  _RoorRenderObjectWidget(rootChild) : super(child: rootChild);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderInner();
  }
}

class _RenderInner extends RenderPadding {
  _RenderInner() : super(padding: EdgeInsets.all(0));

  @override
  // TODO: implement size
  Size get size => printSize();

  printSize() {
    print("printSize    " + (super.size).toString());
    return super.size;
  }
}
