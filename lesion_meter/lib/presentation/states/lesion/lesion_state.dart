import 'package:camera/camera.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/failure/failure.dart';
import '../../../domain/models/lesion.dart';

part 'lesion_state.freezed.dart';

@freezed
class LesionState with _$LesionState {
  const factory LesionState({
    required bool isLoading,
    required List<XFile> imageFiles,
    required Option<Either<Failure, Lesion>> lesion,
  }) = _LesionState;

  factory LesionState.initial() {
    return LesionState(
      isLoading: false,
      imageFiles: [],
      lesion: none(),
    );
  }
}
