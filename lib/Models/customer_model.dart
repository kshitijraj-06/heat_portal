class Customer{
  final String id;
  final String name;
  final int age;
  final String email;
  final String phone;
  final String address;

  Customer({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
    required this.phone,
    required this.address,
});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
    );
  }
}