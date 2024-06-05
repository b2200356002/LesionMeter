import 'package:camera/camera.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lesion_meter/core/models/failure/failure.dart';
import 'package:lesion_meter/domain/models/lesion.dart';
import 'package:lesion_meter/domain/models/patient.dart';
import 'package:lesion_meter/domain/models/record.dart';

abstract interface class SkinRepository {
  Future<Either<Failure, Lesion>> scan({required List<XFile> imageFiles});
  int createPatient(Patient patient);
  void createRecord(Record record);
  Stream<List<Patient>> watchPatients();
  Future<List<Record>> getRecords(int patientId);
}
