import 'package:flutter/material.dart';
import 'package:heat_portal/Screens/admin_dashboard.dart';
import 'package:heat_portal/Services/create_iti.dart';
import 'package:get/get.dart';
import 'package:heat_portal/WIdgets/appbar.dart';
import 'package:heat_portal/WIdgets/input_field.dart';
import 'package:heat_portal/utils/pdf_all_iti_page.dart';
import 'package:intl/intl.dart';

import 'all_itinerary.dart';

class DesktopStepper extends StatefulWidget {
  @override
  _DesktopStepperState createState() => _DesktopStepperState();
}

class _DesktopStepperState extends State<DesktopStepper> {
  final CreateItineraryService createItineraryService = Get.put(
    CreateItineraryService(),
  );
  int _currentStep = 0;

  final List<String> steps = [
    "Personal Info",
    "Address Details",
    "Confirmation",
  ];

  @override
  void initState() {
    super.initState();
    createItineraryService.addNewDay();
  }

  void _nextStep() async {
    if (_currentStep == 0) {
      Map<String, dynamic> cust_data = {
        "name": createItineraryService.clientnamecontroller.text.trim(),
        "email": createItineraryService.clientemailcontroller.text.trim(),
        "phone": createItineraryService.clientphonecontroller.text.trim(),
        "nationality": createItineraryService.nationality.value,
        "emergencyContact":
            createItineraryService.client_emergency_contact.text.trim(),
        "language": createItineraryService.client_language.text.trim(),
      };
      await createItineraryService.createcustomer(cust_data);
    } else if (_currentStep == 1) {
      Map<String, dynamic> iti_data =
          createItineraryService.buildItineraryData();
      await createItineraryService.additinerary(iti_data);
    }

    if (_currentStep < steps.length - 1) {
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  Widget _clientAgentInfo() {
    return Column(
      children: [
        CustomTextField(
          controller: createItineraryService.agentnamecontroller,
          hint: 'Enter Agent Email',
        ),
        CustomTextField(
          controller: createItineraryService.agentemailcontroller,
          hint: 'Enter Agent Name',
        ),
        CustomTextField(
          controller: createItineraryService.agentphonecontroller,
          hint: 'Enter Agent Phone',
        ),
        CustomTextField(
          controller: createItineraryService.clientnamecontroller,
          hint: 'Enter Client Name',
        ),
        CustomTextField(
          controller: createItineraryService.clientemailcontroller,
          hint: 'Enter Client Email',
        ),
        CustomTextField(
          controller: createItineraryService.clientphonecontroller,
          hint: 'Enter Client Phone',
        ),
        CustomTextField(
          controller: createItineraryService.numAdultscontroller,
          hint: 'Enter Number of Adults',
        ),
        CustomTextField(
          controller: createItineraryService.numChildrencontroller,
          hint: 'Enter Number of Children',
        ),
        CustomTextField(
          controller: createItineraryService.client_emergency_contact,
          hint: 'Enter Client Emergency Contact',
        ),
        CustomTextField(
          controller: createItineraryService.client_language,
          hint: 'Enter Client Language',
        ),
        DropdownButton<String>(
          value:
              createItineraryService.nationality.value.isEmpty
                  ? null
                  : createItineraryService.nationality.value,
          onChanged: (String? newValue) {
            if (newValue != null) {
              createItineraryService.nationality.value = newValue;
            }
          },
          items:
              createItineraryService.nationalities
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                  .toList(),
        ),
      ],
    );
  }

  Widget _itineraryInfo() {
    return Column(
      children: [
        Row(
          children: [
            Text('Start Date'),
            ElevatedButton(
              onPressed: () {
                createItineraryService.pickDate(context, true);
              },
              child: Obx(
                () => Text(
                  createItineraryService.startdate.value != null
                      ? createItineraryService.startdate.value!
                          .toLocal()
                          .toString()
                          .split(' ')[0]
                      : 'Select Start Date',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),

        Row(
          children: [
            Text("End Date: "),
            ElevatedButton(
              onPressed: () {
                createItineraryService.pickDate(context, false);
              },
              child: Obx(
                () => Text(
                  createItineraryService.enddate.value != null
                      ? createItineraryService.enddate.value!
                          .toLocal()
                          .toString()
                          .split(' ')[0]
                      : 'Select End Date',
                ),
              ),
            ),
            SizedBox(width: 20),
            Text(
              "${createItineraryService.numberofdays.value.toString()} days",
            ),
            SizedBox(width: 20),
            Text(
              "${createItineraryService.numberofnights.value.toString()} nights",
            ),
          ],
        ),
        CustomTextField(
          controller: createItineraryService.tourCodecontroller,
          hint: 'Enter Tour Code',
        ),
        CustomTextField(
          controller: createItineraryService.destinationcontroller,
          hint: 'Enter Destination',
        ),
        CustomTextField(
          controller: createItineraryService.arrivalcontroller,
          hint: 'Enter Arrival Place',
        ),
        CustomTextField(
          controller: createItineraryService.descrptioncontroller,
          hint: 'Enter Description',
        ),
        SizedBox(height: 20),
        buildDayWiseUI(),
      ],
    );
  }

  Widget buildDayWiseUI() {
    return Obx(
      () => Column(
        children: List.generate(createItineraryService.daywiseList.length, (
          index,
        ) {
          final dayData = createItineraryService.daywiseList[index];

          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dayData.Label,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed:
                            () => createItineraryService.removeDay(index),
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Destination Field
                  TextField(
                    decoration: InputDecoration(hintText: 'Destination'),
                    onChanged: (value) {
                      createItineraryService.daywiseList[index] = dayData
                          .copyWith(destination: value);
                    },
                    controller: TextEditingController(text: dayData.destination)
                      ..selection = TextSelection.collapsed(
                        offset: dayData.destination.length,
                      ),
                  ),

                  // Notes Field
                  TextField(
                    decoration: InputDecoration(hintText: 'Notes'),
                    onChanged: (value) {
                      createItineraryService.daywiseList[index] = dayData
                          .copyWith(notes: value);
                    },
                    controller: TextEditingController(text: dayData.notes)
                      ..selection = TextSelection.collapsed(
                        offset: dayData.notes.length,
                      ),
                  ),

                  const SizedBox(height: 8),

                  // Date and Day Text
                  Text("Date: ${dayData.date}"),
                  Text("Day: ${dayData.day}"),

                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _confirmation() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('Confirm the Itinerary details'),
          Text('Agent Name: ${createItineraryService.agentnamecontroller.text}'),
          Text(
            'Agent Email: ${createItineraryService.agentemailcontroller.text}',
          ),
          Text(
            'Agent Phone: ${createItineraryService.agentphonecontroller.text}',
          ),
          Text(
            'Client Name: ${createItineraryService.clientnamecontroller.text}',
          ),
          Text(
            'Client Email: ${createItineraryService.clientemailcontroller.text}',
          ),
          Text(
            'Client Phone: ${createItineraryService.clientphonecontroller.text}',
          ),
          Text(
            'Client Emergency Contact: ${createItineraryService.client_emergency_contact.text}',
          ),
          Text('Client Language: ${createItineraryService.client_language.text}'),
          Text('Nationality: ${createItineraryService.nationality.value}'),
          Text(
            'Number of Adults: ${createItineraryService.numAdultscontroller.text}',
          ),
          Text(
            'Number of Children: ${createItineraryService.numChildrencontroller.text}',
          ),
          Text('Tour Code: ${createItineraryService.tourCodecontroller.text}'),
          Text(
            'Destination: ${createItineraryService.destinationcontroller.text}',
          ),
          Text('Arrival: ${createItineraryService.arrivalcontroller.text}'),
          Text(
            'Description: ${createItineraryService.descrptioncontroller.text}',
          ),
          Text(
            'Start Date: ${createItineraryService.startdate.value != null ? createItineraryService.startdate.value!.toLocal().toString().split(' ')[0] : 'Select Start Date'}',
          ),
          Text(
            'End Date: ${createItineraryService.enddate.value != null ? createItineraryService.enddate.value!.toLocal().toString().split(' ')[0] : 'Select End Date'}',
          ),
          Text(
            'Number of Days: ${createItineraryService.numberofdays.value.toString()}',
          ),
          Text(
            'Number of Nights: ${createItineraryService.numberofnights.value.toString()}',
          ),
          Obx(
            () => Column(
              children: List.generate(createItineraryService.daywiseList.length, (
                index,
              ) {
                final dayData = createItineraryService.daywiseList[index];
      
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
      
                    // Destination Field
                    Text(dayData.destination),
                    Text(dayData.Label),
                    Text(dayData.date),
                    Text(dayData.day),
                    Text(dayData.notes),
                  ],
                );
              }),
            ),
          ),
          TextButton(onPressed: (){
            Get.to(PdfGenerator());
          }, child: Text('Print PDF'))
        ],
      ),
    );
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 0:
        return Center(child: _clientAgentInfo());
      case 1:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _itineraryInfo(),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: createItineraryService.addNewDay,
                child: Text("Add Another Day"),
              ),
            ],
          ),
        );
      case 2:
        return Center(child: _confirmation());
      default:
        return Center(child: Text("Unknown step"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: (){
              Get.to(Dashboard());},
            child: Appbar()),
        actions: [
          IconButton(onPressed: (){
            Get.to(AllItinerary());
          }, icon: Icon(Icons.find_replace_sharp))
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _currentStep,
            onDestinationSelected:
                (index) => setState(() => _currentStep = index),
            labelType: NavigationRailLabelType.all,
            destinations:
                steps
                    .map(
                      (step) => NavigationRailDestination(
                        icon: Icon(Icons.check_circle_outline),
                        selectedIcon: Icon(Icons.check_circle),
                        label: Text(step),
                      ),
                    )
                    .toList(),
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _buildStepContent(_currentStep)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (_currentStep > 0)
                        ElevatedButton(
                          onPressed: _previousStep,
                          child: Text("Back"),
                        ),
                      SizedBox(width: 12),
                      if (_currentStep < steps.length - 1)
                        ElevatedButton(
                          onPressed: _nextStep,
                          child: Text("Next"),
                        )
                      else
                        ElevatedButton(onPressed: () {}, child: Text("Submit")),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
