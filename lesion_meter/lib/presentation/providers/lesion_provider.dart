import 'package:camera/camera.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/injections/locator.dart';
import '../states/lesion/lesion_state.dart';

class _LesionNotifier extends AutoDisposeNotifier<LesionState> {
  @override
  LesionState build() => LesionState.initial();

  Future<void> scan(List<XFile> imageFiles) async {
    state = state.copyWith(isLoading: true, imageFiles: imageFiles);

    final result = await ref.read(skinRepositoryProvider).scan(imageFiles: imageFiles);

    state = state.copyWith(lesion: some(result));
  }

  Future<void> pickImagesFromGallery() async {
    state = state.copyWith(isLoading: true);

    final imageFiles = await ref.read(multimediaProvider).pickMultiImage();

    state = state.copyWith(isLoading: false, imageFiles: imageFiles);
  }
}

final lesionProvider = NotifierProvider.autoDispose<_LesionNotifier, LesionState>(_LesionNotifier.new);
