import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              child: const Text('Summon Flutter error'),
              onPressed: () {
                int errorInt = 2 ~/ 0;
              },
            ),
            OutlinedButton(
              child: const Text('Summon Platform error'),
              onPressed: () {
                const MethodChannel('unknownChannel').invokeMethod('error');
              },
            ),
          ],
        ),
      ),
    );
  }
}

void someFunc() {

}
