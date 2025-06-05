import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heat_portal/Services/all_iti.dart';
import 'package:heat_portal/WIdgets/appbar.dart';

import '../admin_dashboard.dart';

class AllItinerary extends StatelessWidget {
  final GetAllItinerary getAllItinerary = Get.put(GetAllItinerary());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Get.to(Dashboard());
          },
          child: Appbar(),
        ),
      ),
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              getAllItinerary.fetchItineraries();
            },
            icon: Icon(Icons.add),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: getAllItinerary.itineraries.length,
                itemBuilder: (context, index) {
                  final item = getAllItinerary.itineraries[index];
                  return ListTile(
                    title: Text(item.tourCode),
                    subtitle: Text('${item.startDate} to ${item.endDate}'),
                    onTap: () {
                      // Show detail or navigate to itinerary detail screen
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
