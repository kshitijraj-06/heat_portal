import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heat_portal/Services/profile_service.dart';
import 'package:heat_portal/WIdgets/appbar.dart';

class ProfilePage extends StatelessWidget {
  final profileController = Get.put(ProfileController());

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: GestureDetector(
          onTap:(){
            Get.offAllNamed('/dashboard');
          },
          child: Appbar())),
      backgroundColor: const Color(0xFFF5F7FB),
      body: Center(
        child: Container(
          width: 700,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 32,
                offset: Offset(0, 8),
              ),
            ],
            image: const DecorationImage(
              image: AssetImage('assets/bg_dashboard3.jpg'), // Use a subtle travel-themed background
              fit: BoxFit.cover,
              opacity: 0.1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile image
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.1),
                      blurRadius: 24,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 64,
                  backgroundImage: AssetImage('assets/user.jpg'),
                ),
              ),
              const SizedBox(height: 32),
              // Name
              Obx(() => Text(
                profileController.name.value,
                style: GoogleFonts.merriweather(
                    fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF151B32)),
              )),
              const SizedBox(height: 8),
              // Email
              Obx(() => Text(
                profileController.email.value,
                style: GoogleFonts.urbanist(fontSize: 18, color: Colors.blueGrey[700]),
              )),
              const SizedBox(height: 16),
              // Roles
              Obx(() => Wrap(
                spacing: 8,
                children: profileController.roleNames
                    .map((role) => Chip(
                  label: Text(role.trim()),
                  backgroundColor: Color(0xFFE7EAF0),
                  labelStyle: GoogleFonts.urbanist(
                      color: Color(0xFF151B32), fontWeight: FontWeight.w600),
                ))
                    .toList(),
              )),
              const SizedBox(height: 32),
              // Edit Profile Button (for future expansion)
              SizedBox(
                width: 180,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.snackbar('Feature Not added', 'Can Add in future if asked');
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[700],
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Travel quote or company tagline
              Text(
                '"Travel is the only thing you buy that makes you richer."',
                style: GoogleFonts.urbanist(
                  fontStyle: FontStyle.italic,
                  color: Colors.blueGrey[400],
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
