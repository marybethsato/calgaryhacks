import 'package:calgaryhacks/app/modules/scan/controllers/scan_controller.dart';
import 'package:calgaryhacks/app/modules/scan/views/scan_view.dart';
import 'package:calgaryhacks/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Text("Catchy!", style: GoogleFonts.dynaPuff(fontSize: 50)),
            const SizedBox(
              height: 40,
            ),
            Text('Login to continue', style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: 10,
            ),
            FilledButton(
                onPressed: () {
                  controller.handleSignIn();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Sign In with Google",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                )),
            const SizedBox(
              height: 8,
            ),
            TextButton(
                onPressed: () {
                  Get.to(ScanView());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Try it first",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
