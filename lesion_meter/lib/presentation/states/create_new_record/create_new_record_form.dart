import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lesion_meter/constants/value_failure_messages.dart';

import '../../../core/models/value_failure/value_failure.dart';
import '../../../domain/models/gender.dart';

part 'create_new_record_form.freezed.dart';

@freezed
class CreateNewRecordForm with _$CreateNewRecordForm {
  const factory CreateNewRecordForm({
    required String name,
    required String surname,
    required Option<DateTime> birthDate,
    required Option<Gender> gender,
    required String weight,
    required String height,
    required Option<ValueFailure> nameFailure,
    required Option<ValueFailure> surnameFailure,
    required Option<ValueFailure> weightFailure,
    required Option<ValueFailure> heightFailure,
    required Option<ValueFailure> birthDateFailure,
    required Option<ValueFailure> genderFailure,
  }) = _CreateNewRecordForm;

  const CreateNewRecordForm._();

  factory CreateNewRecordForm.initial() {
    return CreateNewRecordForm(
      name: "",
      surname: "",
      birthDate: none(),
      gender: none(),
      weight: "",
      height: "",
      nameFailure: none(),
      surnameFailure: none(),
      weightFailure: none(),
      heightFailure: none(),
      birthDateFailure: some(const ValueFailure.invalidInput(emptyInputFailureMessage)),
      genderFailure: none(),
    );
  }

  bool get isValid =>
      nameFailure.isNone() &&
      surnameFailure.isNone() &&
      weightFailure.isNone() &&
      heightFailure.isNone() &&
      birthDateFailure.isNone() &&
      genderFailure.isNone();
}
