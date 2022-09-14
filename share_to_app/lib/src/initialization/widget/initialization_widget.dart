import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dialog/widget/dialog.dart';
import '../../home/widget/home_screen.dart';
import '../bloc/initialization_bloc.dart';

/// Wraps [InitializationWidget] with [InitializationCubit].
class Initialization extends StatelessWidget {
  const Initialization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InitializationCubit(),
      child: const InitializationWidget(),
    );
  }
}

/// Listening for [InitializationCubit] states.
class InitializationWidget extends StatefulWidget {
  const InitializationWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<InitializationWidget> createState() => _InitializationWidgetState();
}

class _InitializationWidgetState extends State<InitializationWidget> {
  @override
  void dispose() {
    context.read<InitializationCubit>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InitializationCubit, InitializationState>(
      listener: (context, state) {
        state.whenOrNull<Future<void>>(
          receivedNewDatFromIntent: (receivedData) =>
              FloatingDialog.showShareDialog(
            context,
            text: receivedData,
          ),
          receivedInitialDataFromIntent: (receivedData) =>
              FloatingDialog.showShareDialog(
            context,
            text: receivedData,
          ),
        );
      },
      builder: (context, state) {
        return state.maybeWhen<Widget>(
          loading: () => const Center(child: CircularProgressIndicator()),
          continueToApp: () => const HomeScreen(),
          orElse: () => const HomeScreen(),
        );
      },
    );
  }
}
