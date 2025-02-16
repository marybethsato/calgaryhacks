import 'package:calgaryhacks/app/modules/scan/controllers/scan_controller.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class NavigationController extends GetxController {
  final ScanController scanController;
  Rx<int> currentIndex = Rx<int>(0);

  NavigationController({required this.scanController});

  Future<void> capture() async {
    await scanController.captureAndIdentifySpecies();
  }
}
