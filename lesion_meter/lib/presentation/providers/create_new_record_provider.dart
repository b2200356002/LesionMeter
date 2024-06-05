import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lesion_meter/core/injections/locator.dart';
import 'package:lesion_meter/domain/models/gender.dart';
import 'package:lesion_meter/domain/models/patient.dart';
import 'package:lesion_meter/domain/models/record.dart';
import 'package:lesion_meter/domain/models/uint8list_image.dart';
import 'package:lesion_meter/presentation/pages/camera_page.dart';

import '../../core/models/validation_error_visibility/validation_error_visibility.dart';
import '../../utils/validators.dart';
import '../states/create_new_record/create_new_record_state.dart';
import 'lesion_provider.dart';

class _CreateNewRecordNotifier extends AutoDisposeNotifier<CreateNewRecordState> {
  @override
  CreateNewRecordState build() {
    return CreateNewRecordState.initial();
  }

  void create() {
    state = state.copyWith(validationErrorVisibility: const ValidationErrorVisibility.show());

    if (state.form.isValid) {
      final skinRepository = ref.read(skinRepositoryProvider);

      final patient = Patient(
        name: state.form.name,
        surname: state.form.surname,
        birthDate: state.form.birthDate.toNullable()!,
        weight: double.parse(state.form.weight),
        height: double.parse(state.form.height),
        gender: state.form.gender.toNullable()!,
      );

      final patientId = skinRepository.createPatient(patient);

      final lesionState = ref.read(lesionProvider);

      final record = Record(
        images: lesionState.imageFiles.map((e) => Uint8ListImage(File(e.path).readAsBytesSync())).toList(),
        lesion: lesionState.lesion.toNullable()!.toNullable()!,
        patientId: patientId,
        relatedArea: ref.watch(relatedAreaProvider),
      );

      skinRepository.createRecord(record);
    }
  }

  void addTo(Patient patient) {
    final lesionState = ref.read(lesionProvider);

    final record = Record(
      images: lesionState.imageFiles.map((e) => Uint8ListImage(File(e.path).readAsBytesSync())).toList(),
      lesion: lesionState.lesion.toNullable()!.toNullable()!,
      patientId: patient.id!,
      relatedArea: ref.watch(relatedAreaProvider),
    );

    ref.read(skinRepositoryProvider).createRecord(record);
  }

  void onNameChanged(String? value) {
    state = state.copyWith.form(
      name: value ?? "",
      nameFailure: validateEmptiness(value ?? ""),
    );
  }

  void onSurnameChanged(String? value) {
    state = state.copyWith.form(
      surname: value ?? "",
      surnameFailure: validateEmptiness(value ?? ""),
    );
  }

  void onBirthDateChanged(DateTime value) {
    state = state.copyWith.form(
      birthDate: some(value),
      birthDateFailure: none(),
    );
  }

  void onWeightChanged(String? value) {
    state = state.copyWith.form(
      weight: value ?? "",
      weightFailure: validateEmptiness(value ?? ""),
    );
  }

  void onHeightChanged(String? value) {
    state = state.copyWith.form(
      height: value ?? "",
      heightFailure: validateEmptiness(value ?? ""),
    );
  }

  void onGenderChanged(Gender? value) {
    state = state.copyWith.form(
      gender: optionOf(value),
      genderFailure: validateEmptiness(value == null ? "" : value.toString()),
    );
  }
}

final createNewRecordProvider =
    NotifierProvider.autoDispose<_CreateNewRecordNotifier, CreateNewRecordState>(_CreateNewRecordNotifier.new);
