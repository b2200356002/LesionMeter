import 'package:freezed_annotation/freezed_annotation.dart';

part 'multimedia_source.freezed.dart';

@freezed
class MultimediaSource with _$MultimediaSource {
  const factory MultimediaSource.gallery() = _Gallery;
  const factory MultimediaSource.camera() = _Camera;
}
