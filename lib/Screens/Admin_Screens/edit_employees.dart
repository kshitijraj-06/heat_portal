import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../WIdgets/appbar.dart';

class EditEmployee extends StatelessWidget{
  const EditEmployee({super.key});

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
    );
  }
}