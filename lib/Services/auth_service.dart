import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController{
  final storage = FlutterSecureStorage();

  var obscurepassword = true.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  get togglepasswordvisibility => null;

  void toggleobscure(){
    obscurepassword.value = !obscurepassword.value;
  }

  String? emailValidator(String? value){
    if(value == null && value!.isEmpty) {
      return 'Please Enter Email';
    }
    return null;
  }

  String? passwordValidator(String? value){
    if(value == null || value.isEmpty) {
      return 'Please Enter Password';
    }
    return null;
  }

  Future<void> handlelogin() async{

    final url = "172.20.10.2" ;
    await storage.write(key: 'url', value: url);

    try{
      final response = await http.post(
        Uri.parse("http://172.20.10.2:8080/api/auth/login"),
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

        print(url);

        final json = jsonDecode(response.body);

        final role = json['data']['roles'] as List<dynamic>;
        final roleName = role.map((r) => r['name']).toList();

        final name = json['data']['name'];

        final token = json['data']['token'];
        await storage.write(key: 'token', value: token);

        print(response.body);

        Get.snackbar("Login Successful", "Welcome $name");
        if(roleName.contains('ADMIN')){
          Get.offAllNamed('/dashboard');
        }else if(roleName.contains('SALES')){
          Get.offAllNamed('/sales_partner_dashboard');
        }else{
          Get.offAllNamed('/login');
        }
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