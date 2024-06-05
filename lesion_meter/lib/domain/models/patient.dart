import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:lesion_meter/domain/models/gender.dart';

part 'patient.g.dart';

@Collection(inheritance: false)
final class Patient extends Equatable {
  final Id? id;
  final String name;
  final String surname;
  final DateTime birthDate;
  @Enumerated(EnumType.ordinal, "gender")
  final Gender gender;
  final double weight;
  final double height;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get fullName => "$name $surname";

  String get age {
    final now = DateTime.now();
    final age = now.year - birthDate.year;
    final isBeforeBirthday = now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day);

    return isBeforeBirthday ? (age - 1).toString() : age.toString();
  }

  Patient({
    required this.name,
    required this.surname,
    required this.birthDate,
    required this.gender,
    required this.weight,
    required this.height,
    this.id,
  })  : createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  @override
  @ignore
  List<Object?> get props => [id, name, surname];
}
