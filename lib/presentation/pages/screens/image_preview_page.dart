import 'package:flutter/material.dart';
import 'dart:io';

class ImagePreviewPage extends StatelessWidget {
  final List<String> imagePaths;
  final int initialIndex;

  const ImagePreviewPage({
    required this.imagePaths,
    required this.initialIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview'),
      ),
      body: PageView.builder(
        itemCount: imagePaths.length,
        controller: PageController(initialPage: initialIndex),
        itemBuilder: (context, index) {
          return Center(
            child: Image.file(File(imagePaths[index])),
          );
        },
      ),
    );
  }
}
