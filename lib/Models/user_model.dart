import 'dart:convert';

class User {
  int id;
  String name;
  String email;
  List<String> roles;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      roles:
          (json['roles'] as List)
              .map((role) => role['name'] as String)
              .toList(),
    );
  }
}
