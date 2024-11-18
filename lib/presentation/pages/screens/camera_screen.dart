import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni/core/provider/camera_provider.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CameraProvider>(
        builder: (context, cameraProvider, child) {
          if (cameraProvider.cameraController == null ||
              !cameraProvider.cameraController!.value.isInitialized) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(
            children: [
              Positioned.fill(
                child: CameraPreview(cameraProvider.cameraController!),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: GestureDetector(
                  onTap: () => cameraProvider.showImagePreview(context),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: cameraProvider.currentImagePath != null
                        ? FileImage(File(cameraProvider.currentImagePath!))
                        : null,
                    child: cameraProvider.currentImagePath == null
                        ? Icon(Icons.camera_alt, size: 30, color: Colors.grey[600])
                        : null,
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: IconButton(
                  onPressed: cameraProvider.toggleCamera,
                  iconSize: 30,
                  icon: const Icon(
                    Icons.cameraswitch,
                    color: Colors.white,
                  ),
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: IconButton(
                    onPressed: cameraProvider.takePicture,
                    iconSize: 50,
                    icon: const Icon(
                      Icons.camera,
                      color: Colors.white,
                    ),
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
