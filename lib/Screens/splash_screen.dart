
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heat_portal/Screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
  with SingleTickerProviderStateMixin{
  late AnimationController  _controller;
  late Animation<double> _scaleTransition;

  @override
  void initState(){
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000)
    );
    _scaleTransition = Tween<double>(begin: 0, end: 2.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.slowMiddle)
    );
    _controller.forward();
    
    Future.delayed(Duration(seconds: 3), (){
      Get.offNamed('/login');
    });
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Container(
          color: Colors.black,
          child: Center(
            child: ScaleTransition(
                scale: _scaleTransition,
            child: Text(
                'HEAT',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 7
                )
            ),)
          ),
        ),
        nextScreen: Container(),
        splashTransition: SplashTransition.slideTransition,
        backgroundColor: Colors.white,
        duration: 3200,
      ),
    );
  }
}
