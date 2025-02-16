import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    GetMaterialApp(
      title: "Catchy!",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color(0xFF3B7D3E),
        ),
        primaryColor: Color(0xFF3B7D3E),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    ),
  );
}
