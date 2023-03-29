import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart' as custom;
import '../ui/form_filed_widget.dart';

class LoginFormWidget extends StatefulWidget {
  final VoidCallback changeStateFunction;

  const LoginFormWidget({
    super.key,
    required this.changeStateFunction,
  });

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKeyGlobal = GlobalKey<FormState>();
  var _loading = false;
  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_formKeyGlobal.currentState != null) {
      _formKeyGlobal.currentState!.dispose();
    }
    _emailController.dispose();
    _passwordController.dispose();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Map<String, String> authData = {
    "email": '',
    "password": '',
  };

  Future<void> _login() async {
    _formKeyGlobal.currentState!.save();
    if (!_formKeyGlobal.currentState!.validate()) {
      return;
    }
    setState(() {
      _loading = true;
    });

    try {
      await Provider.of<custom.AuthProvider>(context, listen: false).signInUser(
        _emailController.value.text,
        _passwordController.value.text,
      );
    } on AuthException catch (e) {
      // set up the button
      Widget okButton = TextButton(
        child: const Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      AlertDialog alert = AlertDialog(
        title: const Text(
          "Error",
        ),
        content: Text(
          e.message,
        ),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (_) => alert,
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyGlobal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormFieldWidget(
            label: "E-Mail",
            icon: const Icon(Icons.email_outlined),
            variable: authData["email"],
            controller: _emailController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Email required";
              }
              if (!EmailValidator.validate(value)) {
                return "Enter a valid email value";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          FormFieldWidget(
            label: "Password",
            icon: const Icon(Icons.lock_outline_rounded),
            variable: authData["password"],
            controller: _passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Password required";
              }
              if (value.length < 8) {
                return "Password too short";
              }
              if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                  .hasMatch(value)) {
                return "Password is too weak";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          FilledButton(
            onPressed: _loading ? () {} : _login,
            child: _loading
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  )
                : const Text("Login"),
          ),
          OutlinedButton(
            onPressed: widget.changeStateFunction,
            child: const Text(
              "Register",
            ),
          ),
          // Directionality(
          //   textDirection: TextDirection.rtl,
          //   child: OutlinedButton.icon(
          //     onPressed: () {},
          //     label: const Text("Skip login"),
          //     icon: const Icon(
          //       Icons.arrow_back,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
