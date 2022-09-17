# flutter_isolates

Sample app to work with isolates.

## Highlights
* [Error handler](lib/src/core/utils/errors_handler.dart) for Flutter 3.3 and above ([Why](https://docs.flutter.dev/testing/errors)?)
* [IsolatesHandshake](lib/src/core/utils/isolates_handshake.dart)

Folder structure:
```
lib
├── main.dart
├── runner_io.dart
├── runner_stub.dart
├── runner_web.dart
└── src
    ├── core
    │   ├── presentation
    │   │   └── app.dart
    │   └── utils
    │       ├── errors_handler.dart
    │       ├── errors_handler_implementation.dart
    │       └── isolates_handshake.dart
    └── features
        └── home
            └── presentation
                ├── home_logic.dart
                └── home_screem.dart
```