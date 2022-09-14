import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:l/l.dart';

import 'src/app/app.dart';

void run() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    l.e(error, stack);
    return true;
  };

  runApp(const ShareToApp());
}
