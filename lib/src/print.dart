import 'dart:developer';

bool _isRelease;

class _BuildConfig {
  static bool get isRelease {
    if (_isRelease == null) {
      _isRelease = true;
      assert(() {
        _isRelease = false;
        return true;
      }());
    }
    return _isRelease;
  }
}

void print(Object object) {
  if (_BuildConfig.isRelease) return;
  log(object);
}
