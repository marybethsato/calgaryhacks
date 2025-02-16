import 'dart:html' as html;

import 'package:camera/camera.dart';
import 'package:get/get.dart';

class ScanController extends GetxController {
  late CameraController cameraController;
  var isCameraInitialized = false.obs;
  //TODO: Implement ScanController

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      // Request camera permission manually for web
      final stream = await html.window.navigator.mediaDevices?.getUserMedia({'video': true});

      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        cameraController = CameraController(
          cameras[0], // First available camera
          ResolutionPreset.medium,
        );

        await cameraController.initialize();
        isCameraInitialized.value = true; // Notify UI that the camera is ready
      }
    } catch (e) {
      print("Camera initialization failed: $e");
    }
  }

  @override
  void onClose() {
    cameraController.dispose(); // Dispose the camera when closing
    super.onClose();
  }
}
