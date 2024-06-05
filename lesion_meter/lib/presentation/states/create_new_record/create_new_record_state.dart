import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lesion_meter/presentation/states/create_new_record/create_new_record_form.dart';

import '../../../core/models/validation_error_visibility/validation_error_visibility.dart';

part 'create_new_record_state.freezed.dart';

@freezed
class CreateNewRecordState with _$CreateNewRecordState {
  const factory CreateNewRecordState({
    required CreateNewRecordForm form,
    required ValidationErrorVisibility validationErrorVisibility,
  }) = _CreateNewRecordState;

  const CreateNewRecordState._();

  factory CreateNewRecordState.initial() {
    return CreateNewRecordState(
      form: CreateNewRecordForm.initial(),
      validationErrorVisibility: const ValidationErrorVisibility.hide(),
    );
  }
}
