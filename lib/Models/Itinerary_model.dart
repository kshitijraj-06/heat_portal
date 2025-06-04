import 'daywise_model.dart';

class Itinerary {
  final String itineraryId;
  final String agentName;
  final String agentEmail;
  final String agentPhone;
  final String numAdult;
  final String numChildren;
  final String tourCode;
  final String destination;
  final String duration;
  final String startDate;
  final String endDate;
  final String noOfDays;
  final String noOfNights;
  final String arrival;
  final List<DayWise> dayWiseList;

  Itinerary({
    required this.itineraryId,
    required this.agentName,
    required this.agentEmail,
    required this.agentPhone,
    required this.numAdult,
    required this.numChildren,
    required this.tourCode,
    required this.destination,
    required this.duration,
    required this.startDate,
    required this.endDate,
    required this.noOfDays,
    required this.noOfNights,
    required this.arrival,
    required this.dayWiseList,
  });

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    try {
      return Itinerary(
        itineraryId: json['itineraryId'],
        agentName: json['agentName'],
        agentEmail: json['agentEmail'],
        agentPhone: json['agentPhone'],
        numAdult: json['numAdult'],
        numChildren: json['numChildren'],
        tourCode: json['tourCode'],
        destination: json['destination'],
        duration: json['duration'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        noOfDays: json['noOfDays'],
        noOfNights: json['noOfNights'],
        arrival: json['arrival'],
        dayWiseList: (json['dayWiseList'] as List? ?? [])
            .map((day) => DayWise.fromJson(day))
            .toList(),
      );
    }catch(e, stack){
      print(e);
      print(stack);
      rethrow;
    }
  }


  Map<String, dynamic> toJson() {
    return {
      'itineraryId': itineraryId,
      'agentName': agentName,
      'agentEmail': agentEmail,
      'agentPhone': agentPhone,
      'numAdult': numAdult,
      'numChildren': numChildren,
      'tourCode': tourCode,
      'destination': destination,
      'duration': duration,
      'startDate': startDate,
      'endDate': endDate,
      'noOfDays': noOfDays,
      'noOfNights': noOfNights,
      'arrival': arrival,
      'dayWiseList': dayWiseList.map((day) => day.toJson()).toList(),
    };
  }
}
