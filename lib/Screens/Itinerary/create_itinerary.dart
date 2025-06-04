import 'package:flutter/material.dart';


class DesktopStepper extends StatefulWidget {
  @override
  _DesktopStepperState createState() => _DesktopStepperState();
}

class _DesktopStepperState extends State<DesktopStepper> {
  int _currentStep = 0;

  final List<String> steps = ["Personal Info", "Address Details", "Confirmation"];

  void _nextStep() {
    if (_currentStep < steps.length - 1) {
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 0:
        return Center(child: Text("Enter your personal information here."));
      case 1:
        return Center(child: Text("Enter your address details here."));
      case 2:
        return Center(child: Text("Confirm your data here."));
      default:
        return Center(child: Text("Unknown step"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _currentStep,
            onDestinationSelected: (index) => setState(() => _currentStep = index),
            labelType: NavigationRailLabelType.all,
            destinations: steps
                .map((step) => NavigationRailDestination(
              icon: Icon(Icons.check_circle_outline),
              selectedIcon: Icon(Icons.check_circle),
              label: Text(step),
            ))
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
                        ElevatedButton(onPressed: _previousStep, child: Text("Back")),
                      SizedBox(width: 12),
                      if (_currentStep < steps.length - 1)
                        ElevatedButton(onPressed: _nextStep, child: Text("Next"))
                      else
                        ElevatedButton(onPressed: () {}, child: Text("Submit")),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
