# ShareToApp

Sample app to work with receive intent on Android and iOS device with Flutter.

Folder structure:
```
.
├── main.dart
├── runner_io.dart              # starts app with IO settings
├── runner_stub.dart            # app started on unknown platform, will fail 
├── runner_web.dart             # app started in web, will fail
└── src
    ├── app
    │   └── app.dart            # creates app widget
    ├── dialog
    │   └── widget
    │       └── dialog.dart                         # dialog ui and method to show this dialog
    ├── home
    │   └── widget
    │       └── home_screen.dart                    # home screen with button to create ui
    ├── initialization
    │   ├── bloc
    │   │   ├── initialization_bloc.dart            # returs states based on receive intent data
    │   │   └── initialization_bloc.freezed.dart
    │   └── widget
    │       └── initialization_widget.dart          # initializes initialization_bloc 
    └── router
        ├── router.dart                             # root router for app
        └── router.gr.dart

```

