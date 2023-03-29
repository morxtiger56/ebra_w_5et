import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:ebra_w_5et/models/auth_modal.dart';
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

  AuthProvider();
  // Create a boolean for checking the sign up status
  bool isSignUpComplete = false;

  Future<void> signUpUser(String email, String password) async {
    try {
      await getUserAttributes();
      if (authData == null) {
        return;
      }
      authData!.email = email;
      authData!.password = password;

      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.sub: authData!.id.toString(),
      };
      final result = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      isSignUpComplete = result.isSignUpComplete;
    } on AuthException catch (e) {
      safePrint(e.message);
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
      final result =
          await Amplify.Auth.updateUserAttributes(attributes: attributes);
      result.forEach((key, value) {
        if (value.nextStep.updateAttributeStep ==
            'CONFIRM_ATTRIBUTE_WITH_CODE') {
          final destination = value.nextStep.codeDeliveryDetails?.destination;
          print('Confirmation code sent to $destination for $key');
        } else {
          print('Update completed for $key');
        }
      });
    } on AmplifyException catch (e) {
      print(e.message);
      rethrow;
    }
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

      isSignUpComplete = result.isSignUpComplete;
      print("confirmed");
      authState = AuthState.completeProfile;
    } on AuthException catch (e) {
      safePrint(e.message);
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
      safePrint(userSession.identityId);
      authData = AuthData(
        authToken: "",
        id: getStringAfterEuWest1(userSession.identityId!)!,
        email: "",
        password: "",
        isSignedIn: false,
        isSignUpComplete: false,
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
