import 'package:calgaryhacks/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationController extends GetxController {
  static const List<String> scopes = <String>[
    'email',
  ];

  Rx<String> email = Rx<String>('');
  Rx<String> name = Rx<String>('');
  Rx<String> photo = Rx<String>('');

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: scopes,
  );

  Future<void> initializeUserData() async {
    print('1');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('2');
    email.value = prefs.getString("email") ?? '';
    name.value = prefs.getString("name") ?? '';
    photo.value = prefs.getString("photo") ?? '';
  }

  Future<void> saveUserData(String _name, String _email, String _photo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", _email);
    prefs.setString("name", _name);
    prefs.setString("photo", _photo);
    email.value = _email;
    name.value = _name;
    photo.value = _photo;
  }

  Rx<GoogleSignInAccount?> account = Rx(null);
  //TODO: Implement HomeController

  Future<void> handleSignIn() async {
    try {
      account.value = await _googleSignIn.signIn();
      if (account.value != null) {
        saveUserData(account.value!.displayName ?? '', account.value!.email,
            account.value!.photoUrl ?? '');
        Get.toNamed(Routes.NAVIGATION);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateNav() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 2));
      await initializeUserData();
      if (email.value != '' && name.value != '') {
        Get.toNamed(Routes.NAVIGATION);
      } else {
        Get.toNamed(Routes.AUTH);
      }
    });
  }

  Future<void> load() async {
    updateNav();
  }
}
