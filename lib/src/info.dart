import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:screen_ratio_adapter/src/print.dart';

const _TAG = "【_Fx】";

class Info {
  ///密度无关像素，每个逻辑像素对应的设备像素数。就像 dp 或者 pt
  final double devicePixelRatio;

  ///适配之后，每个逻辑像素对应的设备像素数
  final double actualPixelRatio;

  ///设计稿尺寸
  final Size uiSize;

  ///设备显示区域dp尺寸
  Size get actualDpSize => window.physicalSize / actualPixelRatio;

  /// value*restoreRatio=未适配之前的value
  double get restoreRatio => devicePixelRatio / actualPixelRatio;

  ///高度差值
  double deltaHeight;

  ///宽度差值，宽适配时为0
  double deltaWidth;

  EdgeInsets _deltaPadding;

  EdgeInsets get deltaPadding => _deltaPadding;

  double _bodyMaxHasAppBar;

  double get bodyMaxHasAppBar => _bodyMaxHasAppBar;

  Info(
      {@required this.devicePixelRatio,
      @required this.actualPixelRatio,
      @required this.uiSize});

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

  void onScreenMetricsChange(MediaQueryData queryData) {
    var deltaTg = 1 / window.physicalSize.aspectRatio - 1 / uiSize.aspectRatio;
    _deltaPadding =
        restore2DeviceEdgeInsets(queryData.padding) - queryData.padding;
    deltaHeight = deltaTg * uiSize.width;
    _bodyMaxHasAppBar =
        uiSize.height - restore2DeviceEdgeInsets(queryData.padding).top - kToolbarHeight + deltaHeight;
    print(
        "$_TAG △H=$deltaHeight 状态栏△H=${_deltaPadding.vertical} △h总=$deltaHeight _bodyMaxHasAppBar=$_bodyMaxHasAppBar");
    _printInfo();
  }

  void _printInfo() {
    print(
        "$_TAG 设计稿标准尺寸 = ${uiSize.toString()} h/w tgθ= ${1 / uiSize.aspectRatio}");
    print(
        "$_TAG 设备的屏幕尺寸 =${window.physicalSize}  h/w tgθ=${1 / window.physicalSize.aspectRatio}");

    if (deltaHeight > 0) {
      print("$_TAG 尺码过大=△H=$deltaHeight 请启用纵向滑动式适配");
    } else if (deltaHeight < 0) {
      print("$_TAG 尺码过小△H=$deltaHeight 设置需要留白的区域");
    } else {
      print("$_TAG 尺码完全符合");
    }
    print("$_TAG 原本屏幕尺寸比率=$devicePixelRatio");
    print("$_TAG 转换后的屏幕尺寸比率=$actualPixelRatio");
  }

  @override
  String toString() {
    /// ////////////////////////////////////////////////////////////////////////
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

    /// ////////////////////////////////////////////////////////////////////////
    return 'Info{devicePixelRatio: $devicePixelRatio, actualPixelRatio: $actualPixelRatio, uiSize: $uiSize, devicePhysicalSize: ${window.physicalSize}, deltaHeight: $deltaHeight, deltaWidth: $deltaWidth, actualDpSize:$actualDpSize}';
  }
}
