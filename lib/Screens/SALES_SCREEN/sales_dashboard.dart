import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heat_portal/WIdgets/appbar.dart';
import 'package:get/get.dart';

class SalesDashboard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Appbar(),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black
              ),
                child: Text('SALES',
                style: GoogleFonts.poppins(
                  color: Colors.white
                ),
                )
            ),
            ListTile(
              leading: Icon(Icons.mail_outline),
              title: Text('Mail',
              style: GoogleFonts.poppins(),),
              onTap: (){
                Get.offAllNamed('/mail');
              },
            )
          ]
        ),
      ),
      body: SingleChildScrollView(
        child:Column(),
      ),
    );
  }
}