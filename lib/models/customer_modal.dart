class Customer {
  String first_name;
  String last_name;
  String email;
  String phone_number;
  String password;

  Customer({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.phone_number,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map.addAll({
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'phone_number': phone_number,
      'password': password,
      'username': email,
    });

    return map;
  }
}
