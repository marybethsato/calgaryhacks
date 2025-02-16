import 'package:calgaryhacks/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(
          authenticationController: Get.find<AuthenticationController>()),
    );
  }
}
