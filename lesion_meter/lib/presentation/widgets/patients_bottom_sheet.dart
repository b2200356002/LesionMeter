import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lesion_meter/constants/colors.dart' as colors;
import 'package:lesion_meter/core/extensions/date_time_extensions.dart';

import '../../domain/models/patient.dart';
import '../../gen/assets.gen.dart';
import '../providers/create_new_record_provider.dart';
import '../providers/patients_provider.dart';

final _patientProvider = Provider.autoDispose<Patient>((ref) => throw UnimplementedError());

class PatientsBottomSheet extends ConsumerWidget {
  const PatientsBottomSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(patientsProvider);

    return asyncValue.maybeWhen(
      orElse: () => const Center(child: CircularProgressIndicator()),
      data: (patients) => ListView.separated(
        padding: EdgeInsets.only(bottom: 50.h, left: 16.w, right: 16.w),
        itemBuilder: (context, index) => ProviderScope(
          overrides: [_patientProvider.overrideWithValue(patients[index])],
          child: const _PatientItem(),
        ),
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemCount: patients.length,
      ),
    );
  }

  Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => const PatientsBottomSheet(),
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
      onTap: () => onTap(context, ref, patient: patient),
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
                color: colors.bodyTextcolor,
              ),
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

  void onTap(BuildContext context, WidgetRef ref, {required Patient patient}) {
    ref.read(createNewRecordProvider.notifier).addTo(patient);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Record created')));

    context.router.popUntilRoot();
  }
}
