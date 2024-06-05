import 'dart:io';

import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:lesion_meter/domain/models/patient.dart';
import 'package:path_provider/path_provider.dart';

import '../../constants/api_endpoints.dart';
import '../../domain/models/record.dart';
import '../../router/router.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  AppRouter get appRouter;

  @lazySingleton
  Connectivity get connectivity;

  @lazySingleton
  ImagePicker get imagePicker;

  @lazySingleton
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: Endpoints.baseUrl,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

  @Named("applicationDocumentsDirectory")
  @lazySingleton
  @preResolve
  Future<Directory> get applicationDocumentsDirectory => getApplicationDocumentsDirectory();

  @lazySingleton
  @preResolve
  Future<Isar> getIsar(
    @Named("applicationDocumentsDirectory") Directory directory,
  ) =>
      Isar.open(
        [
          PatientSchema,
          RecordSchema,
        ],
        directory: directory.path,
      );
}
