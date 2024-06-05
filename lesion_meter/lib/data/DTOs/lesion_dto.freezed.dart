// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesion_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LesionDto _$LesionDtoFromJson(Map<String, dynamic> json) {
  return _LesionDto.fromJson(json);
}

/// @nodoc
mixin _$LesionDto {
  @JsonKey(name: "surface_area")
  double get surfaceArea => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LesionDtoCopyWith<LesionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LesionDtoCopyWith<$Res> {
  factory $LesionDtoCopyWith(LesionDto value, $Res Function(LesionDto) then) =
      _$LesionDtoCopyWithImpl<$Res, LesionDto>;
  @useResult
  $Res call({@JsonKey(name: "surface_area") double surfaceArea});
}

/// @nodoc
class _$LesionDtoCopyWithImpl<$Res, $Val extends LesionDto>
    implements $LesionDtoCopyWith<$Res> {
  _$LesionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? surfaceArea = null,
  }) {
    return _then(_value.copyWith(
      surfaceArea: null == surfaceArea
          ? _value.surfaceArea
          : surfaceArea // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LesionDtoImplCopyWith<$Res>
    implements $LesionDtoCopyWith<$Res> {
  factory _$$LesionDtoImplCopyWith(
          _$LesionDtoImpl value, $Res Function(_$LesionDtoImpl) then) =
      __$$LesionDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "surface_area") double surfaceArea});
}

/// @nodoc
class __$$LesionDtoImplCopyWithImpl<$Res>
    extends _$LesionDtoCopyWithImpl<$Res, _$LesionDtoImpl>
    implements _$$LesionDtoImplCopyWith<$Res> {
  __$$LesionDtoImplCopyWithImpl(
      _$LesionDtoImpl _value, $Res Function(_$LesionDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? surfaceArea = null,
  }) {
    return _then(_$LesionDtoImpl(
      surfaceArea: null == surfaceArea
          ? _value.surfaceArea
          : surfaceArea // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LesionDtoImpl extends _LesionDto {
  const _$LesionDtoImpl(
      {@JsonKey(name: "surface_area") required this.surfaceArea})
      : super._();

  factory _$LesionDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LesionDtoImplFromJson(json);

  @override
  @JsonKey(name: "surface_area")
  final double surfaceArea;

  @override
  String toString() {
    return 'LesionDto(surfaceArea: $surfaceArea)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LesionDtoImpl &&
            (identical(other.surfaceArea, surfaceArea) ||
                other.surfaceArea == surfaceArea));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, surfaceArea);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LesionDtoImplCopyWith<_$LesionDtoImpl> get copyWith =>
      __$$LesionDtoImplCopyWithImpl<_$LesionDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LesionDtoImplToJson(
      this,
    );
  }
}

abstract class _LesionDto extends LesionDto {
  const factory _LesionDto(
          {@JsonKey(name: "surface_area") required final double surfaceArea}) =
      _$LesionDtoImpl;
  const _LesionDto._() : super._();

  factory _LesionDto.fromJson(Map<String, dynamic> json) =
      _$LesionDtoImpl.fromJson;

  @override
  @JsonKey(name: "surface_area")
  double get surfaceArea;
  @override
  @JsonKey(ignore: true)
  _$$LesionDtoImplCopyWith<_$LesionDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
