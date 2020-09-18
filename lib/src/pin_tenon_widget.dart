import 'package:flutter/material.dart';
import 'package:screen_ratio_adapter/screen_ratio_adapter.dart';

final bool _isRelease = const bool.fromEnvironment("dart.vm.product");

class PinTenonWidget extends StatefulWidget {
  const PinTenonWidget();

  @override
  _PinTenonWidgetState createState() {
    return _PinTenonWidgetState();
  }
}

class _PinTenonWidgetState extends State<PinTenonWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (info.deltaLength <= 0) return SizedBox.fromSize(size: Size.zero);
    if (_isRelease)
      return SizedBox(height: info.deltaLength, width: double.infinity);
    return Container(
        color: Colors.deepOrangeAccent,
        height: info.deltaLength,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text('我是多余的'));
  }
}
