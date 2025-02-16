import 'package:calgaryhacks/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  AuthenticationController authenticationController;
  ProfileController({required this.authenticationController});
}
