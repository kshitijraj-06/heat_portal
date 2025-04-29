import 'package:get/get.dart';
import 'package:flutter/material.dart';

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
      getPages: [
        GetPage(name: '/', page:()  => SplashScreen())
      ],
    );
  }
}