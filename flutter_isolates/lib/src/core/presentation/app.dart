import 'package:flutter/material.dart';

import '../../features/home/presentation/home_screem.dart';

class IsolatesApp extends StatelessWidget {
  const IsolatesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
