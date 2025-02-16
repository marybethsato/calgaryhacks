import 'package:calgaryhacks/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(
          authenticationController: Get.find<AuthenticationController>()),
    );
  }
}
