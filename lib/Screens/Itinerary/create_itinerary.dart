import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heat_portal/Services/create_iti.dart';
import 'package:heat_portal/WIdgets/appbar.dart';

import '../../WIdgets/input_field.dart';
import '../../utils/pdf_itinerary.dart';

class CreateItineraryStepper extends StatefulWidget {
  @override
  State<CreateItineraryStepper> createState() => _CreateItineraryStepperState();
}

class _CreateItineraryStepperState extends State<CreateItineraryStepper> {
  final CreateItineraryService createItineraryService = Get.put(CreateItineraryService());
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Appbar()
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _nextStep,
        onStepCancel: _previousStep,
        type: StepperType.vertical,
        controlsBuilder: (context, details) {
          return Row(
            children: [
              ElevatedButton(
                onPressed: details.onStepContinue,
                child: Text(_currentStep == 2 ? 'Finish' : 'Next'),
              ),
              if (_currentStep > 0)
                TextButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Back'),
                ),
            ],
          );
        },
        steps: [
          // STEP 1: Client & Agent Info
          Step(
            title: const Text("Client & Agent Info"),
            isActive: _currentStep >= 0,
            content: Column(
              children: [
                Text('Agent Details'),
                CustomTextField(
                  controller: createItineraryService.agentnamecontroller,
                  hint: 'Enter Agent Name',
                ),
                CustomTextField(
                  controller: createItineraryService.agentemailcontroller,
                  hint: 'Enter Agent Email',
                ),
                CustomTextField(
                  controller: createItineraryService.agentphonecontroller,
                  hint: 'Enter Agent Phone Number',
                  isNumber: true,
                ),
                const SizedBox(height: 10),
                Text('Client Detials',
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
                  isNumber: true,
                ),
                CustomTextField(
                  controller: createItineraryService.numAdultscontroller,
                  hint: 'Number of Adults',
                  isNumber: true,
                ),
                CustomTextField(
                  controller: createItineraryService.numChildrencontroller,
                  hint: 'Number of Children',
                  isNumber: true,
                ),
                CustomDropdown(
                  value: createItineraryService.nationality.value.isEmpty
                      ? null
                      : createItineraryService.nationality.value,
                  items: ['Indian', 'Foreigner'],
                  hint: 'Select Nationality',
                  onChanged: (val) =>
                  createItineraryService.nationality.value = val ?? '',
                ),
              ],
            ),
          ),

          // STEP 2: Tour Duration
          Step(
            title: const Text("Tour Duration"),
            isActive: _currentStep >= 1,
            content: Obx(() => Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Dates",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      title: const Text("Start Date"),
                      subtitle: Text(
                        createItineraryService.startdate.value != null
                            ? "${createItineraryService.startdate.value!.toLocal()}".split(' ')[0]
                            : "Select start date",
                      ),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () => createItineraryService.pickDate(context, true),
                    ),
                    ListTile(
                      title: const Text("End Date"),
                      subtitle: Text(
                        createItineraryService.enddate.value != null
                            ? "${createItineraryService.enddate.value!.toLocal()}".split(' ')[0]
                            : "Select end date",
                      ),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () => createItineraryService.pickDate(context, false),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Duration:"),
                        Text(
                          "${createItineraryService.numberofnights.value} Nights / ${createItineraryService.numberofdays.value} Days",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
          ),

          // STEP 3: Summary
          // STEP 4: Itinerary Details
          Step(
            title: const Text("Itinerary Details"),
            isActive: _currentStep >= 3,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: createItineraryService.tourCodecontroller,
                  hint: 'Enter Tour Code / ID',
                ),
                CustomTextField(
                  controller: createItineraryService.destinationcontroller,
                  hint: 'Enter Destination (e.g., Gangtok, Darjeeling)',
                ),
                CustomTextField(
                  controller: createItineraryService.descrptioncontroller,
                  hint: 'Brief Description',
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Day-wise Highlights',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // Day-wise Itinerary Details
                const SizedBox(height: 16),
                const Text(
                  'Day-wise Itinerary',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),

                Obx(() => Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: createItineraryService.dayWiseControllers.length,
                      itemBuilder: (context, index) {
                        return CustomTextField(
                          controller: createItineraryService.dayWiseControllers[index],
                          hint: 'Day ${index + 1} Details',
                          maxLines: 3,
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          createItineraryService.addDayController();
                        },
                        icon: Icon(Icons.add),
                        label: const Text("Add Day"),
                      ),
                    )
                  ],
                )),

              ],
            ),
          ),

          Step(
            title: const Text("Summary"),
            isActive: _currentStep >= 2,
            content: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Agent Name: ${createItineraryService.agentnamecontroller.text}"),
                Text("Agent Email: ${createItineraryService.agentemailcontroller.text}"),
                Text("Agent Phone Number: ${createItineraryService.agentphonecontroller.text}"),
                Text("Client Name: ${createItineraryService.clientnamecontroller.text}"),
                Text("Client Email: ${createItineraryService.clientemailcontroller.text}"),
                Text("Client Phone Number: ${createItineraryService.clientphonecontroller.text}"),
                Text("Client's Family(Adults): ${createItineraryService.numAdultscontroller.text}"),
                Text("Nationality: ${createItineraryService.nationality.value}"),
                const SizedBox(height: 10),
                Text("Tour Duration: ${createItineraryService.numberofnights.value} Nights / ${createItineraryService.numberofdays.value} Days"),
                const Text('Itinerary Highlights:'),
                ...createItineraryService.dayWiseControllers.asMap().entries.map((entry) {
                  int index = entry.key;
                  String text = entry.value.text;
                  return Text('Day ${index + 1}: $text');
                }).toList(),

                ElevatedButton.icon(
                  onPressed: () {
                    PdfGenerator.generateItineraryPdf(createItineraryService);
                  },
                  icon: Icon(Icons.picture_as_pdf),
                  label: Text("Export PDF"),
                ),

              ],
            )),
          ),
        ],
      ),
    );
  }
}
