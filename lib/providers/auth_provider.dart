import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:ebra_w_5et/models/auth_modal.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  AuthData? authData;

  AuthProvider();
  // Create a boolean for checking the sign up status
  bool isSignUpComplete = false;

  Future<void> signUpUser() async {
    try {
      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: 'email@domain.com',
        CognitoUserAttributeKey.phoneNumber: '+15559101234',
        // additional attributes as needed
      };
      final result = await Amplify.Auth.signUp(
        username: 'myusername',
        password: 'mysupersecurepassword',
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      isSignUpComplete = result.isSignUpComplete;
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  Future<void> confirmUser() async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
          username: 'myusername', confirmationCode: '123456');

      isSignUpComplete = result.isSignUpComplete;
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  Future<void> signInUser(String username, String password) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
    } on AuthException catch (e) {
      safePrint(e.message);
    }
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
        id: userSession.identityId!,
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
