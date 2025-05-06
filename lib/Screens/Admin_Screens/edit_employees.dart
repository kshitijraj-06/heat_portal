import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heat_portal/Models/user_model.dart';
import 'package:heat_portal/WIdgets/appbar.dart';

import '../../Services/edit_emp_service.dart';
import '../../Services/profile_service.dart';

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
          child: Appbar()
      )
      ),
      body: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width
          ),
        child: Container(
          padding: EdgeInsets.all(30),
          margin: EdgeInsets.all(30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Row(
              children: [
                SizedBox(
                  width: 450,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(

                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/bg_heat.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.3),
                        alignment: Alignment.center,
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Welcome to HEAT Portal',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
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
                    children: [
                      Text('Edit Employee',
                          style: GoogleFonts.urbanist
                            (fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(height: 24),
                      _inputField(
                          label: 'ID',
                          controller: controller.idController,
                          validator: controller.idValidator,
                      ),
                      SizedBox(height: 24),
                      _inputField(
                          label: 'Name',
                          controller: controller.nameController,
                          validator: controller.nameValidator,
                      ),
                      SizedBox(height: 24),
                      _inputField(
                          label: 'Email',
                          controller: controller.emailController,
                          validator: controller.emailValidator,
                      ),
                      SizedBox(height: 24),
                      _inputField(
                          label: 'Password',
                          controller: controller.passwordController,
                          validator: controller.passwordValidator,
                      ),
                      SizedBox(height: 24),
                      Obx(() => Wrap(
                        spacing: 10,
                        children: ['ADMIN', 'SALES', 'OPERATIONS', 'EXECUTION', 'ACCOUNTS']
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
                      SizedBox(height: 20,),
                      Divider(),
                      SizedBox(height: 20,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.updatedata(employeeId);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade900,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Edit',
                            style: GoogleFonts.poppins(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 450,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(

                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/bg_heat.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.3),
                        alignment: Alignment.center,
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Welcome to HEAT Portal',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      )
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
