import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heat_portal/WIdgets/appbar.dart';

import '../../Services/create_emp_service.dart';

class CreateEmployee extends StatefulWidget{
  const CreateEmployee({super.key});

  @override
  State<CreateEmployee> createState() => _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {
  final controller = Get.put(EmployeeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: (){
            Get.offAllNamed('/dashboard');
          },
            child: Appbar()
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 1200
          ),
          child: Container(
            padding: EdgeInsets.only(top: 50),
            margin: EdgeInsets.all(50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 600,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/bg_heat2.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.3),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              'Hello Admin !!',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 36,
                                height: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(40),
                    width: 500,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Add New Employee',
                            style: GoogleFonts.urbanist
                              (fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(height: 24),
                        _inputField(
                            label: 'ID',
                            controller: controller.idController,
                            validator: controller.nameValidator
                        ),
                        SizedBox(height: 24),
                        _inputField(
                            label: 'Name',
                            controller: controller.nameController,
                            validator: controller.nameValidator
                        ),
                        SizedBox(height: 24),
                        _inputField(
                            label: 'Email',
                            controller: controller.emailController,
                            validator: controller.emailValidator
                        ),
                        SizedBox(height: 24),
                        _inputField(
                            label: 'Password',
                            controller: controller.passwordController,
                            validator: controller.passwordValidator
                        ),

                        SizedBox(height: 16),
                        SizedBox(height: 16),
                        // Roles Dropdown
                        Obx(() => DropdownButtonFormField<String>(
                          value: controller.selectedRole.isNotEmpty ? controller.selectedRole.last : null,
                          items: controller.roles
                              .map((role) => DropdownMenuItem(
                            value: role,
                            child: Text(role),
                          ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) controller.addRoles(value);
                          },
                          decoration: InputDecoration(
                            labelText: 'Select Role',
                            border: OutlineInputBorder(),
                          ),
                        )),
                        SizedBox(height: 12),
                        // Selected Roles Chips
                        Obx(() => Wrap(
                          spacing: 8,
                          children: controller.selectedRole
                              .map((role) => Chip(
                            label: Text(role),
                            onDeleted: () => controller.removeRoles(role),
                          ))
                              .toList(),
                        )),
                        SizedBox(height: 24),
                        Divider(),
                        SizedBox(height: 20,),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.find<EmployeeController>().createEmployee(
                                controller.idController.text,
                                controller.nameController.text,
                                controller.emailController.text,
                                controller.passwordController.text,
                                controller.selectedRole
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade900,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Create New Employee',
                              style: GoogleFonts.poppins(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required String label,
    required TextEditingController? controller,
    required String? Function(String?) validator,
}){
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
    ),
      validator: validator,
    );
  }
}