import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lesion_meter/domain/models/lesion.dart';

part 'lesion_dto.freezed.dart';
part 'lesion_dto.g.dart';

@freezed
class LesionDto with _$LesionDto {
  const factory LesionDto({
    @JsonKey(name: "surface_area") required double surfaceArea,
  }) = _LesionDto;

  const LesionDto._();

  factory LesionDto.fromJson(Map<String, dynamic> json) => _$LesionDtoFromJson(json);

  Lesion toDomain() {
    return Lesion(area: surfaceArea);
  }
}
