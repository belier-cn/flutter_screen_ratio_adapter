import 'dart:developer';
import 'package:screen_ratio_adapter/screen_ratio_adapter.dart';

void print(Object object) {
  if (Info.isRelease) return;
  log(object);
}
