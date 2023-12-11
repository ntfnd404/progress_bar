import 'dart:async';

import 'package:flutter/material.dart';
import 'package:progress_bar/src/app.dart';

void main() => runZonedGuarded<void>(
      () => runApp(const App()),
      (error, stackTrace) {
        // FirebaseCrashlytics.instance.recordError(
        //   error,
        //   stackTrace,
        //   fatal: true,
        // );
      },
    );
