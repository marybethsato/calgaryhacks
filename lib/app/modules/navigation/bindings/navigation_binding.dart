import 'package:calgaryhacks/app/modules/scan/controllers/scan_controller.dart';
import 'package:get/get.dart';

import '../controllers/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(
      () => NavigationController(),
    );
      Get.lazyPut<ScanController>(
      () => ScanController(),
    );
  }
}
