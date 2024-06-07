import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lesion_meter/constants/colors.dart' as colors;
import 'package:lesion_meter/gen/assets.gen.dart';
import 'package:lesion_meter/presentation/providers/lesion_provider.dart';
import 'package:lesion_meter/presentation/widgets/multimedia_sources_sheet.dart';
import 'package:lesion_meter/presentation/widgets/transfer_datas_sheet.dart';
import 'package:lesion_meter/router/router.dart';

import '../../common/loading_overlay.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(lesionProvider, (prev, next) {
      if (next.isLoading) {
        LoadingScreen().show(context: context);
      } else {
        LoadingScreen().hide();
      }
    });

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          SizedBox(height: 80.h),
          const _Logo(),
          SizedBox(height: 40.h),
          const _Welcome(),
          SizedBox(height: 40.h),
          const _DataAnalysis(),
          SizedBox(height: 56.h),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Assets.icons.appIcon.svg(width: 52.r, height: 52.r),
        SizedBox(height: 10.h),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "Lesion ", style: textTheme.displaySmall),
              TextSpan(
                text: "Meter",
                style: textTheme.titleSmall?.copyWith(color: colors.green, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Welcome extends ConsumerWidget {
  const _Welcome();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text("Welcome to Lesion Meter!", style: textTheme.labelMedium),
        SizedBox(height: 20.h),
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: colors.bodyTextcolor.withOpacity(0.08),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160.h,
                decoration: BoxDecoration(
                  image: DecorationImage(image: Assets.images.welcome.provider()),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 12.h),
              Text("Scan and measure lesions", style: textTheme.labelMedium),
              SizedBox(height: 12.h),
              Text(
                "Lesion Meter is a cutting-edge mobile application that revolutionizes "
                "skin health by providing accurate, efficient, and easy-to-use lesion measurement. "
                "With our advanced algorithms and user-friendly interface, you can accurately measure "
                "the area and volume of skin lesions in just a few simple steps.",
                style: textTheme.bodyMedium?.copyWith(color: colors.textColor),
              ),
              SizedBox(height: 12.h),
              FilledButton(
                onPressed: () => const MultimediaSourcesSheet().show(context),
                child: const Text("Start Scanning"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DataAnalysis extends ConsumerWidget {
  const _DataAnalysis();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Data and Analysis", style: textTheme.labelMedium),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: _DataAnalysisItem(
                icon: Assets.icons.users,
                title: "Patients",
                onTap: () => context.pushRoute(const PatientsRoute()),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _DataAnalysisItem(
                icon: Assets.icons.transfer,
                title: "Transfer Datas",
                onTap: () => const TransferDatasSheet().show(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DataAnalysisItem extends StatelessWidget {
  final VoidCallback? onTap;
  final SvgGenImage icon;
  final String title;

  const _DataAnalysisItem({
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: colors.green.withOpacity(0.1),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: colors.green.withOpacity(0.2),
              ),
              child: Center(child: icon.svg(height: 24.r, width: 24.r)),
            ),
            SizedBox(width: 8.w),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
