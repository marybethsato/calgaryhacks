import 'package:calgaryhacks/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:calgaryhacks/app/modules/home/controllers/home_controller.dart';
import 'package:calgaryhacks/app/modules/scan/controllers/scan_controller.dart';
import 'package:get/get.dart';

import '../controllers/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanController>(
      () => ScanController(),
    );
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(
          authenticationController: Get.find<AuthenticationController>()),
    );
    Get.lazyPut<NavigationController>(
      () => NavigationController(scanController: Get.find<ScanController>()),
    );
  }
}
