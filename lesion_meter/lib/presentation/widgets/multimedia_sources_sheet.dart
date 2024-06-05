import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lesion_meter/presentation/providers/lesion_provider.dart';
import 'package:lesion_meter/router/router.dart';

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

    maybePop();

    if (selectedImages.isEmpty) {
      return;
    }

    if (context.mounted) context.pushRoute(const RecordRoute());
  }
}
