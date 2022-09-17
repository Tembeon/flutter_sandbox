import 'dart:async';

import '../../../core/utils/isolates_handshake.dart';

class HomeLogic {
  static const calculatePrimeNumbersUntil = 200000;

  static Future<int> calculatePrimeNumbersWithIsolate() async {
    final primeNumbers = Completer<int>();
    int numCount = 0;

    final port = await initIsolate(
      stopWhenReceived: 'kill',
      onMainIsolateDataReceived: (data) {
        // received data is a prime number
        if (data is int) numCount++;
      },
      onChildIsolateDataReceived: (data, port) {
        if (data is int) {
          for (int i = 2; i <= data; i++) {
            if (checkPrime(i)) {
              port.send(i);
            }
          }
        }
      },
      onIsolateClosed: () {
        primeNumbers.complete(numCount);
      },
    );

    // send to isolate data to process
    port
      ..send(calculatePrimeNumbersUntil)
      ..send('kill');

    return primeNumbers.future;
  }

  static Future<int> calculatePrimeNumbersWithoutIsolate() {
    final value = Completer<int>();
    int numCount = 0;

    for (int i = 2; i <= calculatePrimeNumbersUntil; i++) {
      if (checkPrime(i)) {
        numCount++;
      }
    }

    value.complete(numCount);
    return value.future;
  }

  static bool checkPrime(int num) {
    int i, m = 0, flag = 0;
    m = num ~/ 2;
    for (i = 2; i <= m; i++) {
      if (num % i == 0) {
        flag = 1;
        break;
      }
    }

    return flag == 0;
  }
}
