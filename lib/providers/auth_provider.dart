import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:ebra_w_5et/models/auth_modal.dart';
import 'package:ebra_w_5et/models/user_modal.dart';
import 'package:flutter/material.dart';

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
    final attributes = [
      AuthUserAttribute(
        userAttributeKey: CognitoUserAttributeKey.name,
        value: name,
      ),
      AuthUserAttribute(
        userAttributeKey: CognitoUserAttributeKey.birthdate,
        value: dateOfBirth,
      ),
      AuthUserAttribute(
        userAttributeKey: CognitoUserAttributeKey.address,
        value: country,
      ),
      AuthUserAttribute(
        userAttributeKey: CognitoUserAttributeKey.phoneNumber,
        value: phoneNumber,
      ),
    ];

    try {
      final result = await Amplify.Auth.updateUserAttributes(
        attributes: attributes,
      );
      result.forEach((key, value) {
        if (value.nextStep.updateAttributeStep ==
            'CONFIRM_ATTRIBUTE_WITH_CODE') {
          final destination = value.nextStep.codeDeliveryDetails?.destination;
          print('Confirmation code sent to $destination for $key');
        } else {
          print('Update completed for $key');
        }
      });
      print(result);
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
