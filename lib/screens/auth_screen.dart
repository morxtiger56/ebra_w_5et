import 'package:ebra_w_5et/widgets/complete_profile_form_widget.dart';
import 'package:ebra_w_5et/widgets/confirm_code_form_widget.dart';
import 'package:ebra_w_5et/widgets/login_form_widget.dart';
import 'package:ebra_w_5et/widgets/register_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthState _currentState = AuthState.login;
  String email = '';

  //TODO: make forms dynamic

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _changeCurrentState() {
    Provider.of<AuthProvider>(
      context,
      listen: false,
    ).changeAuthState("AuthMode");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/logo.png"),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Login"),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 5,
                  ),
                  Consumer<AuthProvider>(builder: (_, value, child) {
                    if (value.authState == AuthState.login) {
                      return LoginFormWidget(
                        changeStateFunction: _changeCurrentState,
                      );
                    } else if (value.authState == AuthState.register) {
                      return RegisterFormWidget(
                        changeStateFunction: _changeCurrentState,
                      );
                    } else if (value.authState == AuthState.completeProfile) {
                      return CompleteProfileFormWidget();
                    } else if (value.authState == AuthState.confirmCode) {
                      return const ConfirmCodeFormWidget();
                    }
                    return const Text("auth");
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
