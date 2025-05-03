import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Services/viewUser_service.dart';
import '../../WIdgets/appbar.dart';

class ViewEmployees extends StatelessWidget {
  final UserController controller = Get.put(UserController());

  ViewEmployees({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: InkWell(
              onTap: (){
                Get.offAllNamed('/dashboard');
              },
              child: Appbar())
      ),
      backgroundColor: const Color(0xFFF5F7FB),
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Center(
              child: Text(
                'EMPLOYEES',
                style: GoogleFonts.merriweather(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search employees by name or email',
                      prefixIcon: Icon(Icons.search, size: 30),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      isDense: true,
                    ),
                    onChanged: controller.filterUsers,
                  ),
                ), //TODO: Search Bar
                const SizedBox(width: 24),

                SizedBox(
                  height: 40,
                  child: Obx(() {
                    final roles = controller.allRoles;
                    return ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: roles.length,
                      separatorBuilder: (_, __) => SizedBox(width: 8),
                      itemBuilder: (context, idx) {
                        final role = roles[idx];
                        final isActive = controller.selectedRole.value == role;
                        return TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: isActive ? Color(0xFFBFC8E6) : Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => controller.setselectedRole(role),
                          child: Text(
                            role,
                            style: GoogleFonts.urbanist(
                              color: isActive ? Color(0xFF151B32) : Colors.grey[700],
                              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ), //TODO: TABS
              ],
            ),
            const SizedBox(height: 24),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.filteredUser.isEmpty) {
                  return Center(child: Text('No User Found'));
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: 1.8,
                  ),
                  itemCount: controller.filteredbyRole.length,
                  itemBuilder: (context, index) {
                    final user = controller.filteredbyRole[index];
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: Color(0xFFF5F7FB),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.grey[300],
                                  child: Text(
                                    user.name[0].toUpperCase(),
                                    style: GoogleFonts.urbanist(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF151B32),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.name,
                                        style: GoogleFonts.urbanist(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Color(0xFF151B32),
                                        ),
                                      ),
                                      Text(
                                        user.email,
                                        style: GoogleFonts.urbanist(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                      // Optionally add location here if available
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: user.roles
                                  .map((role) => Chip(
                                label: Text(role),
                                backgroundColor: Color(0xFFFFFFFF),
                                labelStyle: GoogleFonts.urbanist(
                                  color: Color(0xFF006CB3),
                                  fontSize: 12,
                                ),
                              ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ), //TODO: User Grid
          ],
        ),
      ),
    );
  }
}
