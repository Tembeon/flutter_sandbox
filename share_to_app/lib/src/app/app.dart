import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../router/router.gr.dart';

class ShareToApp extends StatefulWidget {
  const ShareToApp({Key? key}) : super(key: key);

  @override
  State<ShareToApp> createState() => _ShareToAppState();
}

class _ShareToAppState extends State<ShareToApp> {
  final _router = RootRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.delegate(
        navigatorObservers: () => [
          AutoRouteObserver(),
        ],
      ),
      routeInformationParser: _router.defaultRouteParser(),
    );
  }
}
