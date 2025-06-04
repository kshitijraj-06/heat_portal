import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/daywise_model.dart';

class DayItinerary {
  final TextEditingController dayController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  DateTime? date;

  void setDate(DateTime newDate) {
    date = newDate;
    dayController.text = getDayFromDate(newDate);
  }

  String getDayFromDate(DateTime date) {
    return DateFormat('EEEE').format(date); // e.g., Monday
  }

  DayWise toModel() {
    return DayWise(
      day: dayController.text,
      date: date?.toIso8601String() ?? '',
      destination: destinationController.text,
      notes: notesController.text,
    );
  }

  void dispose() {
    dayController.dispose();
    destinationController.dispose();
    notesController.dispose();
  }
}
