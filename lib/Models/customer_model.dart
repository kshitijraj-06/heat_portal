class Customer {
  final String customerId;
  final String clientName;
  final String clientEmail;
  final String clientPhone;
  final String nationality;
  final String clientEmergencyPhone;
  final String clientLanguage;
  final List<dynamic> itineraries;

  Customer({
    required this.customerId,
    required this.clientName,
    required this.clientEmail,
    required this.clientPhone,
    required this.nationality,
    required this.clientEmergencyPhone,
    required this.clientLanguage,
    required this.itineraries,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerId: json['customerId'],
      clientName: json['clientName'],
      clientEmail: json['clientEmail'],
      clientPhone: json['clientPhone'],
      nationality: json['nationality'],
      clientEmergencyPhone: json['clientEmergencyPhone'] ?? '',
      clientLanguage: json['clientLanguage'] ?? '',
      itineraries: json['itineraries'] ?? [],
    );
  }
}
