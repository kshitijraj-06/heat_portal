import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heat_portal/WIdgets/appbar.dart';

import '../../Services/create_iti.dart';

class CreateItinerary_Step2 extends StatefulWidget{
  @override
  State<CreateItinerary_Step2> createState() => _CreateItinerary_Step2State();
}

class _CreateItinerary_Step2State extends State<CreateItinerary_Step2> {
  final CreateItineraryService createItineraryService = Get.put(CreateItineraryService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Appbar(),
      ),
      body: Column(
        children: [
          Obx(() => Card(
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tour Duration",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Start Date
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Start Date"),
                    subtitle: Text(
                      createItineraryService.startdate.value != null
                          ? "${createItineraryService.startdate.value!.toLocal()}".split(' ')[0]
                          : "Select start date",
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () => createItineraryService.pickDate(context, true),
                  ),

                  // End Date
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("End Date"),
                    subtitle: Text(
                      createItineraryService.enddate.value != null
                          ? "${createItineraryService.enddate.value!.toLocal()}".split(' ')[0]
                          : "Select end date",
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () => createItineraryService.pickDate(context, false),
                  ),

                  const Divider(height: 32),

                  // Duration Display
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Duration:",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "${createItineraryService.numberofnights.value} Nights / ${createItineraryService.numberofdays.value} Days",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}