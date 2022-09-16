import 'package:flutter/material.dart';

import 'src/core/presentation/app.dart';
import 'src/core/utils/errors_handler_implementation.dart';

void run() {
  MyAppErrorsHandler().setupHandler();

  runApp(const IsolatesApp());
}
