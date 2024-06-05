import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:lesion_meter/domain/models/patient.dart';
import 'package:lesion_meter/domain/models/record.dart';

import 'locale_resources_service.dart';

@LazySingleton(as: LocaleResourcesService)
final class LocaleResourcesServiceImpl implements LocaleResourcesService {
  final Isar isar;

  const LocaleResourcesServiceImpl({required this.isar});

  @override
  int putPatient(Patient patient) {
    return isar.writeTxnSync(() => isar.patients.putSync(patient));
  }

  @override
  void putRecord(Record record) {
    isar.writeTxnSync(() => isar.records.putSync(record));
  }

  @override
  Stream<List<Patient>> watchPatients() {
    return isar.patients.where().sortByUpdatedAt().watch(fireImmediately: true);
  }

  @override
  Future<List<Record>> getRecords(int patientId) =>
      isar.records.where().filter().patientIdEqualTo(patientId).sortByDateDesc().findAll();

  @override
  Future<void> export(String path) async {
    try {
      final patients = await isar.patients.where().exportJson();
      final records = await isar.records.where().exportJson();

      final data = {
        "patients": patients,
        "records": records,
      };

      final contents = jsonEncode(data);

      const downloadsPath = "/storage/emulated/0/Download/";

      final db = File("${downloadsPath}db.json");

      await db.writeAsString(contents);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> import(String data) async {
    try {
      final decoded = jsonDecode(data) as Map<String, dynamic>;

      final patients = decoded["patients"] as List;
      final records = decoded["records"] as List;

      await isar.writeTxn(() async {
        await isar.patients.importJson(patients.cast());
        await isar.records.importJson(records.cast());
      });
    } catch (e) {
      rethrow;
    }
  }
}
