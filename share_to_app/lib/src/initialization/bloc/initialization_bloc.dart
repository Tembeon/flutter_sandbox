import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

part 'initialization_bloc.freezed.dart';

@freezed
class InitializationState with _$InitializationState {
  const InitializationState._();

  /// Initialization in progress.
  const factory InitializationState.loading() = _LoadingInitializationState;

  /// While app is running, received new data from intent.
  const factory InitializationState.receivedNewDatFromIntent(
    String newData,
  ) = _ReceivedNewDatFromIntentInitializationState;

  /// Received data on app startup.
  const factory InitializationState.receivedInitialDataFromIntent(
    String initialData,
  ) = _ReceivedInitialDataFromIntentInitializationState;

  /// No data received on startup, load app.
  const factory InitializationState.continueToApp() =
      _ContinueToAppInitializationState;
}

class InitializationCubit extends Cubit<InitializationState> {
  // data subscription
  late StreamSubscription _sharingStreamSub;

  InitializationCubit() : super(const InitializationState.loading()) {
    // received data on startup
    String? initialData;

    // receiving initial data on app startup. Can be null
    ReceiveSharingIntent.getInitialText().then((value) {
      print('Received initial data: $value');

      initialData = value;
      emit(initialData != null
          ? InitializationState.receivedInitialDataFromIntent(initialData!)
          : const InitializationState.continueToApp());
    });

    // listening for new data while app is active. Can't be null
    _sharingStreamSub = ReceiveSharingIntent.getTextStream().listen((data) {
      print('Received data while app is active: $data');
      emit(InitializationState.receivedNewDatFromIntent(data));
    });
  }

  /// Stop listening for data from intent
  @override
  Future<void> close() {
    _sharingStreamSub.cancel();
    return super.close();
  }
}
