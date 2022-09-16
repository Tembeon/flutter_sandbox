import 'package:flutter/foundation.dart';

abstract class AppErrorsHandler {
  /// Sets [FlutterError.onError] method for catching Flutter errors.
  ///
  /// Sets [PlatformDispatcher.instance.onError] method for catching Dart,
  /// Platforms errors.
  ///
  /// You must override [onFlutterError] and [onPlatformError] methods.
  @mustCallSuper
  void setupHandler() {
    // catching Flutter errors.
    FlutterError.onError = onFlutterError;

    // catching Dart, Platforms errors.
    PlatformDispatcher.instance.onError = onPlatformError;
  }

  /// Called when Flutter-related error occurred.
  /// In example: RenderOverflow error.
  @mustCallSuper
  void onFlutterError(FlutterErrorDetails details) => FlutterError.presentError;

  /// Called when occurs error with Dart or Platforms.
  ///
  /// This callback must return `true` if it has handled the error. Otherwise,
  /// it must return `false` and a fallback mechanism such as printing to stderr
  /// will be used, as configured by the specific platform embedding via
  /// `Settings::unhandled_exception_callback`.
  bool onPlatformError(Object error, StackTrace stack);
}
