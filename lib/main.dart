import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screens/login_screen.dart';
import 'Screens/splash_screen.dart';

void main(){
  runApp(HEATPortalApp());
}

class HEATPortalApp extends StatelessWidget{
  const HEATPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            //letterSpacing: 26,
            fontSize: 20,
            fontFeatures: [FontFeature.superscripts()]
          )
        ),
        textTheme: TextTheme(
          displayLarge : GoogleFonts.poppins()
        )
      ),
      getPages: [
        GetPage(
            name: '/', page:()  => LoginScreen(),
        ),
        GetPage(
          name: '/login', page:()  => LoginScreen(),
        ),
      ],
    );
  }
}