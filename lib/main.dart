import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screens/Admin_Screens/create_employee.dart';
import 'Screens/Admin_Screens/view_employees.dart';
import 'Screens/admin_dashboard.dart';
import 'Screens/login_screen.dart';
import 'Screens/profile.dart';
import 'Screens/sales_partner_dashboard.dart';
import 'Screens/splash_screen.dart';

// void main(){
//   runApp(
//       DevicePreview(
//         enabled: true,
//       builder: (context) => HEATPortalApp()));
// }

void main(){
  runApp(HEATPortalApp());
}

class HEATPortalApp extends StatelessWidget{
  const HEATPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/dashboard',
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
            name: '/home', page:()  => SplashScreen(),
        ),
        GetPage(
          name: '/login', page:()  => LoginScreen(),
        ),
        GetPage(name: '/dashboard', page: () => Dashboard()
        ),
        GetPage(name: '/sales_partner_dashboard', page: () => SalesPartnerScreen()
        ),
        GetPage(name: '/view_employee', page: () => ViewEmployees()
        ),
        GetPage(name: '/create_emp', page: () => CreateEmployee()
        ),
        GetPage(name: '/profile', page: () => ProfilePage()
        ),
      ],
    );
  }
}