import 'dart:ui';

import 'package:flutter/widgets.dart';

const _TAG = "【_Fx】";

class Info {
  ///密度无关像素，每个逻辑像素对应的设备像素数。就像 dp 或者 pt
  final double devicePixelRatio;

  ///适配之后，每个逻辑像素对应的设备像素数
  final double actualPixelRatio;

  ///设计稿尺寸
  final Size uiSize;

  ///设备显示区域实际尺寸
  Size _devicePhysicalSize;

  Size get devicePhysicalSize => _devicePhysicalSize;

  set devicePhysicalSize(Size size) {
    _devicePhysicalSize = size;
    var deltaRatio = devicePhysicalSize.aspectRatio - uiSize.aspectRatio;
    deltaHeight = deltaRatio * uiSize.width;
    print(toString());
  }

  ///设备显示区域dp尺寸
  Size get actualDpSize => devicePhysicalSize / actualPixelRatio;

  /// value*restoreRatio=未适配之前的value
  double get restoreRatio => devicePixelRatio / actualPixelRatio;

  ///高度差值
  double deltaHeight;

  ///宽度差值，宽适配时为0
  double deltaWidth;

  Info(
      {@required this.devicePixelRatio,
      @required this.actualPixelRatio,
      @required this.uiSize,
      @required Size devicePhysicalSize}) {
    this.devicePhysicalSize = devicePhysicalSize;
  }

  ///还原为设备原始实际值
  double restore2DeviceValue(double dpValue) {
    return dpValue * restoreRatio;
  }

  EdgeInsets restore2DeviceEdgeInsets(EdgeInsets dpEdgeInsets) {
    return dpEdgeInsets * restoreRatio;
  }

  Size restore2DeviceSize(Size dpSize) {
    return dpSize * restoreRatio;
  }

  @override
  String toString() {
    /// ////////////////////////////////////////////////////////////////////////
    print(
        "$_TAG 设计稿标准尺寸 = ${uiSize.toString()} h/w tanθ= ${1 / uiSize.aspectRatio}");
    print(
        "$_TAG 设备的屏幕尺寸 =$devicePhysicalSize  h/w tanθ=${1 / devicePhysicalSize.aspectRatio}");
    var deltaRatio = devicePhysicalSize.aspectRatio - uiSize.aspectRatio;
    if (deltaRatio > 0) {
      print("$_TAG 尺码过大${deltaHeight.toStringAsFixed(2)} 请启用纵向滑动式适配");
    } else if (deltaRatio < 0) {
      print("$_TAG 尺码过小${deltaHeight.toStringAsFixed(2)} 设置需要留白的区域");
    } else {
      print("$_TAG 尺码完全符合");
    }
    if (uiSize.width >= 720) {
      print("╔═══════════════════════════════════╗");
      print("║                ╭-╮                ║");
      print("║                ┆ ┆                ║");
      print("║                ┆ ┆                ║");
      print("║                ╰-╯                ║");
      print("║                 ○                 ║");
      print("║                                   ║");
      print("║      请以pt/dp为单位初始化ui尺寸     ║");
      print("║                                   ║");
      print("║                                   ║");
      print("╚═══════════════════════════════════╝");
    }

    print("$_TAG 原本屏幕尺寸比率=$devicePixelRatio");
    print("$_TAG 转换后的屏幕尺寸比率=$actualPixelRatio");

    /// ////////////////////////////////////////////////////////////////////////
    return 'Info{devicePixelRatio: $devicePixelRatio, actualPixelRatio: $actualPixelRatio, uiSize: $uiSize, devicePhysicalSize: $devicePhysicalSize, deltaHeight: $deltaHeight, deltaWidth: $deltaWidth}';
  }
}
