import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Models/customer_model.dart';


class CustomerController extends GetxController {
  var allCustomers = <Customer>[].obs;
  var filteredCustomers = <Customer>[].obs;
  var isLoading = false.obs;


  Future<List<Customer>> fetchCustomers() async {
    isLoading.value = true;
    final storage = FlutterSecureStorage();
    String? url = await storage.read(key: 'url');

    final response = await http.get(
      Uri.parse('http://$url:8080/api/customers'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'token')}'
      },
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final List customerData = jsonBody['data'];

      // Parse into model
      final List<Customer> customers = customerData
          .map((c) => Customer.fromJson(c))
          .cast<Customer>()
          .toList();

      // Assign to observables
      allCustomers.assignAll(customers);
      filteredCustomers.assignAll(customers);

      isLoading.value = false;
      return customers;
    } else {
      print("Error response: ${response.body}");
      isLoading.value = false;
      throw Exception('Failed to load customers');
    }


  }

  void filterCustomers(String query) {
    if (query.isEmpty) {
      filteredCustomers.assignAll(allCustomers);
    } else {
      filteredCustomers.assignAll(
        allCustomers.where((customer) =>
        customer.clientName.toLowerCase().contains(query.toLowerCase()) ||
            customer.clientEmail.toLowerCase().contains(query.toLowerCase())
        ).toList(),
      );
    }
  }
}
