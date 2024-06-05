import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ImagePreviewPage extends StatelessWidget {
  final Image image;
  final Object? tag;

  const ImagePreviewPage(this.image, {this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Image Preview"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(color: Colors.white),
      ),
      body: InteractiveViewer(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          color: Colors.black,
          child: SizedBox(
            width: double.infinity,
            child: tag != null ? Hero(tag: tag!, child: image) : image,
          ),
        ),
      ),
    );
  }
}
