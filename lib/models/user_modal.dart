import 'dart:convert';

class User {
  String id;
  String name;
  String email;
  List<String> likedProducts;
  String dateOfBirth;
  String phoneNumber;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.likedProducts,
    required this.dateOfBirth,
    required this.phoneNumber,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    List<String>? likedProducts,
    String? dateOfBirth,
    String? phoneNumber,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      likedProducts: likedProducts ?? this.likedProducts,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'likedProducts': likedProducts,
      'dateOfBirth': dateOfBirth,
      'phoneNumber': phoneNumber,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      likedProducts: List<String>.from(map['likedProducts']),
      dateOfBirth: map['dateOfBirth'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, likedProducts: $likedProducts, dateOfBirth: $dateOfBirth, phoneNumber: $phoneNumber)';
  }
}
