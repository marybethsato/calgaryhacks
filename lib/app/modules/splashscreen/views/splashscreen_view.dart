import 'package:calgaryhacks/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<AuthenticationController> {
  const SplashscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.load();
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Text("Catchy!",
                style: GoogleFonts.dynaPuff(fontSize: 50, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
