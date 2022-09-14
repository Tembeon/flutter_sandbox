import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class FloatingDialog {
  /// Shows dialog with given [text].
  static Future<void> showShareDialog(
    BuildContext context, {
    required String text,
  }) async {
    assert(text.isNotEmpty, 'Text must not be empty');

    return showDialog<void>(
      context: context,
      builder: (_) => ShareDialog(data: text),
    );
  }
}

class ShareDialog extends StatelessWidget {
  const ShareDialog({
    Key? key,
    required this.data,
  }) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(data),
      actions: [
        OutlinedButton(
          onPressed: () => context.popRoute(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
