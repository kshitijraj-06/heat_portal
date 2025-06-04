class DayWise {
  final String Label;
  final String day;
  final String date;
  final String destination;
  final String notes;

  DayWise({
    required this.Label,
    required this.day,
    required this.date,
    required this.destination,
    required this.notes,
  });

  DayWise copyWith({
    String? Label,
    String? day,
    String? date,
    String? destination,
    String? notes,
  }) {
    return DayWise(
      Label: Label ?? this.Label,
      day: day ?? this.day,
      date: date ?? this.date,
      destination: destination ?? this.destination,
      notes: notes ?? this.notes,
    );
  }

  factory DayWise.fromJson(Map<String, dynamic> json) => DayWise(
    Label: json['Label'] ?? '',
    day: json['day'] ?? '',
    date: json['date'] ?? '',
    destination: json['destination'] ?? '',
    notes: json['notes'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'Label': Label,
    'day': day,
    'date': date,
    'destination': destination,
    'notes': notes,
  };
}
