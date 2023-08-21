import 'dart:convert';


class User {

  final int? id;
   String name;
   String email;
   String phone;
  final String institute;
  final String specialization;
  final String role;
  final String password;

  User({

    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.institute,
    required this.specialization,
    required this.role,
    required this.password,
  });

 // Convert an User into a Map. The keys must correspond to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'institute': institute,
      'specialization': specialization,
      'role': role,
      'password': password,
    };
  }

  // Convert an User into a Map. The keys must correspond to the names of the
  // columns in the database.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      institute: map['institute'] ?? '',
      specialization: map['specialization'] ?? '',
      role: map['role'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
  // Implement toString to make it easier to see information about each info when using the print statement.
  @override
  String toString() =>
      'Info(id: $id,name: $name, email: $email, phone: $phone, institute: $institute, specialization: $specialization, role: $role, password: $password,)';
}
