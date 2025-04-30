import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heat_portal/WIdgets/appbar.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isobscure = false;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Appbar()),
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(width * 0.1, height * 0.1, width * 0.1, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _loginField(
                        label: 'Email',
                        isPassword: false,
                        onSaved: (value) => email = value!.trim(),
                        validator: (value) => value!.isEmpty ?? true ? 'Enter your Email' : null),
                    _loginField(
                        label: 'Password',
                        isPassword: true,
                        onSaved: (value) => password = value!.trim(),
                        validator: (value) => value!.isEmpty ?? true ? 'Enter your Password' : null),
                    ElevatedButton(
                      onPressed: (){
                        //
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.lightGreen,
                          maximumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                          )
                      ),
                      child: Text('LOGIN',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),)
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }


  Widget _loginField({
    required String label,
    required bool isPassword,
    required Function(String?) onSaved,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon:
              isPassword
                  ? IconButton(
                    icon: Icon(
                      isobscure ? Icons.visibility : Icons.visibility_off,
                      size: 20,
                    ),
                    onPressed: () => setState(() => isobscure = !isobscure),
                  )
                  : null,
        ),
        obscureText: isPassword ? !isobscure : false,
        onSaved: onSaved,
        validator: validator,

      ),
    );
  }


}
