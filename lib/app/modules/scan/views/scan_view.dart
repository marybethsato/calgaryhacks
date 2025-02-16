import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/scan_controller.dart';

class ScanView extends GetView<ScanController> {
  const ScanView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.initializeCamera();

    return PopScope(
      onPopInvokedWithResult: (val, res) {
        controller.cameraController.dispose();
      },
      child: Scaffold(
        body: Obx(() {
          if (controller.isCameraLoading.value == true) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                Text(controller.message.value)
              ],
            ));
          }
          if (controller.isCameraInitialized.value == false) {
            return Center(child: Text(controller.message.value));
          }
          return Stack(
            children: [
              Positioned.fill(
                child: CameraPreview(controller.cameraController),
              ),
              Positioned(
                bottom: 1,
                left: 1,
                right: 1,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircleAvatar(
                    radius: 30,
                    child: IconButton(
                        onPressed: () {
                          controller.captureAndIdentifySpecies();
                        },
                        icon: Icon(
                          Icons.camera_alt_outlined,
                        )),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
