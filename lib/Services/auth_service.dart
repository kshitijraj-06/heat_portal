import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController{
  var obscurepassword = true.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  get togglepasswordvisibility => null;

  void toggleobscure(){
    obscurepassword.value = !obscurepassword.value;
  }

  String? emailValidator(String? value){
    if(value == null && value!.isEmpty)
      return 'Please Enter Email';
    return null;
  }

  String? passwordValidator(String? value){
    if(value == null || value!.isEmpty)
      return 'Please Enter Password';
    return null;
  }

  Future<void> handlelogin() async{

    try{
      final response = await http.post(
        Uri.parse('https://e452-202-142-69-199.ngrok-free.app/api/auth/login'),
        headers: {
          'Content-Type' : 'application/json',
          'Accept' : 'application/json'
        },
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        print(response.body);
        final user = json['user'];

        Get.snackbar("Login Successful", "Welcome user");
        Get.offAllNamed('/home');
      }else{
        print(response.body);
        Get.snackbar("Login Failed", "Error Code: ${response.statusCode}");
      }
    }catch(e){
      print(e);
      Get.snackbar("Login Failed", "Error: $e");
    }
  }
}