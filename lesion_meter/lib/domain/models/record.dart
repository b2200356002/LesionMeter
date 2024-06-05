import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:lesion_meter/domain/models/lesion.dart';
import 'package:lesion_meter/domain/models/uint8list_image.dart';

part 'record.g.dart';

typedef ByteList = List<int>;

@Collection(inheritance: false)
final class Record extends Equatable {
  final Id id;
  final int patientId;
  final DateTime date;
  final List<Uint8ListImage> images;
  final Lesion lesion;
  final String relatedArea;

  Record({
    required this.images,
    required this.lesion,
    required this.patientId,
    required this.relatedArea,
  })  : id = Isar.autoIncrement,
        date = DateTime.now();

  @override
  @ignore
  List<Object?> get props => [id];
}
