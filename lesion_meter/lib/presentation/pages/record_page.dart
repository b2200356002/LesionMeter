import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lesion_meter/presentation/providers/lesion_provider.dart';
import 'package:lesion_meter/presentation/widgets/patients_bottom_sheet.dart';
import 'package:lesion_meter/router/router.dart';

@RoutePage()
class RecordPage extends StatelessWidget {
  const RecordPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Create Record')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Images(),
            SizedBox(height: 24.h),
            const _Lesion(),
            const Spacer(),
            const _Buttons(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

class _Images extends ConsumerWidget {
  const _Images();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(lesionProvider.select((value) => value.imageFiles)).map((e) => File(e.path)).toList();

    if (images.length == 1) {
      return GestureDetector(
        onTap: () => context.pushRoute(
          ImagePreviewRoute(
            image: Image.file(
              images.first,
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain,
            ),
            tag: images.first.path,
          ),
        ),
        child: Hero(
          tag: images.first.path,
          child: Container(
            height: 160.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              image: DecorationImage(image: FileImage(images.first), fit: BoxFit.cover),
            ),
          ),
        ),
      );
    }

    return Expanded(
      flex: images.length > 2 ? 7 : 1,
      child: GridView.builder(
        itemCount: images.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.r,
          crossAxisSpacing: 10.r,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => context.pushRoute(
            ImagePreviewRoute(
              image: Image.file(
                images[index],
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
              ),
              tag: images[index].path,
            ),
          ),
          child: Hero(
            tag: images[index].path,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                image: DecorationImage(image: FileImage(images[index]), fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Lesion extends ConsumerWidget {
  const _Lesion();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lesion = ref.watch(lesionProvider.select((value) => value.lesion));

    final textTheme = Theme.of(context).textTheme;

    return lesion.fold(
      SizedBox.new,
      (t) => t.fold(
        (l) => const SizedBox(),
        (r) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Surface Area:", style: textTheme.labelMedium),
            Text(r.area.toString(), style: textTheme.bodySmall),
            SizedBox(height: 16.h),
            Text("Releated Area:", style: textTheme.labelMedium),
            //TODO add related area for gallery option
            Text("Kol", style: textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          OutlinedButton(
            onPressed: () => context.pushRoute(const CreateRecordRoute()),
            child: const Text("Create New Record"),
          ),
          SizedBox(height: 16.h),
          FilledButton(
            onPressed: () => const PatientsBottomSheet().show(context),
            child: const Text("Add to Existing Record"),
          ),
        ],
      ),
    );
  }
}
