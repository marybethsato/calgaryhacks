import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:calgaryhacks/app/models/taxon.model.dart';
import 'package:calgaryhacks/app/modules/scan/views/scan_details_view.dart';
import 'package:calgaryhacks/app/routes/app_pages.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ScanController extends GetxController {
  late CameraController cameraController;
  RxBool isCameraInitialized = RxBool(false);
  RxBool isCameraLoading = RxBool(false);
  var isProcessing = false.obs;
  var identifiedSpecies = "".obs;
  Uint8List? capturedImageBytes;
  Rx<TaxonModel?> currentTaxon = Rx(null);
  Rx<bool> isFromCam = Rx<bool>(false);
  late List<CameraDescription> cameras;
  int selectedCameraIndex = 0;
  Rx<String> message = RxString('');

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> initializeCamera() async {
    try {
      isCameraLoading.value = true;
      message.value = "Initializing camera...";
      cameras = await availableCameras();
      message.value = "Got available cameras...${cameras.length}";
      if (cameras.isNotEmpty) {
        await _initCameraController(cameras.last);
        message.value = "Camera set...";
        isCameraLoading.value = false;
      } else {
        message.value = "No available cameras...";
        isCameraInitialized.value = false;
        isCameraLoading.value = false;
      }
    } catch (e) {
      isCameraInitialized.value = false;
      message.value = "Camera initialization failed: $e.";
      isCameraLoading.value = false;
    }
  }

  Future<void> _initCameraController(CameraDescription camera) async {
    cameraController =
        CameraController(camera, ResolutionPreset.high, enableAudio: true);
    try {
      await cameraController.initialize();
      isCameraInitialized.value = true;
    } catch (e) {
      isCameraInitialized.value = false;
      isCameraLoading.value = false;
      message.value = "Camera initialization failed : $e.";
    }
  }

  Future<void> captureAndIdentifySpecies() async {
    if (!cameraController.value.isInitialized) return;

    try {
      isProcessing.value = true;

      final XFile file = await cameraController.takePicture();
      final bytes = await file.readAsBytes();
      capturedImageBytes = bytes;
      isFromCam.value = true;

      await identifySpeciesWeb(bytes);
    } catch (e) {
      print("Error capturing image: $e");
    } finally {
      isProcessing.value = false;
    }
  }

  Future<void> identifySpeciesWeb(Uint8List imageBytes) async {
    var url =
        Uri.parse('https://api.inaturalist.org/v1/computervision/score_image');

    const String apiToken =
        "eyJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjo4OTU0NTE3LCJleHAiOjE3Mzk3NjY5MDh9.KWVAkhEwDEUAhaX8zTmWmNU6tSu0ugrDKMfnw2EZK-T6vR_37Bo3oPSgwU9I6bpHrF9pVlHBb2AglXvaX3Dndw";

    var request = http.MultipartRequest("POST", url);
    request.headers['Authorization'] = "Bearer $apiToken";
    request.files.add(http.MultipartFile.fromBytes('image', imageBytes,
        filename: "captured_image.jpg"));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        currentTaxon.value = TaxonModel.fromJson(jsonDecode(responseBody));
        Get.toNamed(Routes.SCAN_DETAILS);
      } else {
        print("API Error: ${response.statusCode}");
        currentTaxon.value = null;
      }
    } catch (e) {
      print("Error in API request: $e");
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
