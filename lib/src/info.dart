import 'dart:ui';

import 'package:flutter/widgets.dart';

///
///设计稿尺寸，单位应是pt或dp，因为源码中的尺寸都会经过  devicePixelRatio 转换后的实际尺寸映射到设备；
class Info {
  ///密度无关像素，每个逻辑像素对应的设备像素数。就像 dp 或者 pt
  final double devicePixelRatio;

  ///适配之后，每个逻辑像素对应的设备像素数
  final double actualPixelRatio;

  ///设计稿尺寸
  final Size uiSize;

  ///设备显示区域实际尺寸
  Size devicePhysicalSize;

  ///设备显示区域dp尺寸
  Size get actualDpSize => devicePhysicalSize/actualPixelRatio;

  ///高度差值
  double deltaHeight;

  ///宽度差值，宽适配时为0
  double deltaWidth;

  Info(
      {@required this.devicePixelRatio,
      @required this.actualPixelRatio,
      @required this.uiSize,
      @required this.devicePhysicalSize,
      this.deltaHeight = 0,
      this.deltaWidth = 0}) {
    var deltaRatio = devicePhysicalSize.aspectRatio - uiSize.aspectRatio;
    deltaHeight = deltaRatio * uiSize.width;
  }

  ///还原为设备原始实际值
  double restore2DeviceValue(double dpValue) {
    return (dpValue / actualPixelRatio) * devicePixelRatio;
  }

  EdgeInsets restore2DeviceEdgeInsets(EdgeInsets dpEdgeInsets) {
    return dpEdgeInsets * (devicePixelRatio / actualPixelRatio);
  }

  Size restore2DeviceSize(Size dpSize) {
    return dpSize * (devicePixelRatio / actualPixelRatio);
  }

  @override
  String toString() {
    const _TAG = "【_Fx】";

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
