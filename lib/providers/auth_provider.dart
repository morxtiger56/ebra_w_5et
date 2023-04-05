import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:ebra_w_5et/models/auth_modal.dart';
import 'package:ebra_w_5et/models/user_modal.dart';
import 'package:flutter/foundation.dart';

enum AuthState {
  login,
  register,
  confirmCode,
  completeProfile,
}

class AuthProvider with ChangeNotifier {
  //TODO: add user current state of login
  AuthData? authData;
  AuthState authState = AuthState.login;
  User user = User(
    id: "",
    name: "",
    email: "",
    likedProducts: [],
    dateOfBirth: "",
    phoneNumber: "",
    addresses: [],
  );
  AuthProvider();
  // Create a boolean for checking the sign up status
  bool isSignUpComplete = false;
  bool isSignedIn = false;

  Future<void> signUpUser(String email, String password) async {
    try {
      authData ??= AuthData(
        authToken: "",
        id: "",
        email: "",
        password: "",
        isSignedIn: false,
        isSignUpComplete: false,
      );
      authData!.email = email;
      authData!.password = password;

      final result = await Amplify.Auth.signUp(
        username: email,
        password: password,
      );
      isSignUpComplete = result.isSignUpComplete;
      authState = AuthState.confirmCode;
      notifyListeners();
    } on AuthException {
      rethrow;
    }
  }

  Future<void> updateMultipleUserAttributes({
    name = String,
    dateOfBirth = String,
    country = String,
    phoneNumber = String,
  }) async {
    var body = json.encode({
      "name": name,
      "address": country,
      "phoneNumber": phoneNumber,
      "birthdate": dateOfBirth,
    });
    try {
      await Amplify.API
          .post(
            restOptions: RestOptions(
              path: "/settings",
              apiName: "userApi",
              queryParameters: {
                "id": user.id,
                "operation": "modify user data",
              },
              body: Uint8List.fromList(
                body.codeUnits,
              ),
            ),
          )
          .response;
      isSignedIn = true;
      notifyListeners();
    } on AmplifyException {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> confirmUser(String confirmationCode) async {
    try {
      if (authData == null || authData!.email == "") {
        return;
      }
      final result = await Amplify.Auth.confirmSignUp(
        username: authData!.email,
        confirmationCode: confirmationCode,
      );
      await Amplify.Auth.signIn(
        username: authData!.email,
        password: authData!.password,
      );
      isSignUpComplete = result.isSignUpComplete;

      authState = AuthState.completeProfile;
    } on AuthException {
      rethrow;
    }
    notifyListeners();
  }

  String? getStringAfterEuWest1(String input) {
    const euWest1 = 'eu-west-1:';
    final index = input.indexOf(euWest1);
    if (index == -1) {
      return null;
    }
    return input.substring(index + euWest1.length);
  }

  Future<void> signInUser(String username, String password) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      await getUserAttributes();
      isSignedIn = true;
      notifyListeners();
    } on AuthException {
      rethrow;
    }
  }

  void changeAuthState(String mode) {
    switch (mode) {
      case "AuthMode":
        if (authState == AuthState.register) {
          authState = AuthState.login;
        } else {
          authState = AuthState.register;
        }
        break;

      case "confirmMode":
        authState = AuthState.confirmCode;
        break;
      case "completeProfile":
        authState = AuthState.completeProfile;

        break;

      default:
    }
    notifyListeners();
  }

  Future<void> getUserAttributes() async {
    try {
      final userSession = (await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(
          getAWSCredentials: true,
        ),
      ) as CognitoAuthSession);

      if (!userSession.isSignedIn) {
        authData = AuthData(
          authToken: "",
          id: userSession.userSub!,
          email: "",
          password: "",
          isSignedIn: false,
          isSignUpComplete: false,
        );
        return;
      }

      final userData = await Amplify.Auth.fetchUserAttributes();

      var email = "";
      for (var element in userData) {
        if (element.userAttributeKey == CognitoUserAttributeKey.email) {
          email = element.value;
        }
        if (element.userAttributeKey == CognitoUserAttributeKey.name) {
          user.name = element.value;
        }
      }
      authData = AuthData(
        authToken: userSession.userPoolTokens!.accessToken,
        id: userSession.userSub!,
        email: email,
        password: "",
        isSignedIn: false,
        isSignUpComplete: false,
      );
      if (user.name.isEmpty) {
        authState = AuthState.completeProfile;
        return;
      }
      authData = AuthData(
        authToken: userSession.userPoolTokens!.accessToken,
        id: userSession.userSub!,
        email: email,
        password: "",
        isSignedIn: false,
        isSignUpComplete: true,
      );
      isSignedIn = userSession.isSignedIn;
      authData = AuthData(
        authToken: userSession.userPoolTokens!.accessToken,
        id: userSession.userSub!,
        email: email,
        password: "",
        isSignedIn: true,
        isSignUpComplete: true,
      );
      notifyListeners();
    } on AuthException catch (e) {
      if (e.message == "User not found in the system.") {
        await Amplify.Auth.signOut();
        print("signing out");
      }

      rethrow;
    }
  }
}
