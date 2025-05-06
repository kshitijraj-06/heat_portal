import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../WIdgets/appbar.dart';

class SalesPartnerScreen extends StatelessWidget{
  const SalesPartnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 10),
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Appbar()
            ),
            Expanded(
                child: Text('Sales Partner DashBoard',
                  style: GoogleFonts.urbanist(
                      color: Colors.black,
                      letterSpacing: .5
                  ),)
            )
          ],
        ),
        actions: [
          GestureDetector(
            onTap: (){

            },
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/user.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}