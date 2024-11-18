import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:tuni/presentation/pages/screens/image_preview_page.dart';

class CameraProvider with ChangeNotifier {
  List<CameraDescription> _cameras = [];
  CameraController? _cameraController;
  int _selectedCameraIndex = 0;
  List<String> _imagePaths = [];
  String? _currentImagePath;

  List<CameraDescription> get cameras => _cameras;
  CameraController? get cameraController => _cameraController;
  int get selectedCameraIndex => _selectedCameraIndex;
  List<String> get imagePaths => _imagePaths;
  String? get currentImagePath => _currentImagePath;

  Future<void> setupCameraController() async {
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      _cameraController = CameraController(
        _cameras[_selectedCameraIndex],
        ResolutionPreset.high,
      );
      await _cameraController?.initialize();
      notifyListeners();
    }
  }

  Future<void> toggleCamera() async {
    if (_cameras.isEmpty) return;

    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
    await _cameraController?.dispose();
    _cameraController = CameraController(
      _cameras[_selectedCameraIndex],
      ResolutionPreset.high,
    );
    await _cameraController?.initialize();
    notifyListeners();
  }

  Future<void> takePicture() async {
    XFile picture = await _cameraController!.takePicture();
    _currentImagePath = picture.path;
    _imagePaths.insert(0, picture.path);
    notifyListeners();
    Gal.putImage(picture.path);
  }

  void showImagePreview(BuildContext context) {
    if (_imagePaths.isEmpty) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImagePreviewPage(
          imagePaths: _imagePaths,
          initialIndex: 0,  // Start from the most recent image
        ),
      ),
    );
  }
}
