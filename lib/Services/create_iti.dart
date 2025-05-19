import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/http/interface/request_base.dart';
import 'package:intl/intl.dart';

class CreateItineraryService extends GetxController{
  final agentnamecontroller = TextEditingController();
  final agentemailcontroller = TextEditingController();
  final agentphonecontroller = TextEditingController();

  final clientnamecontroller = TextEditingController();
  final clientemailcontroller = TextEditingController();
  final clientphonecontroller = TextEditingController();
  final numAdultscontroller = TextEditingController();
  final numChildrencontroller = TextEditingController();
  var nationality = ''.obs;
  final client_emergency_contact = TextEditingController();
  final client_language = TextEditingController();

  final tourCodecontroller = TextEditingController();
  final destinationcontroller = TextEditingController();
  final descrptioncontroller = TextEditingController();
  List<TextEditingController> dayWiseControllers = [
    TextEditingController()
  ].obs;

  final durationcontroller = TextEditingController();
  var startdate = Rxn<DateTime>();
  var enddate = Rxn<DateTime>();
  var numberofdays = 0.obs;
  var numberofnights = 0.obs;


  final arrivalcontroller = TextEditingController();

  void addDayController(){
    dayWiseControllers.add(TextEditingController());
  }

  Future<void> pickDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (isStart) {
        startdate.value = picked;
      } else {
        enddate.value = picked;
      }
      _calculateDuration();
    }
  }

  void _calculateDuration() {
    if (startdate.value != null && enddate.value != null) {
      final nights = enddate.value!.difference(startdate.value!).inDays;
      if (nights >= 0) {
        numberofnights.value = nights;
        numberofdays.value = nights + 1;
      } else {
        numberofnights.value = 0;
        numberofdays.value = 0;
      }
    }
  }

}