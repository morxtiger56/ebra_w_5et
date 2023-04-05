import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ebra_w_5et/models/address_modal.dart';

class User {
  String id;
  String name;
  String email;
  List<String> likedProducts;
  String dateOfBirth;
  String phoneNumber;
  List<AddressModal> addresses;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.likedProducts,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.addresses,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    List<String>? likedProducts,
    String? dateOfBirth,
    String? phoneNumber,
    List<AddressModal>? addresses,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      likedProducts: likedProducts ?? this.likedProducts,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addresses: addresses ?? this.addresses,
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
      'addresses': addresses.map((x) => x.toMap()).toList(),
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
      addresses: List<AddressModal>.from(
          map['addresses']?.map((x) => AddressModal.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, likedProducts: $likedProducts, dateOfBirth: $dateOfBirth, phoneNumber: $phoneNumber, addresses: $addresses)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        listEquals(other.likedProducts, likedProducts) &&
        other.dateOfBirth == dateOfBirth &&
        other.phoneNumber == phoneNumber &&
        listEquals(other.addresses, addresses);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        likedProducts.hashCode ^
        dateOfBirth.hashCode ^
        phoneNumber.hashCode ^
        addresses.hashCode;
  }
}
