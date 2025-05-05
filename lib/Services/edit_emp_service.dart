import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cupertino_icons/cupertino_icons.dart';

import '../Models/user_model.dart';

class EditEmployeeController extends GetxController{
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final idController = TextEditingController();
  var selectedRoles = <String>[].obs;

  void loadData(User userData){
    idController.text = userData.id;
    nameController.text = userData.name;
    emailController.text = userData.email;
    selectedRoles.assignAll(userData.roles);
  }

  Future<void> updatedata(String id) async {
    final storage = FlutterSecureStorage();
    final id = idController.text;

    final response = await http.put(Uri.parse('http://192.168.29.136:8080/api/users/$id'),
    headers:
    {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await storage.read(key: 'token')}'
    },
    body: jsonEncode({
      "id" : idController.text,
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "roles": selectedRoles,
    })
    );

    print(response.body);

    if(response.statusCode == 200){
      Get.snackbar("Success", "Employee updated successfully");
    } else {
      Get.snackbar("Error", "Failed to update employee");
    }

  }
}