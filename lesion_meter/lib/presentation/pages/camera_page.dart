import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lesion_meter/presentation/providers/lesion_provider.dart';
import 'package:lesion_meter/router/router.dart';

import '../../custom/custom_text_field.dart';

@RoutePage()
class CameraPage extends ConsumerStatefulWidget {
  const CameraPage();

  @override
  ConsumerState<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends ConsumerState<CameraPage> with TickerProviderStateMixin {
  late List<CameraDescription> _cameras;
  CameraController? _controller;
  List<XFile> imageFiles = [];
  late Animation<double> animation;
  late AnimationController _animationController;
  late Animation<double> scaleAnimation;

  void addImages(XFile image) {
    setState(() {
      imageFiles.add(image);
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500),
      );
      animation = Tween<double>(begin: 400, end: 1).animate(
        scaleAnimation = CurvedAnimation(
          parent: _animationController,
          curve: Curves.elasticOut,
        ),
      );
      _animationController.forward();
    });
  }

  void removeImage(int index) => setState(() => imageFiles.removeAt(index));

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(
      _cameras[1],
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );
    _controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    _initCamera();

    super.initState();
  }

  Widget _buildCameraPreview() {
    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          CameraPreview(_controller!),
          ListView.builder(
            padding: EdgeInsets.only(bottom: 100.h),
            shrinkWrap: true,
            itemCount: imageFiles.length,
            itemBuilder: (context, index) {
              return Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: imageFiles.length - 1 == index
                        ? ScaleTransition(
                            scale: scaleAnimation,
                            child: _Preview(
                              image: imageFiles.elementAt(index),
                              onDeleted: () => removeImage(index),
                            ),
                          )
                        : _Preview(
                            image: imageFiles.elementAt(index),
                            onDeleted: () => removeImage(index),
                          ),
                  ),
                ],
              );
            },
            scrollDirection: Axis.horizontal,
          ),
          _CameraButton(_controller, onPressed: addImages),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller != null) {
      if (!_controller!.value.isInitialized) {
        return Container();
      }
    } else {
      return const Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          if (imageFiles.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Ink(
                width: 150.w,
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(32.r),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(32.r),
                  onTap: () => _Area(imageFiles: imageFiles).show(context),
                  child: Center(
                    child: Text(
                      "Done",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ),
            )
          else
            const SizedBox(),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBody: true,
      body: _buildCameraPreview(),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _animationController.dispose();

    super.dispose();
  }
}

class _Preview extends StatelessWidget {
  final XFile image;
  final VoidCallback onDeleted;

  const _Preview({required this.image, required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () => context.pushRoute(
            ImagePreviewRoute(
              image: Image.file(File(image.path), filterQuality: FilterQuality.high),
              tag: image.path,
            ),
          ),
          child: Image.file(
            File(image.path),
            height: 90.h,
            width: 60.w,
          ),
        ),
        Positioned(
          top: -5.r,
          right: -5.r,
          child: IconButton.filled(
            style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            iconSize: 12.r,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints.tight(Size.fromRadius(10.r)),
            onPressed: onDeleted,
            icon: const Icon(Icons.close),
          ),
        ),
      ],
    );
  }
}

class _CameraButton extends StatelessWidget {
  final CameraController? controller;
  final ValueChanged<XFile> onPressed;

  const _CameraButton(this.controller, {required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: 0,
      right: 0,
      child: SafeArea(
        child: IconButton(
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) => RotationTransition(
              turns: child.key == const ValueKey('icon1')
                  ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                  : Tween<double>(begin: 0.75, end: 1).animate(anim),
              child: ScaleTransition(
                scale: anim,
                child: child,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(2.r),
                child: Container(
                  height: 50.r,
                  width: 50.r,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          onPressed: takePicture,
        ),
      ),
    );
  }

  Future<void> takePicture() async {
    if (controller == null) return;

    if (controller!.value.isTakingPicture) {
      return;
    }

    try {
      final image = await controller!.takePicture();
      onPressed(image);
      HapticFeedback.lightImpact();
    } on CameraException {
      return;
    }
  }
}

final relatedAreaProvider = StateProvider.autoDispose((ref) => "");

class _Area extends ConsumerWidget {
  final List<XFile> imageFiles;

  const _Area({required this.imageFiles});

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
                hintText: "Lesion area",
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
    ref.read(lesionProvider.notifier).scan(imageFiles);

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
