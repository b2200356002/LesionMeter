import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lesion_meter/presentation/providers/lesion_provider.dart';
import 'package:lesion_meter/router/router.dart';

import '../../custom/custom_text_field.dart';
import '../pages/camera_page.dart';

class MultimediaSourcesSheet extends StatelessWidget {
  const MultimediaSourcesSheet();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Camera(),
        Divider(),
        _Gallery(),
      ],
    );
  }

  Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (context) => this,
    );
  }
}

class _Camera extends ConsumerWidget {
  const _Camera();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.camera),
      title: const Text("Camera"),
      onTap: () => onTap(context),
    );
  }

  void onTap(BuildContext context) {
    context
      ..maybePop()
      ..pushRoute(const CameraRoute());
  }
}

class _Gallery extends ConsumerWidget {
  const _Gallery();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.photo),
      title: const Text("Gallery"),
      onTap: () => onTap(context, ref),
    );
  }

  Future<void> onTap(BuildContext context, WidgetRef ref) async {
    final maybePop = context.maybePop;

    await ref.read(lesionProvider.notifier).pickImagesFromGallery();

    final selectedImages = ref.read(lesionProvider).imageFiles;

    await maybePop();

    if (selectedImages.isEmpty) {
      return;
    }

    if (context.mounted) const _Area().show(context);
  }
}

class _Area extends ConsumerWidget {
  const _Area();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(relatedAreaProvider.notifier);
    final state = ref.watch(relatedAreaProvider);

    return SimpleDialog(
      clipBehavior: Clip.hardEdge,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      children: [
        Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              CustomTextField(
                hintText: "Related area",
                onChanged: (value) => notifier.state = value,
                onFieldSubmitted: (value) => notifier.state = value,
                textInputAction: TextInputAction.done,
                initialValue: state,
              ),
              SizedBox(height: 24.h),
              FilledButton(
                onPressed: state.isEmpty ? null : () => onPressed(context, ref),
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onPressed(BuildContext context, WidgetRef ref) {
    ref.read(lesionProvider.notifier).scan(ref.read(lesionProvider).imageFiles);

    context
      ..router.popForced()
      ..pushRoute(const RecordRoute());
  }

  Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => this,
    );
  }
}
