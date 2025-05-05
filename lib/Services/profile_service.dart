import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final storage = FlutterSecureStorage();

  var name = ''.obs;
  var email = ''.obs;
  var roles = [].obs;
  var roleNames = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMe();
  }

  Future<void> fetchMe() async {
    String? token = await storage.read(key: 'token');

    if (token == null) {
      Get.snackbar("Token Error", "No token found in secure storage");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse("http://192.168.29.136:8080/api/users/me"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        "Content-Type": "application/json"},
      );

      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['data'] != null) {
          final data = json['data'] as Map<String, dynamic>;

          name.value = data['name'] ?? '';
          email.value = data['email'] ?? '';
          roles.value = data['roles'] ?? [];

          // Extract just the role names into a List<String>
          roleNames.value = roles.map((role) => role['name'] as String).toList();

          print("Name: $name");
          print("Email: $email");
          print("Roles: $roles");
        } else {
          Get.snackbar('Error', 'No data found in response.');
        }

      } else {
        Get.snackbar('Fetch Failed', 'Status: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error in Fetching Profile', e.toString());
    }
  }
}
