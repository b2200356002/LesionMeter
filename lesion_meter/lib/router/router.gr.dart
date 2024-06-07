// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CameraRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CameraPage(),
      );
    },
    CreateRecordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateRecordPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomePage(),
      );
    },
    ImagePreviewRoute.name: (routeData) {
      final args = routeData.argsAs<ImagePreviewRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ImagePreviewPage(
          args.image,
          tag: args.tag,
        ),
      );
    },
    PatientDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<PatientDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: PatientDetailsPage(patient: args.patient)),
      );
    },
    PatientsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PatientsPage(),
      );
    },
    RecordDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<RecordDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: RecordDetailsPage(
          record: args.record,
          patient: args.patient,
        )),
      );
    },
    RecordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RecordPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SettingsPage(),
      );
    },
  };
}

/// generated route for
/// [CameraPage]
class CameraRoute extends PageRouteInfo<void> {
  const CameraRoute({List<PageRouteInfo>? children})
      : super(
          CameraRoute.name,
          initialChildren: children,
        );

  static const String name = 'CameraRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateRecordPage]
class CreateRecordRoute extends PageRouteInfo<void> {
  const CreateRecordRoute({List<PageRouteInfo>? children})
      : super(
          CreateRecordRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateRecordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ImagePreviewPage]
class ImagePreviewRoute extends PageRouteInfo<ImagePreviewRouteArgs> {
  ImagePreviewRoute({
    required Image image,
    Object? tag,
    List<PageRouteInfo>? children,
  }) : super(
          ImagePreviewRoute.name,
          args: ImagePreviewRouteArgs(
            image: image,
            tag: tag,
          ),
          initialChildren: children,
        );

  static const String name = 'ImagePreviewRoute';

  static const PageInfo<ImagePreviewRouteArgs> page =
      PageInfo<ImagePreviewRouteArgs>(name);
}

class ImagePreviewRouteArgs {
  const ImagePreviewRouteArgs({
    required this.image,
    this.tag,
  });

  final Image image;

  final Object? tag;

  @override
  String toString() {
    return 'ImagePreviewRouteArgs{image: $image, tag: $tag}';
  }
}

/// generated route for
/// [PatientDetailsPage]
class PatientDetailsRoute extends PageRouteInfo<PatientDetailsRouteArgs> {
  PatientDetailsRoute({
    required Patient patient,
    List<PageRouteInfo>? children,
  }) : super(
          PatientDetailsRoute.name,
          args: PatientDetailsRouteArgs(patient: patient),
          initialChildren: children,
        );

  static const String name = 'PatientDetailsRoute';

  static const PageInfo<PatientDetailsRouteArgs> page =
      PageInfo<PatientDetailsRouteArgs>(name);
}

class PatientDetailsRouteArgs {
  const PatientDetailsRouteArgs({required this.patient});

  final Patient patient;

  @override
  String toString() {
    return 'PatientDetailsRouteArgs{patient: $patient}';
  }
}

/// generated route for
/// [PatientsPage]
class PatientsRoute extends PageRouteInfo<void> {
  const PatientsRoute({List<PageRouteInfo>? children})
      : super(
          PatientsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PatientsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RecordDetailsPage]
class RecordDetailsRoute extends PageRouteInfo<RecordDetailsRouteArgs> {
  RecordDetailsRoute({
    required Record record,
    required Patient patient,
    List<PageRouteInfo>? children,
  }) : super(
          RecordDetailsRoute.name,
          args: RecordDetailsRouteArgs(
            record: record,
            patient: patient,
          ),
          initialChildren: children,
        );

  static const String name = 'RecordDetailsRoute';

  static const PageInfo<RecordDetailsRouteArgs> page =
      PageInfo<RecordDetailsRouteArgs>(name);
}

class RecordDetailsRouteArgs {
  const RecordDetailsRouteArgs({
    required this.record,
    required this.patient,
  });

  final Record record;

  final Patient patient;

  @override
  String toString() {
    return 'RecordDetailsRouteArgs{record: $record, patient: $patient}';
  }
}

/// generated route for
/// [RecordPage]
class RecordRoute extends PageRouteInfo<void> {
  const RecordRoute({List<PageRouteInfo>? children})
      : super(
          RecordRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
