import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import 'constants/system_ui_overlay_styles.dart';
import 'core/injections/locator.dart';
import 'utils/http_overrides.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Permission.storage.request();
      await Permission.manageExternalStorage.request();

      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayDarkStyle);
      SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
      );
      configureDependencies();

      HttpOverrides.global = MyHttpOverrides();

      runApp(ProviderScope(child: await builder()));
    },
    (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
    },
  );
}
