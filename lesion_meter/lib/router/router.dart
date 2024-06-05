import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../domain/models/patient.dart';
import '../domain/models/record.dart';
import '../presentation/pages/camera_page.dart';
import '../presentation/pages/create_record_page.dart';
import '../presentation/pages/home_page.dart';
import '../presentation/pages/image_preview_page.dart';
import '../presentation/pages/patient_details_page.dart';
import '../presentation/pages/patients_page.dart';
import '../presentation/pages/record_details.dart';
import '../presentation/pages/record_page.dart';
import '../presentation/pages/settings_page.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "Page|Screen|View|Widget,Route")
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: CameraRoute.page),
    AutoRoute(page: ImagePreviewRoute.page),
    AutoRoute(page: PatientsRoute.page),
    AutoRoute(page: PatientDetailsRoute.page),
    AutoRoute(page: RecordRoute.page),
    AutoRoute(page: CreateRecordRoute.page),
    AutoRoute(page: RecordDetailsRoute.page),
  ];
}
