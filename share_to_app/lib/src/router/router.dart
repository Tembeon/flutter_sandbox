import 'package:auto_route/annotations.dart';

import '../initialization/widget/initialization_widget.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
      path: '/',
      page: Initialization,
    ),
  ],
)
class $RootRouter {}
