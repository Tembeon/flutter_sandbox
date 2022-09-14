import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'src/core/presentation/app.dart';


void run() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    print('Error: $error\n\nStacktrace: $stack');
    return true;
  };

  runApp(const IsolatesApp());
}
