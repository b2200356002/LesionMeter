import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lesion_meter/constants/colors.dart' as colors;
import 'package:lesion_meter/core/extensions/date_time_extensions.dart';
import 'package:lesion_meter/custom/custom_dialog.dart';
import 'package:lesion_meter/custom/custom_snackbar.dart';
import 'package:lesion_meter/custom/custom_text_field.dart';
import 'package:lesion_meter/domain/models/gender.dart';

import '../providers/create_new_record_provider.dart';

final formKeyProvider = Provider.autoDispose((ref) => GlobalKey<FormState>());

@RoutePage()
class CreateRecordPage extends ConsumerWidget {
  const CreateRecordPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Create Record')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: ref.watch(formKeyProvider),
          autovalidateMode: ref.watch(createNewRecordProvider.select((value) => value.validationErrorVisibility)).when(
                hide: () => AutovalidateMode.disabled,
                show: () => AutovalidateMode.always,
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Name(),
              SizedBox(height: 16.h),
              const _Surname(),
              SizedBox(height: 16.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Weight(),
                  SizedBox(width: 8.w),
                  const _Height(),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _BirthDate(),
                  SizedBox(width: 8.w),
                  const _Gender(),
                ],
              ),
              const Spacer(),
              const _Buttons(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _Name extends ConsumerWidget {
  const _Name();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(createNewRecordProvider.notifier);
    final state = ref.watch(createNewRecordProvider);

    return CustomTextField(
      hintText: "Name",
      onChanged: notifier.onNameChanged,
      onSaved: notifier.onNameChanged,
      onFieldSubmitted: notifier.onNameChanged,
      validator: (_) => ref.read(createNewRecordProvider).form.nameFailure.toNullable()?.message,
      initialValue: state.form.name,
    );
  }
}

class _Surname extends ConsumerWidget {
  const _Surname();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(createNewRecordProvider.notifier);
    final state = ref.watch(createNewRecordProvider);

    return CustomTextField(
      hintText: "Surname",
      onChanged: notifier.onSurnameChanged,
      onSaved: notifier.onSurnameChanged,
      onFieldSubmitted: notifier.onSurnameChanged,
      validator: (_) => ref.read(createNewRecordProvider).form.surnameFailure.toNullable()?.message,
      initialValue: state.form.surname,
    );
  }
}

class _Weight extends ConsumerWidget {
  const _Weight();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(createNewRecordProvider.notifier);
    final state = ref.watch(createNewRecordProvider);

    return Expanded(
      child: CustomTextField(
        hintText: "Weigth (kg)",
        onChanged: notifier.onWeightChanged,
        onSaved: notifier.onWeightChanged,
        onFieldSubmitted: notifier.onWeightChanged,
        textInputType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
        validator: (_) => ref.read(createNewRecordProvider).form.weightFailure.toNullable()?.message,
        initialValue: state.form.weight,
      ),
    );
  }
}

class _Height extends ConsumerWidget {
  const _Height();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(createNewRecordProvider.notifier);
    final state = ref.watch(createNewRecordProvider);

    return Expanded(
      child: CustomTextField(
        hintText: "Heigth (cm)",
        onChanged: notifier.onHeightChanged,
        onSaved: notifier.onHeightChanged,
        onFieldSubmitted: notifier.onHeightChanged,
        textInputType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
        validator: (_) => ref.read(createNewRecordProvider).form.heightFailure.toNullable()?.message,
        initialValue: state.form.height,
      ),
    );
  }
}

class _BirthDate extends ConsumerWidget {
  const _BirthDate();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final hintStyle = theme.inputDecorationTheme.hintStyle;

    final birthDate = ref.watch(createNewRecordProvider).form.birthDate;

    return Expanded(
      child: OutlinedButton.icon(
        onPressed: () => onPressed(context, ref),
        icon: const Icon(Icons.calendar_month_rounded),
        style: OutlinedButton.styleFrom(
          padding: theme.inputDecorationTheme.contentPadding,
          alignment: Alignment.centerLeft,
          side: BorderSide(color: colors.bodyTextcolor.withOpacity(0.4), width: 1.r),
          textStyle: hintStyle,
          foregroundColor: hintStyle?.color,
        ),
        label: Text(
          birthDate.toNullable()?.ddMMyyyy ?? "Birth Date",
          style: birthDate.fold(() => hintStyle, (t) => theme.textTheme.bodyLarge),
        ),
      ),
    );
  }

  Future<void> onPressed(BuildContext context, WidgetRef ref) async {
    final now = DateTime.now();

    final selectedDate = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: ref.watch(createNewRecordProvider).form.birthDate.getOrElse(() => now),
      firstDate: DateTime(1930),
      lastDate: now,
    );

    if (selectedDate != null) {
      ref.read(createNewRecordProvider.notifier).onBirthDateChanged(selectedDate);
    }
  }
}

class _Gender extends ConsumerWidget {
  const _Gender();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(createNewRecordProvider.notifier);

    final theme = Theme.of(context);

    final hintStyle = theme.inputDecorationTheme.hintStyle;

    return Expanded(
      child: DropdownButtonFormField(
        style: theme.textTheme.bodyLarge,
        validator: (_) => ref.read(createNewRecordProvider).form.genderFailure.toNullable()?.message,
        onSaved: notifier.onGenderChanged,
        items: const [
          DropdownMenuItem(value: Gender.male, child: Text("Male")),
          DropdownMenuItem(value: Gender.female, child: Text("Female")),
        ],
        onChanged: notifier.onGenderChanged,
        hint: Text("Gender", style: hintStyle),
      ),
    );
  }

  Future<void> onPressed(BuildContext context, WidgetRef ref) async {
    final now = DateTime.now();

    final selectedDate = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: ref.watch(createNewRecordProvider).form.birthDate.getOrElse(() => now),
      firstDate: now,
      lastDate: now,
    );

    if (selectedDate != null) {
      ref.read(createNewRecordProvider.notifier).onBirthDateChanged(selectedDate);
    }
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          const Expanded(child: _CancelButton()),
          SizedBox(width: 8.w),
          const Expanded(child: _SaveButton()),
        ],
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: context.maybePop,
      child: const Text('Cancel'),
    );
  }
}

class _SaveButton extends ConsumerWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton(
      onPressed: () => onPressed(context, ref),
      child: const Text('Save'),
    );
  }

  void onPressed(BuildContext context, WidgetRef ref) {
    final formKey = ref.read(formKeyProvider);

    formKey.currentState!.save();

    ref.read(createNewRecordProvider.notifier).create();

    if (formKey.currentState!.validate()) {
      ref.read(createNewRecordProvider).form.birthDateFailure.fold(
        () {
          CustomSnackBar(title: "Record created").show(context);

          context.router.popUntilRoot();
        },
        (t) => const CustomDialog.failure(title: "Please select a birth date").show(context),
      );
    }
  }
}
