import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lesion_meter/constants/colors.dart' as colors;
import 'package:lesion_meter/core/extensions/date_time_extensions.dart';
import 'package:lesion_meter/custom/custom_text_field.dart';
import 'package:lesion_meter/domain/models/patient.dart';
import 'package:lesion_meter/gen/assets.gen.dart';
import 'package:lesion_meter/presentation/providers/patients_provider.dart';

import '../../router/router.dart';

final _patientProvider = Provider.autoDispose<Patient>((ref) => throw UnimplementedError());

final _filterProvider = StateProvider.autoDispose((ref) => "");

@RoutePage()
class PatientsPage extends StatelessWidget {
  const PatientsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patients')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            const _Search(),
            SizedBox(height: 24.h),
            const _Patients(),
          ],
        ),
      ),
    );
  }
}

class _Search extends ConsumerWidget {
  const _Search();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(_filterProvider.notifier);

    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            hintText: "Search for patients",
            prefixIcon: Assets.icons.search.svg(width: 24.r, height: 24.r, fit: BoxFit.scaleDown),
            onChanged: (value) => notifier.state = value,
            onFieldSubmitted: (value) => notifier.state = value,
            textInputAction: TextInputAction.search,
          ),
        ),
        SizedBox(width: 12.w),
        Assets.icons.filter.svg(width: 24.r, height: 24.r),
      ],
    );
  }
}

class _Patients extends ConsumerWidget {
  const _Patients();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(patientsProvider);

    return asyncValue.maybeWhen(
      orElse: () => const Expanded(child: Center(child: CircularProgressIndicator())),
      data: (patients) {
        final filter = ref.watch(_filterProvider).toLowerCase();

        final filtered = patients.where((element) => element.fullName.toLowerCase().contains(filter)).toList();

        return Expanded(
          child: filtered.isEmpty
              ? const _EmptyState()
              : ListView.separated(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.only(bottom: 50.h),
                  itemBuilder: (context, index) => ProviderScope(
                    overrides: [_patientProvider.overrideWithValue(filtered[index])],
                    child: const _PatientItem(),
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  itemCount: filtered.length,
                ),
        );
      },
    );
  }
}

class _PatientItem extends ConsumerWidget {
  const _PatientItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final patient = ref.watch(_patientProvider);

    return GestureDetector(
      onTap: () => context.pushRoute(PatientDetailsRoute(patient: patient)),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: colors.bodyTextcolor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Container(
              height: 60.r,
              width: 60.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: colors.bodyTextcolor.withOpacity(0.4),
                  width: 2.r,
                ),
              ),
              alignment: Alignment.center,
              child: Icon(Icons.person, size: 32.r, color: colors.bodyTextcolor.withOpacity(0.4)),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${patient.name} ${patient.surname}", style: textTheme.bodyLarge),
                SizedBox(height: 4.h),
                Text(
                  "Last Updated: ${patient.updatedAt.ddMMyyyy}",
                  style: textTheme.bodySmall?.copyWith(color: textTheme.bodySmall?.color?.withOpacity(0.6)),
                ),
              ],
            ),
            const Spacer(),
            Assets.icons.chevronRight.svg(width: 24.r, height: 24.r),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 120.r,
            width: 120.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colors.bodyTextcolor.withOpacity(0.2), width: 2.r),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.people, size: 80.r, color: colors.bodyTextcolor.withOpacity(0.2)),
          ),
          SizedBox(height: 20.h),
          Text("No patients found", style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
