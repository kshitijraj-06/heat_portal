import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:heat_portal/Models/Itinerary_model.dart';
import 'package:http/http.dart' as http;

class GetAllItinerary extends GetxController{
  final RxList<Itinerary> itineraries = <Itinerary>[].obs;
  final isLoading = true.obs;
  final storage = FlutterSecureStorage();
  
  Future<void> fetchItineraries() async{
    isLoading.value = false;
    final url = await storage.read(key: 'url');
    final token = await storage.read(key: 'token');
    
    try{
      final response = await http.get(
        Uri.parse('http://$url:8080/api/itineraries'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }
      );

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        final itiernaryJson = data['data'] as List;
        itineraries.value = itiernaryJson.map((e) => Itinerary.fromJson(e)).toList();
      }else{
        print('Error fetching itineraries: ${response.body}');
      }
    }catch(e){
      print('Error: $e');
    }finally{
      isLoading.value= true;
    }
  }
}