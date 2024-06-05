import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lesion_meter/core/models/failure/failure.dart';
import 'package:lesion_meter/domain/repositories/file_repository.dart';
import 'package:lesion_meter/services/locale/locale_resources_service.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/failure_messages.dart';
import '../../core/injections/locator.dart';

@LazySingleton(as: FileRepository)
final class FileRepositoryImpl implements FileRepository {
  final LocaleResourcesService _localeResourcesService;

  const FileRepositoryImpl(this._localeResourcesService);

  @override
  Future<Either<Failure, Unit>> export() async {
    try {
      final status = await Permission.manageExternalStorage.request();

      if (!status.isGranted) {
        return left(const Failure.permissionDenied(permissionDeniedMessage));
      }

      final path = getIt<Directory>(instanceName: "applicationDocumentsDirectory").path;

      await _localeResourcesService.export(path);

      return right(unit);
    } catch (e) {
      return left(const Failure.unknownError(unknownErrorMessage));
    }
  }

  @override
  Future<Either<Failure, Option<Unit>>> import() async {
    try {
      final result = await FilePicker.platform.pickFiles(allowedExtensions: ["json"], type: FileType.custom);

      if (result != null) {
        final file = File(result.files.single.path!);
        final contents = await file.readAsString();

        await _localeResourcesService.import(contents);

        return right(some(unit));
      }

      return right(none());
    } catch (e) {
      return left(const Failure.unknownError(unknownErrorMessage));
    }
  }
}
