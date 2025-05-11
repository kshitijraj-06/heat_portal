import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EmployeeController extends GetxController{
  final storage = FlutterSecureStorage();
  var selectedRole = <String>[].obs;
  var roles = ['USER', 'SALES', 'OPERATIONS','EXECUTION', 'ACCOUNTS', 'SALES_PARTNER'];
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final idController = TextEditingController();

  void addRoles(String role){
    if(!selectedRole.contains(role)){
      selectedRole.add(role);
    }
  }

  void removeRoles(String role){
    if(selectedRole.contains(role)){
      selectedRole.remove(role);
    }
  }

  String? nameValidator(String? value){
    if(value == null && value!.isEmpty) {
      return 'Please Enter Name';
    }
    return null;
  }

  String? emailValidator(String? value){
    if(value == null && value!.isEmpty) {
      return 'Please Enter Email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Password';
    }
    return null;
  }

  Future<void> createEmployee(String id,String name, String email, String password, List<String> roles)async{
      final token = await storage.read(key: 'token');
      String? url = await storage.read(key: 'url');
    final uri = Uri.parse("http://$url:8080/api/users");
      final body =
        {
          "id" : id,
          "name": name,
          "email": email,
          "password": password,
          "roles": roles
        };
      try{
      final response = await http.post(
        uri,
        headers: {
          'Content-Type' : 'application/json',
          'Accept' : 'application/json',
          'Authorization' : 'Bearer $token'
        },
        body: jsonEncode(body),
      );

      if(response.statusCode == 200){
        Get.snackbar('Employee created', '');
      }else {
        print(response.statusCode);
      }

  }catch(e){
      Get.snackbar('Failed to create employee', e.toString());}
  }


}