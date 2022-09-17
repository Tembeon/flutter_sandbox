import 'dart:async';
import 'dart:isolate';

/// Creates child isolate and returns SendPort of child isolate to pass data.
///
/// Use [onMainIsolateDataReceived] and [onChildIsolateDataReceived] to
/// react to received data.
///
/// To stop isolates pass [stopWhenReceived] string.
Future<SendPort> initIsolate({
  /// Called when **main** isolate receives data from child isolate.
  ///
  /// To pass data to isolate use [await initIsolate.send()].
  required void Function(Object? data) onMainIsolateDataReceived,

  /// Called when **child** isolate receives data from main isolate.
  ///
  /// To return data to main isolate use [port.send()].
  required void Function(Object? data, SendPort port)
      onChildIsolateDataReceived,

  /// Called when child isolate is already closed and main isolate is about to
  /// stop listening.
  void Function()? onIsolateClosed,

  /// When both isolates received this String, they will be stopped.
  required String stopWhenReceived,

  /// If [true], then isolate will close after error. Default is [false].
  bool? errorsAreFatal,
}) async {
  // child isolate SendPort
  final childIsolateSendPort = Completer<SendPort>();

  // main isolate ReceivePort
  final mainIsolateReceivePort = ReceivePort();

  // listening data from child isolate
  late StreamSubscription sub;
  sub = mainIsolateReceivePort.listen((Object? data) {
    if (!childIsolateSendPort.isCompleted && data is SendPort) {
      // received data is child's SendPort, save it
      childIsolateSendPort.complete(data);
    } else {
      if (data is String && data == stopWhenReceived) {
        // do users handler before cancel listening
        onIsolateClosed?.call();
        // stop word, cancel listening
        sub.cancel();
      } else {
        // pass data to user handler
        onMainIsolateDataReceived.call(data);
      }
    }
  });

  // create child isolate and pass arguments
  await Isolate.spawn(
    createChildIsolate,
    SendData(
      mainIsolateReceivePort.sendPort,
      onChildIsolateDataReceived,
      stopWhenReceived: stopWhenReceived,
      errorsAreFatal: errorsAreFatal ?? false,
    ),
  );

  // returning SendPort of child isolate
  return childIsolateSendPort.future;
}

// Creates child isolate with passed arguments.
void createChildIsolate(SendData sendData) {
  // child isolate ReceivePort.
  final childIsolateReceivePort = ReceivePort();

  // main isolate SendPort, use to send data.
  final mainIsolateSendPort = sendData.sendPort;

  Isolate.current.setErrorsFatal(sendData.errorsAreFatal);

  // returning SendPort of child isolate to send data to this isolate.
  mainIsolateSendPort.send(childIsolateReceivePort.sendPort);

  // listening to new data from main isolate
  childIsolateReceivePort.listen((Object? data) {
    if (data is String && data == sendData.stopWhenReceived) {
      // send stop word to main isolate and kill this isolate
      mainIsolateSendPort.send(sendData.stopWhenReceived);
      Isolate.current.kill();
    } else {
      // pass data to user handler
      sendData.proceedData.call(data, mainIsolateSendPort);
    }
  });
}

class SendData {
  SendData(
    this.sendPort,
    this.proceedData, {
    required this.stopWhenReceived,
    required this.errorsAreFatal,
  });

  /// When isolates receives this string, they will be stopped
  String stopWhenReceived;

  /// If [true], then isolate will close after error
  bool errorsAreFatal;

  /// Used to pass data to parent isolate
  final SendPort sendPort;

  /// Used to handle data in child isolate
  final void Function(Object? data, SendPort port) proceedData;
}
