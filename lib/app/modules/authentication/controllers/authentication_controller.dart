import 'package:calgaryhacks/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationController extends GetxController {
  static const List<String> scopes = <String>[
    'email',
  ];

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: scopes,
  );

  Rx<GoogleSignInAccount?> account = Rx(null);
  //TODO: Implement HomeController

  Future<void> handleSignIn() async {
  try {
    account.value = await _googleSignIn.signIn();
    if(account.value != null){
      Get.toNamed(Routes.NAVIGATION);
    }
  } catch (error) {
    print(error);
  }
}

}
