// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_new_record_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateNewRecordState {
  CreateNewRecordForm get form => throw _privateConstructorUsedError;
  ValidationErrorVisibility get validationErrorVisibility =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateNewRecordStateCopyWith<CreateNewRecordState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateNewRecordStateCopyWith<$Res> {
  factory $CreateNewRecordStateCopyWith(CreateNewRecordState value,
          $Res Function(CreateNewRecordState) then) =
      _$CreateNewRecordStateCopyWithImpl<$Res, CreateNewRecordState>;
  @useResult
  $Res call(
      {CreateNewRecordForm form,
      ValidationErrorVisibility validationErrorVisibility});

  $CreateNewRecordFormCopyWith<$Res> get form;
  $ValidationErrorVisibilityCopyWith<$Res> get validationErrorVisibility;
}

/// @nodoc
class _$CreateNewRecordStateCopyWithImpl<$Res,
        $Val extends CreateNewRecordState>
    implements $CreateNewRecordStateCopyWith<$Res> {
  _$CreateNewRecordStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = null,
    Object? validationErrorVisibility = null,
  }) {
    return _then(_value.copyWith(
      form: null == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as CreateNewRecordForm,
      validationErrorVisibility: null == validationErrorVisibility
          ? _value.validationErrorVisibility
          : validationErrorVisibility // ignore: cast_nullable_to_non_nullable
              as ValidationErrorVisibility,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CreateNewRecordFormCopyWith<$Res> get form {
    return $CreateNewRecordFormCopyWith<$Res>(_value.form, (value) {
      return _then(_value.copyWith(form: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ValidationErrorVisibilityCopyWith<$Res> get validationErrorVisibility {
    return $ValidationErrorVisibilityCopyWith<$Res>(
        _value.validationErrorVisibility, (value) {
      return _then(_value.copyWith(validationErrorVisibility: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateNewRecordStateImplCopyWith<$Res>
    implements $CreateNewRecordStateCopyWith<$Res> {
  factory _$$CreateNewRecordStateImplCopyWith(_$CreateNewRecordStateImpl value,
          $Res Function(_$CreateNewRecordStateImpl) then) =
      __$$CreateNewRecordStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CreateNewRecordForm form,
      ValidationErrorVisibility validationErrorVisibility});

  @override
  $CreateNewRecordFormCopyWith<$Res> get form;
  @override
  $ValidationErrorVisibilityCopyWith<$Res> get validationErrorVisibility;
}

/// @nodoc
class __$$CreateNewRecordStateImplCopyWithImpl<$Res>
    extends _$CreateNewRecordStateCopyWithImpl<$Res, _$CreateNewRecordStateImpl>
    implements _$$CreateNewRecordStateImplCopyWith<$Res> {
  __$$CreateNewRecordStateImplCopyWithImpl(_$CreateNewRecordStateImpl _value,
      $Res Function(_$CreateNewRecordStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = null,
    Object? validationErrorVisibility = null,
  }) {
    return _then(_$CreateNewRecordStateImpl(
      form: null == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as CreateNewRecordForm,
      validationErrorVisibility: null == validationErrorVisibility
          ? _value.validationErrorVisibility
          : validationErrorVisibility // ignore: cast_nullable_to_non_nullable
              as ValidationErrorVisibility,
    ));
  }
}

/// @nodoc

class _$CreateNewRecordStateImpl extends _CreateNewRecordState {
  const _$CreateNewRecordStateImpl(
      {required this.form, required this.validationErrorVisibility})
      : super._();

  @override
  final CreateNewRecordForm form;
  @override
  final ValidationErrorVisibility validationErrorVisibility;

  @override
  String toString() {
    return 'CreateNewRecordState(form: $form, validationErrorVisibility: $validationErrorVisibility)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateNewRecordStateImpl &&
            (identical(other.form, form) || other.form == form) &&
            (identical(other.validationErrorVisibility,
                    validationErrorVisibility) ||
                other.validationErrorVisibility == validationErrorVisibility));
  }

  @override
  int get hashCode => Object.hash(runtimeType, form, validationErrorVisibility);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateNewRecordStateImplCopyWith<_$CreateNewRecordStateImpl>
      get copyWith =>
          __$$CreateNewRecordStateImplCopyWithImpl<_$CreateNewRecordStateImpl>(
              this, _$identity);
}

abstract class _CreateNewRecordState extends CreateNewRecordState {
  const factory _CreateNewRecordState(
          {required final CreateNewRecordForm form,
          required final ValidationErrorVisibility validationErrorVisibility}) =
      _$CreateNewRecordStateImpl;
  const _CreateNewRecordState._() : super._();

  @override
  CreateNewRecordForm get form;
  @override
  ValidationErrorVisibility get validationErrorVisibility;
  @override
  @JsonKey(ignore: true)
  _$$CreateNewRecordStateImplCopyWith<_$CreateNewRecordStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
