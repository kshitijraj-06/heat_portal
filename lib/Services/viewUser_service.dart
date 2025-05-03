import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:heat_portal/Models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserController extends GetxController{
  var selectedRole = 'All'.obs;
  var alluser = <User>[].obs;
  var filteredUser = <User>[].obs;
  var isLoading = false.obs;

  @override
  void onInit(){
    super.onInit();
    fetchUsers();
  }

  Future<List<User>> fetchUsers() async {
    isLoading.value = true;
    final storage = FlutterSecureStorage();
    final response = await http.get(
      Uri.parse('http://172.20.10.2:8080/api/users'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'token')}'
      },
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final List userData = jsonBody['data'];
      final users = userData.map((user) => User.fromJson(user)).toList();
      alluser.assignAll(users);
      filteredUser.assignAll(users);
      isLoading.value = false;
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  List<String> get allRoles{
    final roles = <String>{};
    for(final user in alluser){
      roles.addAll(user.roles);
    }
    return ['All', ...roles];
  }

  List<User> get filteredbyRole{
    if(selectedRole.value == 'All'){
      return filteredUser;
    }
    return filteredUser.where((user) => user.roles.contains(selectedRole.value)).toList();
  }

  void setselectedRole(String role){
    selectedRole.value = role;
  }


  void filterUsers(String query) {
    if (query.isEmpty) {
      filteredUser.assignAll(alluser);
    } else {
      filteredUser.assignAll(
        alluser.where((user) =>
        user.name.toLowerCase().contains(query.toLowerCase()) ||
            user.email.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }
  }



