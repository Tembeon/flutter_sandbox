import 'package:flutter/foundation.dart';
import 'package:flutter_isolates/src/core/utils/errors_handler.dart';

class MyAppErrorsHandler extends AppErrorsHandler {
  @override
  void onFlutterError(details) {
    debugPrint('[E] Flutter error:\n${details.exception}\n\n'
        'Stack:\n${details.stack}');
    super.onFlutterError(details);
  }

  @override
  bool onPlatformError(Object error, StackTrace stack) {
    debugPrint('[E] Platform error:\n$error\n\nStack:\n$stack');
    return true;
  }
}
