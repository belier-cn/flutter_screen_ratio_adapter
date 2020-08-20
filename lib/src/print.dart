import 'package:flutter/widgets.dart';
import 'dart:developer';

final bool _isRelease = const bool.fromEnvironment("dart.vm.product");

void print(Object object) {
  if (_isRelease) return;
  log(object);
}
