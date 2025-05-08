import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heat_portal/Services/create_customer_service.dart';
import 'package:heat_portal/WIdgets/appbar.dart';


class CreateCustomerPage extends StatefulWidget{

  @override
  State<CreateCustomerPage> createState() => _CreateCustomerPageState();
}

class _CreateCustomerPageState extends State<CreateCustomerPage> {
final controller = Get.put(CreateCustomerController());
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
                        Text('Add New User',
                            style: GoogleFonts.urbanist
                              (fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(height: 24),
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
                            validator:controller.emailValidator
                        ),
                        SizedBox(height: 24),
                        _inputField(
                            label: 'Phone',
                            controller: controller.phoneController,
                            validator: controller.phoneValidator
                        ),
                        SizedBox(height: 24),
                        _inputField(
                            label: 'Age',
                            controller: controller.ageController,
                            validator: controller.ageValidator
                        ),
                        SizedBox(height: 24),
                        _inputField(
                            label: 'Address',
                            controller: controller.addressController,
                            validator: controller.addressValidator
                        ),
                        SizedBox(height: 20),
                        Divider(),
                        SizedBox(height: 20,),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.find<CreateCustomerController>().createCustomer(

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
                              'Create New User',
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