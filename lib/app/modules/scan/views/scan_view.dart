import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/scan_controller.dart';

class ScanView extends GetView<ScanController> {
  const ScanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => 
      controller.isCameraInitialized.value ? CameraPreview(controller.cameraController) : CircularProgressIndicator()),
    );
  }
}
