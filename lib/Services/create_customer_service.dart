import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CreateCustomerController extends GetxController {
  final storage = FlutterSecureStorage();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final ageController = TextEditingController();

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone';
    }
    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  String? addressValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an address';
    }
    return null;
  }

  String? ageValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an age';
    }
    if (int.tryParse(value) == null) {
      return 'Age must be a number';
    }
    return null;
  }

  Future<void> createCustomer() async {
    final token = await storage.read(key: 'token');
    final name = nameController.text.trim();
    final age = int.tryParse(ageController.text.trim());
    final address = addressController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    String? url = await storage.read(key: 'url');

    try {
      final response = await http.post(
        Uri.parse("http://$url:8080/api/customers"),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "name": name,
          "age": age,
          "address": address,
          "phone": phone,
          "email": email,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Customer created: ${response.body}');
        Get.snackbar('Success', 'Customer created successfully');
      } else {
        Get.snackbar('Error', 'Failed to create customer');
        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to create customer');
      print('Error: $e');
    }
  }
}
