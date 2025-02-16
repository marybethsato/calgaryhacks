import 'package:calgaryhacks/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  AuthenticationController authenticationController;

  HomeController({required this.authenticationController});
}
