import 'package:calgaryhacks/app/modules/scan/controllers/scan_controller.dart';
import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ScanController());
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(),
    );
  }
}
