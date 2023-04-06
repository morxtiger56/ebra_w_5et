import 'dart:convert';

class AddressModal {
  String id;
  String city;
  String area;
  String buildingNumber;
  String apartmentNumber;
  String addressDetails;
  String country;
  bool isDefault;

  AddressModal({
    required this.id,
    required this.city,
    required this.area,
    required this.buildingNumber,
    required this.apartmentNumber,
    required this.addressDetails,
    required this.country,
    required this.isDefault,
  });

  AddressModal copyWith({
    String? id,
    String? city,
    String? area,
    String? buildingNumber,
    String? apartmentNumber,
    String? addressDetails,
    String? country,
    bool? isDefault,
  }) {
    return AddressModal(
      id: id ?? this.id,
      city: city ?? this.city,
      area: area ?? this.area,
      buildingNumber: buildingNumber ?? this.buildingNumber,
      apartmentNumber: apartmentNumber ?? this.apartmentNumber,
      addressDetails: addressDetails ?? this.addressDetails,
      country: country ?? this.country,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'city': city,
      'area': area,
      'buildingNumber': buildingNumber,
      'apartmentNumber': apartmentNumber,
      'addressDetails': addressDetails,
      'country': country,
      'isDefault': isDefault,
    };
  }

  factory AddressModal.fromMap(Map<String, dynamic> map) {
    return AddressModal(
      id: map['id'] ?? '',
      city: map['city'] ?? '',
      area: map['area'] ?? '',
      buildingNumber: map['buildingNumber'] ?? '',
      apartmentNumber: map['apartmentNumber'] ?? '',
      addressDetails: map['addressDetails'] ?? '',
      country: map['country'] ?? '',
      isDefault: map['isDefault'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModal.fromJson(String source) =>
      AddressModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressModal(id: $id, city: $city, area: $area, buildingNumber: $buildingNumber, apartmentNumber: $apartmentNumber, addressDetails: $addressDetails, country: $country, isDefault: $isDefault)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressModal &&
        other.id == id &&
        other.city == city &&
        other.area == area &&
        other.buildingNumber == buildingNumber &&
        other.apartmentNumber == apartmentNumber &&
        other.addressDetails == addressDetails &&
        other.country == country &&
        other.isDefault == isDefault;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        city.hashCode ^
        area.hashCode ^
        buildingNumber.hashCode ^
        apartmentNumber.hashCode ^
        addressDetails.hashCode ^
        country.hashCode ^
        isDefault.hashCode;
  }
}
