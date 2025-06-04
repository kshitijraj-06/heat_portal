import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Services/viewCustomer_service.dart';
import '../../WIdgets/appbar.dart';

class ViewCostumer extends StatefulWidget {

  ViewCostumer({super.key});

  @override
  State<ViewCostumer> createState() => _ViewCostumerState();
}



class _ViewCostumerState extends State<ViewCostumer> {
  final CustomerController controller = Get.put(CustomerController());


  @override
  void initState() {
    super.initState();
    controller.fetchCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: InkWell(
              onTap: (){
                Get.offAllNamed('/dashboard');
              },
              child: Appbar())
      ),
      backgroundColor: const Color(0xFFF5F7FB),
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Center(
              child: Text(
                'CUSTOMERS',
                style: GoogleFonts.merriweather(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search employees by name or email',
                      prefixIcon: Icon(Icons.search, size: 30),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      isDense: true,
                    ),
                    onChanged: (query) => controller.filterCustomers(query),
                  ),
                ), //TODO: Search Bar
                const SizedBox(width: 24),
              ],
            ),
            const SizedBox(height: 24),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.filteredCustomers.isEmpty) {
                  return Center(child: Text('No customer Found'));
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: 1.7,
                  ),
                  itemCount: controller.filteredCustomers.length,
                  itemBuilder: (context, index) {
                    final customer = controller.filteredCustomers[index];
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: Color(0xFFF5F7FB),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.grey[300],
                                  child: Text(
                                    customer.clientName[0].toUpperCase(),
                                    style: GoogleFonts.urbanist(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF151B32),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        customer.clientName,
                                        style: GoogleFonts.urbanist(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Color(0xFF151B32),
                                        ),
                                      ),
                                      Text(
                                        customer.clientPhone,
                                        style: GoogleFonts.urbanist(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        customer.clientLanguage,
                                        style: GoogleFonts.urbanist(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        customer.clientEmail,
                                        style: GoogleFonts.urbanist(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        customer.nationality,
                                        style: GoogleFonts.urbanist(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                      // Optionally add location here if available
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ), //TODO: customer Grid
          ],
        ),
      ),
    );
  }
}
