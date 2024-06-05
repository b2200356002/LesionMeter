import 'package:lesion_meter/domain/models/patient.dart';
import 'package:lesion_meter/domain/models/record.dart';

abstract class LocaleResourcesService {
  /// Create a new patient. Returns the ID of the created patient.
  int putPatient(Patient patient);
  void putRecord(Record record);
  Stream<List<Patient>> watchPatients();
  Future<List<Record>> getRecords(int patientId);

  Future<void> export(String path);

  /// Import data from a JSON string.
  Future<void> import(String data);
}
