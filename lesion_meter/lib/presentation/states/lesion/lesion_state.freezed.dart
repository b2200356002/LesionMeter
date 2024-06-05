// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesion_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LesionState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<XFile> get imageFiles => throw _privateConstructorUsedError;
  Option<Either<Failure, Lesion>> get lesion =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LesionStateCopyWith<LesionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LesionStateCopyWith<$Res> {
  factory $LesionStateCopyWith(
          LesionState value, $Res Function(LesionState) then) =
      _$LesionStateCopyWithImpl<$Res, LesionState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<XFile> imageFiles,
      Option<Either<Failure, Lesion>> lesion});
}

/// @nodoc
class _$LesionStateCopyWithImpl<$Res, $Val extends LesionState>
    implements $LesionStateCopyWith<$Res> {
  _$LesionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? imageFiles = null,
    Object? lesion = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      imageFiles: null == imageFiles
          ? _value.imageFiles
          : imageFiles // ignore: cast_nullable_to_non_nullable
              as List<XFile>,
      lesion: null == lesion
          ? _value.lesion
          : lesion // ignore: cast_nullable_to_non_nullable
              as Option<Either<Failure, Lesion>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LesionStateImplCopyWith<$Res>
    implements $LesionStateCopyWith<$Res> {
  factory _$$LesionStateImplCopyWith(
          _$LesionStateImpl value, $Res Function(_$LesionStateImpl) then) =
      __$$LesionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<XFile> imageFiles,
      Option<Either<Failure, Lesion>> lesion});
}

/// @nodoc
class __$$LesionStateImplCopyWithImpl<$Res>
    extends _$LesionStateCopyWithImpl<$Res, _$LesionStateImpl>
    implements _$$LesionStateImplCopyWith<$Res> {
  __$$LesionStateImplCopyWithImpl(
      _$LesionStateImpl _value, $Res Function(_$LesionStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? imageFiles = null,
    Object? lesion = null,
  }) {
    return _then(_$LesionStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      imageFiles: null == imageFiles
          ? _value._imageFiles
          : imageFiles // ignore: cast_nullable_to_non_nullable
              as List<XFile>,
      lesion: null == lesion
          ? _value.lesion
          : lesion // ignore: cast_nullable_to_non_nullable
              as Option<Either<Failure, Lesion>>,
    ));
  }
}

/// @nodoc

class _$LesionStateImpl implements _LesionState {
  const _$LesionStateImpl(
      {required this.isLoading,
      required final List<XFile> imageFiles,
      required this.lesion})
      : _imageFiles = imageFiles;

  @override
  final bool isLoading;
  final List<XFile> _imageFiles;
  @override
  List<XFile> get imageFiles {
    if (_imageFiles is EqualUnmodifiableListView) return _imageFiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageFiles);
  }

  @override
  final Option<Either<Failure, Lesion>> lesion;

  @override
  String toString() {
    return 'LesionState(isLoading: $isLoading, imageFiles: $imageFiles, lesion: $lesion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LesionStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._imageFiles, _imageFiles) &&
            (identical(other.lesion, lesion) || other.lesion == lesion));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_imageFiles), lesion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LesionStateImplCopyWith<_$LesionStateImpl> get copyWith =>
      __$$LesionStateImplCopyWithImpl<_$LesionStateImpl>(this, _$identity);
}

abstract class _LesionState implements LesionState {
  const factory _LesionState(
          {required final bool isLoading,
          required final List<XFile> imageFiles,
          required final Option<Either<Failure, Lesion>> lesion}) =
      _$LesionStateImpl;

  @override
  bool get isLoading;
  @override
  List<XFile> get imageFiles;
  @override
  Option<Either<Failure, Lesion>> get lesion;
  @override
  @JsonKey(ignore: true)
  _$$LesionStateImplCopyWith<_$LesionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
