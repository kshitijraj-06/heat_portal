import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heat_portal/WIdgets/appbar.dart';

import '../Services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (kIsWeb) {
      return _buildMobileUI(width, height);
    } else if (Platform.isWindows) {
      return _buildWindowsUI(width, height);
    } else {
      return _buildWebUI(width, height);
    }
  }

  Widget _buildWindowsUI(double width, double height) {
    return Scaffold(
      appBar: AppBar( title: Appbar()),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1200),
          child: Container(
            padding: EdgeInsets.only(top: 50),
            margin: EdgeInsets.all(50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(40),
                    width: 500,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Login to Continue',
                          style: GoogleFonts.urbanist(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                        SizedBox(height: 40,),
                        _loginField(
                          label: 'Email',
                          isPassword: false,
                          controller: controller.emailController,
                          validator: controller.emailValidator,
                          loginController: controller,
                        ),
                        SizedBox(height: 24),
                        _loginField(
                          label: 'Password',
                          isPassword: true,
                          controller: controller.passwordController,
                          validator: controller.passwordValidator,
                          loginController: controller,
                        ),
                        SizedBox(height: 20,),
                        Divider(),
                        SizedBox(height: 20,),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.find<LoginController>().handlelogin();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade900,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 600,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(

                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/bg_heat.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.3),
                          alignment: Alignment.center,
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              'Welcome to HEAT Portal',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWebUI(double width, double height) {
    return Scaffold(
      appBar: AppBar(title: Appbar(), toolbarHeight: 800),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(width * 0.1, 10, width * 0.1, 0),
          child: Column(
            children: [
              Text(
                'Login to Csndnsnontinue',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.05),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _loginField(
                        label: 'Email',
                        isPassword: false,
                        controller: controller.emailController,
                        validator: controller.emailValidator,
                        loginController: controller,
                      ),
                      SizedBox(height: height * 0.02),
                      _loginField(
                        label: 'Password',
                        isPassword: true,
                        validator: controller.passwordValidator,
                        controller: controller.passwordController,
                        loginController: controller,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.find<LoginController>().handlelogin();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.lightGreen,
                          maximumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'LOGIN',
                          style: GoogleFonts.urbanist(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileUI(double width, double height) {
    return Scaffold(
      appBar: AppBar(title: Appbar(), toolbarHeight: 100),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(width * 0.1, 10, width * 0.1, 0),
          child: Column(
            children: [
              Text(
                'Login to Continue',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.05),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _loginField(
                        label: 'Email',
                        isPassword: false,
                        controller: controller.emailController,
                        validator: controller.emailValidator,
                        loginController: controller,
                      ),
                      SizedBox(height: height * 0.02),
                      _loginField(
                        label: 'Password',
                        isPassword: true,
                        validator: controller.passwordValidator,
                        controller: controller.passwordController,
                        loginController: controller,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.find<LoginController>().handlelogin();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.lightGreen,
                          maximumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'LOGIN',
                          style: GoogleFonts.urbanist(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginField({
    required String label,
    required bool isPassword,
    required TextEditingController? controller,
    required String? Function(String?) validator,
    required LoginController loginController,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon:
            isPassword
                ? Obx(
                  () => IconButton(
                    icon: Icon(
                      loginController.obscurepassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 20,
                    ),
                    onPressed: loginController.togglepasswordvisibility,
                  ),
                )
                : null,
      ),
      obscureText: isPassword ? loginController.obscurepassword.value : false,
      validator: validator,
    );
  }
}
