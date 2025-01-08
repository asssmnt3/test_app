class Contact {
  final int? id;
  final String name;
  final String phone;

  Contact({this.id, required this.name, required this.phone});

  // Konversi dari Map ke Contact
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
    );
  }

  // Konversi dari Contact ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }
}
