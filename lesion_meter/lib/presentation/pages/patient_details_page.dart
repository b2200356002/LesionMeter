import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lesion_meter/constants/colors.dart' as colors;
import 'package:lesion_meter/core/extensions/date_time_extensions.dart';
import 'package:lesion_meter/core/extensions/list_extensions.dart';
import 'package:lesion_meter/core/injections/locator.dart';
import 'package:lesion_meter/custom/custom_circular_progress_bar.dart';
import 'package:lesion_meter/domain/models/lesion.dart';
import 'package:lesion_meter/domain/models/patient.dart';
import 'package:lesion_meter/gen/assets.gen.dart';

import '../../router/router.dart';

final _patientProvider = Provider.autoDispose<Patient>((ref) => throw UnimplementedError());

final _selectedYearProvider = StateProvider.autoDispose((ref) => DateTime.now().year);

final _recordsProvider = FutureProvider.autoDispose(
  (ref) {
    final patient = ref.watch(_patientProvider);

    return ref.watch(skinRepositoryProvider).getRecords(patient.id!);
  },
  dependencies: [_patientProvider, skinRepositoryProvider],
);

@RoutePage()
class PatientDetailsPage extends ConsumerWidget implements AutoRouteWrapper {
  final Patient patient;

  const PatientDetailsPage({required this.patient});

  @override
  Widget wrappedRoute(BuildContext context) {
    return ProviderScope(
      overrides: [_patientProvider.overrideWithValue(patient)],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Patient Details"),
            pinned: true,
          ),
          const _PatientInfo(),
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          const _ChartHeader(),
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          const _Chart(),
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          const _RecordsHeader(),
          SliverToBoxAdapter(child: SizedBox(height: 8.h)),
          const _Records(),
        ],
      ),
    );
  }
}

class _PatientInfo extends ConsumerWidget {
  const _PatientInfo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patient = ref.watch(_patientProvider);

    final textTheme = Theme.of(context).textTheme;

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: colors.bodyTextcolor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  Container(
                    height: 60.r,
                    width: 60.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colors.bodyTextcolor.withOpacity(0.4),
                        width: 2.r,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.person, size: 32.r, color: colors.bodyTextcolor.withOpacity(0.4)),
                  ),
                  SizedBox(height: 12.h),
                  Text("${patient.name} ${patient.surname} (${patient.gender})", style: textTheme.bodyLarge),
                  SizedBox(height: 4.h),
                  Text(
                    "Created At: ${patient.createdAt.ddMMyyyy}",
                    style: textTheme.bodySmall?.copyWith(color: textTheme.bodySmall?.color?.withOpacity(0.6)),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Last Updated: ${patient.updatedAt.ddMMyyyy}",
                    style: textTheme.bodySmall?.copyWith(color: textTheme.bodySmall?.color?.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                _InfoContainer(title: "Weight", value: "${patient.weight.toInt()} kg"),
                SizedBox(width: 16.w),
                _InfoContainer(title: "Height", value: "${patient.height.toInt()} cm"),
                SizedBox(width: 16.w),
                _InfoContainer(title: "Age", value: patient.age),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoContainer extends StatelessWidget {
  final String title;
  final String value;

  const _InfoContainer({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
        decoration: BoxDecoration(
          color: colors.bodyTextcolor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: textTheme.labelSmall),
            SizedBox(height: 4.h),
            Text(value, style: textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _RecordsHeader extends StatelessWidget {
  const _RecordsHeader();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverToBoxAdapter(
        child: Text("Records", style: Theme.of(context).textTheme.labelMedium),
      ),
    );
  }
}

class _Records extends ConsumerWidget {
  const _Records();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final records = ref.watch(_recordsProvider);

    return records.when(
      data: (value) => SliverList.builder(
        itemCount: value.length,
        itemBuilder: (context, index) {
          final record = value.elementAt(index);

          return ListTile(
            onTap: () => context.pushRoute(RecordDetailsRoute(record: record, patient: ref.watch(_patientProvider))),
            shape: Border(bottom: BorderSide(color: colors.bodyTextcolor.withOpacity(0.1))),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            title: Text("Date: ${record.date.ddMMyyyy}"),
            titleTextStyle: Theme.of(context).textTheme.bodyMedium,
            trailing: Assets.icons.chevronRight.svg(width: 24.r, height: 24.r),
          );
        },
      ),
      error: (error, _) => SliverToBoxAdapter(child: Text(error.toString())),
      loading: () => const SliverToBoxAdapter(child: CustomCircularProgressIndicator()),
    );
  }
}

class _ChartHeader extends ConsumerWidget {
  const _ChartHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedYear = ref.watch(_selectedYearProvider);
    final records = ref.watch(_recordsProvider);

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            Text("Average Lesion Area", style: Theme.of(context).textTheme.labelMedium),
            const Spacer(),
            records.maybeWhen(
              orElse: () => const SizedBox(),
              data: (records) => Expanded(
                child: DropdownButtonFormField<int>(
                  elevation: 4,
                  style: Theme.of(context).dropdownMenuTheme.textStyle,
                  decoration: InputDecoration(isDense: true, contentPadding: EdgeInsets.all(8.r)),
                  hint: const Text("Year"),
                  value: selectedYear,
                  items: records
                      .map((e) => e.date.year)
                      .toSet()
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.toString(),
                            style: Theme.of(context).dropdownMenuTheme.textStyle,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => ref.watch(_selectedYearProvider.notifier).state = value!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chart extends ConsumerWidget {
  const _Chart();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final records = ref.watch(_recordsProvider);
    final selectedYear = ref.watch(_selectedYearProvider);

    return records.when(
      data: (value) {
        final lastYearDatas = records.value!.where((element) => element.date.year == selectedYear).toList();
        final lesionsByMonth = <List<Lesion>>[];

        for (var i = 1; i <= 12; i++) {
          final monthRecords = lastYearDatas.where((element) => element.date.month == i).toList();
          final lesions = monthRecords.map((e) => e.lesion).toList();

          lesionsByMonth.add(lesions);
        }

        final avgs = lesionsByMonth.mapWithIndex((e, index) => e.map((e) => e.area!).avg.roundToDouble()).toList();

        return SliverPadding(
          padding: EdgeInsets.only(right: 16.w),
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: 250.h,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        dashArray: [6, 6],
                        color: colors.green,
                        strokeWidth: 1.r,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                    bottomTitles: AxisTitles(
                      axisNameSize: 30.r,
                      axisNameWidget: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Month",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30.r,
                        getTitlesWidget: (value, meta) => bottomTitleWidgets(value, meta, context),
                      ),
                    ),
                    leftTitles: AxisTitles(
                      axisNameSize: 30.r,
                      axisNameWidget: Text(
                        "Area (cm²)",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: calculateReversedSize(context, ref, avgs.max),
                        getTitlesWidget: (value, meta) => leftTitleWidgets(value, meta, context),
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 1,
                  maxX: 12,
                  minY: 0,
                  maxY: avgs.max,
                  lineBarsData: [
                    LineChartBarData(
                      spots: lesionsByMonth
                          .mapWithIndex((e, index) => FlSpot(index + 1, e.map((e) => e.area!).avg))
                          .toList(),
                      isCurved: true,
                      color: colors.yellow,
                      barWidth: 2.r,
                      isStrokeCapRound: true,
                      isStrokeJoinRound: true,
                      preventCurveOverShooting: true,
                      preventCurveOvershootingThreshold: 0,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [colors.yellow.withOpacity(0.3), colors.green.withOpacity(0)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      error: (error, _) => SliverToBoxAdapter(child: Text(error.toString())),
      loading: () => const SliverToBoxAdapter(child: CustomCircularProgressIndicator()),
    );
  }

  double calculateReversedSize(BuildContext context, WidgetRef ref, double max) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: max.toStringAsFixed(1),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.width * 1.6;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium;

    final text = Text(value.toStringAsFixed(0), style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta, BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium;

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        value.toStringAsFixed(1),
        style: style,
      ),
    );
  }
}
