import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lesion_meter/domain/models/record.dart';

import '../../constants/colors.dart' as colors;
import '../../gen/assets.gen.dart';
import '../../router/router.dart';

final _recordProvider = Provider.autoDispose<Record>((ref) => throw UnimplementedError());

@RoutePage()
class RecordDetailsPage extends StatelessWidget implements AutoRouteWrapper {
  final Record record;

  const RecordDetailsPage({required this.record});

  @override
  Widget wrappedRoute(BuildContext context) {
    return ProviderScope(
      overrides: [_recordProvider.overrideWithValue(record)],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record Details')),
      body: CustomScrollView(
        slivers: [
          const _LesionInfo(),
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          const _ImagesHeader(),
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
          const _Images(),
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
          const _TriDViewHeader(),
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
          const _TriDView(),
        ],
      ),
    );
  }
}

class _LesionInfo extends ConsumerWidget {
  const _LesionInfo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = ref.watch(_recordProvider);

    final textTheme = Theme.of(context).textTheme;

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Surface Area:", style: textTheme.labelMedium),
            Text(record.lesion.area.toString(), style: textTheme.bodySmall),
            SizedBox(height: 16.h),
            Text("Releated area", style: textTheme.labelMedium),
            Text(record.relatedArea, style: textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _ImagesHeader extends StatelessWidget {
  const _ImagesHeader();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverToBoxAdapter(
        child: Text("Images", style: Theme.of(context).textTheme.labelMedium),
      ),
    );
  }
}

class _Images extends ConsumerWidget {
  const _Images();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = ref.watch(_recordProvider);

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverGrid.builder(
        itemCount: record.images.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.r,
          crossAxisSpacing: 10.r,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => context.pushRoute(
            ImagePreviewRoute(
              image: Image.memory(
                Uint8List.fromList(record.images[index].value!),
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              image: DecorationImage(
                filterQuality: FilterQuality.high,
                image: MemoryImage(Uint8List.fromList(record.images[index].value!)),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TriDViewHeader extends StatelessWidget {
  const _TriDViewHeader();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverToBoxAdapter(
        child: Text("3D View", style: Theme.of(context).textTheme.labelMedium),
      ),
    );
  }
}

class _TriDView extends StatelessWidget {
  const _TriDView();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 300.h,
          child: Flutter3DViewer(
            progressBarColor: colors.green,
            src: Assets.anims.model,
          ),
        ),
      ),
    );
  }
}
