import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lesion_meter/custom/custom_circular_progress_bar.dart';

import '../constants/colors.dart' as colors;

@immutable
class LoadingScreenController {
  final VoidCallback close;
  final VoidCallback update;

  const LoadingScreenController({
    required this.close,
    required this.update,
  });
}

class LoadingScreen {
  static final _instance = LoadingScreen._();

  factory LoadingScreen() => _instance;

  LoadingScreen._();

  LoadingScreenController? controller;

  void show({required BuildContext context, String? message}) {
    hide();
    controller = _showOverlay(context: context, message: message)..update();
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  LoadingScreenController _showOverlay({
    required BuildContext context,
    String? message,
  }) {
    final state = Overlay.of(context, rootOverlay: true);
    final renderBox = context.findRenderObject()! as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: colors.bodyTextcolor.withOpacity(.4),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.2,
                maxHeight: size.height * 0.1,
                minWidth: size.width * 0.2,
                minHeight: size.height * 0.1,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.white,
              ),
              child: Center(child: CustomCircularProgressIndicator(size: 24.r)),
            ),
          ),
        );
      },
    );

    return LoadingScreenController(
      close: overlay.remove,
      update: () => state.insert(overlay),
    );
  }
}
