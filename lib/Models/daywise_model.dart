class DayWise {
  final String day;
  final String date;
  final String destination;
  final String notes;

  DayWise({
    required this.day,
    required this.date,
    required this.destination,
    required this.notes,
  });

  factory DayWise.fromJson(Map<String, dynamic> json) => DayWise(
    day: json['day'] ?? '',
    date: json['date'] ?? '',
    destination: json['destination'] ?? '',
    notes: json['notes'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'day': day,
    'date': date,
    'destination': destination,
    'notes': notes,
  };
}
