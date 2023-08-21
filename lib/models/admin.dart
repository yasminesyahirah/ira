import 'dart:convert';

class Admin {
  String username;
  String password;

  Admin({
    required this.username,
    required this.password,
  });


 // Convert an Info into a Map. The keys must correspond to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'name': username,
      'password': password,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      username: map['name'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory Admin.fromJson(String source) => Admin.fromMap(json.decode(source));
  // Implement toString to make it easier to see information about each info when using the print statement.
  @override
  String toString() =>
      'Info( username: $username, password: $password,)'; //id: $id,
}

