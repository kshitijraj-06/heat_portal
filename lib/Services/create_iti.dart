import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../Models/daywise_model.dart';
import '../utils/day_itinerary.dart'; // adjust path as needed

class CreateItineraryService extends GetxController {
  // Agent details
  final agentnamecontroller = TextEditingController();
  final agentemailcontroller = TextEditingController();
  final agentphonecontroller = TextEditingController();

  // Customer details
  var customer_ID = ''.obs;
  final clientnamecontroller = TextEditingController();
  final clientemailcontroller = TextEditingController();
  final clientphonecontroller = TextEditingController();
  var nationality = ''.obs;
  final nationalities = ['Indian', 'Foreign'];
  final numAdultscontroller = TextEditingController();
  final numChildrencontroller = TextEditingController();
  final client_emergency_contact = TextEditingController();
  final client_language = TextEditingController();

  // Itinerary details
  final tourCodecontroller = TextEditingController();
  final destinationcontroller = TextEditingController();
  final notescontroller = TextEditingController();
  final descrptioncontroller = TextEditingController();
  final durationcontroller = TextEditingController();
  final arrivalcontroller = TextEditingController();

  final RxList<DayWise> daywiseList = <DayWise>[].obs;

  var startdate = Rxn<DateTime>();
  var enddate = Rxn<DateTime>();
  var numberofdays = 0.obs;
  var numberofnights = 0.obs;

  final storage = FlutterSecureStorage();


  // Add/remove day blocks
  void addNewDay() {
    final index = daywiseList.length + 1;
    final today = DateTime.now().add(Duration(days: index - 1));
    daywiseList.add(DayWise(
      Label: "Day $index",
      day: "Day $index",
      date: DateFormat('yyyy-MM-dd').format(today),
      destination: '',
      notes: '',
    ));
  }
  void removeDay(int index) {
    if (daywiseList.length > 1) {
      daywiseList.removeAt(index);
    }
  }


  void updateDayWise(int index, {required String date, required String destination, required String notes}) {
    final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
    final String dayName = DateFormat('EEEE').format(parsedDate);

    if (index >= 0 && index < daywiseList.length) {
      daywiseList[index] = DayWise(
        Label: "Day ${index + 1}",
        day: dayName,
        date: date,
        destination: destination,
        notes: notes,
      );
      update(); // to refresh the UI
    }
  }


  // Create customer
  Future<void> createcustomer(Map<String, dynamic> data) async {
    String? url = await storage.read(key: 'url');
    final token = await storage.read(key: 'token');

    try {
      final response = await http.post(
        Uri.parse("http://$url:8080/api/customers"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        customer_ID.value = body['data']['customerId'];
        print('Customer created: ${customer_ID.value}');
      } else {
        print('Error creating customer: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Create itinerary
  Future<void> additinerary(Map<String, dynamic> iti_data) async {
    String? url = await storage.read(key: 'url');
    final token = await storage.read(key: 'token');

    try {
      final response = await http.post(
        Uri.parse('http://$url:8080/api/itineraries/customer/CUST_004'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(iti_data),
      );

      if (response.statusCode == 200) {
        print('Itinerary created successfully');
      } else {
        print('Error adding itinerary: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Pick dates
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

        _populateDayWiseList(startdate.value!, numberofdays.value);  // 👈 Add this
      } else {
        numberofnights.value = 0;
        numberofdays.value = 0;
        daywiseList.clear();
      }
    }
  }

  void _populateDayWiseList(DateTime start, int days) {
    daywiseList.clear();
    for (int i = 0; i < days; i++) {
      final currentDate = start.add(Duration(days: i));
      final dateStr = DateFormat('yyyy-MM-dd').format(currentDate);
      final dayName = DateFormat('EEEE').format(currentDate); // Monday, etc.

      daywiseList.add(DayWise(
        Label: "Day ${i + 1}",
        day: dayName,
        date: dateStr,
        destination: '',
        notes: '',
      ));
    }
  }


  // Build final data for API
  Map<String, dynamic> buildItineraryData() {
    return {
      'itineraryId': '',
      'agentName': agentnamecontroller.text,
      'agentEmail': agentemailcontroller.text,
      'agentPhone': agentphonecontroller.text,
      'numAdult': numAdultscontroller.text,
      'numChildren': numChildrencontroller.text,
      'tourCode': tourCodecontroller.text,
      'destination': destinationcontroller.text,
      'duration': numberofdays.toString(),
      'startDate': startdate.value != null
          ? DateFormat('yyyy-MM-dd').format(startdate.value!)
          : '',
      'endDate': enddate.value != null
          ? DateFormat('yyyy-MM-dd').format(enddate.value!)
          : '',
      'noOfDays': numberofdays.value.toString(),
      'noOfNights': numberofnights.value.toString(),
      'arrival': arrivalcontroller.text,
      'dayWiseList': daywiseList.map((d) => d.toJson()).toList(),

    };
  }
}
