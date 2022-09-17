import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_isolates/src/features/home/presentation/home_logic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int primeNumbers = 0;
  int elapsedTime = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            Text('Prime numbers: $primeNumbers\nElapsed time: $elapsedTime'),
            OutlinedButton(
              child: const Text('Set numbers to zero'),
              onPressed: () => setState(() {
                elapsedTime = 0;
                primeNumbers = 0;
              }),
            ),
            OutlinedButton(
              child: const Text('Make some computing without isolate'),
              onPressed: () async {
                final watch = Stopwatch()..start();

                final num =
                    await HomeLogic.calculatePrimeNumbersWithoutIsolate();

                setState(() {
                  elapsedTime = (watch..stop()).elapsedMilliseconds;
                  primeNumbers = num;
                });
              },
            ),
            OutlinedButton(
              child: const Text('Make some computing with isolate'),
              onPressed: () async {
                final watch = Stopwatch()..start();
                final num = await HomeLogic.calculatePrimeNumbersWithIsolate();

                setState(() {
                  elapsedTime = (watch..stop()).elapsedMilliseconds;
                  primeNumbers = num;
                });
              },
            ),
            const Divider(
              thickness: 2,
            ),
            const Text('Crash handlers test'),
            OutlinedButton(
              child: const Text('Summon Flutter error'),
              onPressed: () => 2 ~/ 0,
            ),
            OutlinedButton(
              child: const Text('Summon Platform error'),
              onPressed: () =>
                  const MethodChannel('unknownChannel').invokeMethod('error'),
            ),
          ],
        ),
      ),
    );
  }
}
