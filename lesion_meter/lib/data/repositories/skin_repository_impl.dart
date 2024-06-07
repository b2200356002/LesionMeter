import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/painting.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lesion_meter/constants/api_endpoints.dart';
import 'package:lesion_meter/constants/failure_messages.dart';
import 'package:lesion_meter/data/DTOs/lesion_dto.dart';
import 'package:lesion_meter/domain/models/patient.dart';
import 'package:lesion_meter/domain/models/record.dart';
import 'package:lesion_meter/domain/repositories/skin_repository.dart';
import 'package:lesion_meter/services/locale/locale_resources_service.dart';
import 'package:lesion_meter/services/network/network_service.dart';

import '../../core/models/failure/failure.dart';
import '../../domain/models/lesion.dart';

@LazySingleton(as: SkinRepository)
final class SkinRepositoryImpl implements SkinRepository {
  final LocaleResourcesService localeResourcesService;
  final NetworkService networkService;

  const SkinRepositoryImpl({
    required this.localeResourcesService,
    required this.networkService,
  });

  @override
  Future<Either<Failure, Lesion>> scan({required List<XFile> imageFiles}) async {
    return left(const Failure.unknownError(unknownErrorMessage));

    final image = await decodeImageFromList(await imageFiles.first.readAsBytes());
    final resolution = Size(image.width.toDouble(), image.height.toDouble());

    final base64Images = <String>[];

    for (final image in imageFiles) {
      final base64 = base64Encode(await image.readAsBytes());

      base64Images.add(base64);
    }

    final data = {
      "data": {
        "screen_size": 7,
        "resolution": "${resolution.width.toInt()}x${resolution.height.toInt()}",
      },
      "images": base64Images,
    };

    final result = await networkService.post(Endpoints.skinLession, data: data);

    return right(const LesionDto(surfaceArea: 0.9324321).toDomain());

    //return result.map((e) => LesionDto.fromJson(e.data!).toDomain());
  }

  @override
  int createPatient(Patient patient) {
    return localeResourcesService.putPatient(patient);
  }

  @override
  void createRecord(Record record) {
    localeResourcesService.putRecord(record);
  }

  @override
  Stream<List<Patient>> watchPatients() {
    return localeResourcesService.watchPatients();
  }

  @override
  Future<List<Record>> getRecords(int patientId) {
    return localeResourcesService.getRecords(patientId);
  }
}
