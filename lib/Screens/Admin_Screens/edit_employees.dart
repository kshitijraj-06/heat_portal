import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heat_portal/Models/user_model.dart';
import 'package:heat_portal/WIdgets/appbar.dart';

import '../../Services/edit_emp_service.dart';

class EditEmployeePage extends StatelessWidget {
  final controller = Get.put(EditEmployeeController());
  final String employeeId;
  final User employee;

  EditEmployeePage({required this.employeeId, required this.employee}) {
    controller.loadData(employee);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: GestureDetector(
          onTap: (){
            Get.offAllNamed('/dashboard');
          },
          child: Appbar())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: controller.idController,
              decoration: InputDecoration(labelText: "ID"),
            ),
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: controller.passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 16),
            Text("Select Roles"),
            Obx(() => Wrap(
              spacing: 10,
              children: ['ADMIN', 'SALES', 'MANAGER']
                  .map((role) => FilterChip(
                label: Text(role),
                selected: controller.selectedRoles.contains(role),
                onSelected: (val) {
                  val
                      ? controller.selectedRoles.add(role)
                      : controller.selectedRoles.remove(role);
                },
              ))
                  .toList(),
            )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.updatedata(employeeId),
              child: Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
