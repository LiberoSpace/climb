import 'dart:io';

import 'package:camera/camera.dart';

class CameraProvider {
  final List<CameraDescription> allCameras;
  CameraDescription? mainCamera;
  CameraDescription? wideCamera;

  CameraProvider({required this.allCameras}) {
    for (var cameraDescription in allCameras) {
      if (cameraDescription.lensDirection != CameraLensDirection.back) {
        continue;
      }
      if (mainCamera == null &&
          cameraDescription.lensDirection == CameraLensDirection.back) {
        mainCamera = cameraDescription;
        continue;
      }
      if (Platform.isIOS &&
          cameraDescription.name.contains('avcapturedevice.built-in_video:5')) {
        wideCamera = cameraDescription;
        continue;
      }
    }
  }
}
