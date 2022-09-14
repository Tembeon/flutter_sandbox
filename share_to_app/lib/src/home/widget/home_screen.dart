import 'package:flutter/material.dart';

import '../../dialog/widget/dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Share text to app via system share dialog',
            ),
            OutlinedButton(
              onPressed: () => FloatingDialog.showShareDialog(
                context,
                text: 'Created from HomeScreen',
              ),
              child: const Text('Create dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
