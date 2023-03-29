import 'dart:convert';

class AuthData {
  String _authToken;

  String _id;
  String email;
  String password;
  bool _isSignedIn;

  bool isSignUpComplete;

  String get authToken => _authToken;

  set authToken(String value) {
    _authToken = value;
  }

  bool get isSignedIn => _isSignedIn;

  set isSignedIn(bool value) {
    _isSignedIn = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  AuthData({
    required String authToken,
    required String id,
    required this.email,
    required this.password,
    required bool isSignedIn,
    required this.isSignUpComplete,
  })  : _isSignedIn = isSignedIn,
        _id = id,
        _authToken = authToken;

  AuthData copyWith({
    String? authToken,
    String? id,
    String? email,
    String? password,
    bool? isSignedIn,
    bool? isSignUpComplete,
  }) {
    return AuthData(
      authToken: authToken ?? this.authToken,
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      isSignedIn: isSignedIn ?? this.isSignedIn,
      isSignUpComplete: isSignUpComplete ?? this.isSignUpComplete,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'authToken': authToken,
      'id': id,
      'email': email,
      'password': password,
      'isSignedIn': isSignedIn,
      'isSignUpComplete': isSignUpComplete,
    };
  }

  factory AuthData.fromMap(Map<String, dynamic> map) {
    return AuthData(
      authToken: map['authToken'] ?? '',
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      isSignedIn: map['isSignedIn'] ?? false,
      isSignUpComplete: map['isSignUpComplete'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthData.fromJson(String source) =>
      AuthData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthData(authToken: $authToken, id: $id, email: $email, password: $password, isSignedIn: $isSignedIn, isSignUpComplete: $isSignUpComplete)';
  }
}
