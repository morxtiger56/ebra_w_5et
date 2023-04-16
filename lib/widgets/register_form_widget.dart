import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import '../providers/auth_provider.dart' as custom;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui/form_filed_widget.dart';

class RegisterFormWidget extends StatefulWidget {
  final VoidCallback changeStateFunction;

  const RegisterFormWidget({
    super.key,
    required this.changeStateFunction,
  });

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final GlobalKey<FormState> _formKeyGlobal = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var _loading = false;

  Future<void> _register() async {
    _formKeyGlobal.currentState!.save();
    if (!_formKeyGlobal.currentState!.validate()) {
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      await Provider.of<custom.AuthProvider>(context, listen: false).signUpUser(
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_formKeyGlobal.currentState != null) {
      _formKeyGlobal.currentState!.dispose();
    }
    _emailController.dispose();
    _passwordController.dispose();
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
          FormFieldWidget(
            label: "Confirm Password",
            icon: const Icon(Icons.lock_outline_rounded),
            validator: (value) {
              if (value != _passwordController.value.text) {
                return "Passwords do not match";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          FilledButton(
            onPressed: _loading ? () {} : _register,
            child: _loading
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  )
                : const Text("Register"),
          ),
          OutlinedButton(
            onPressed: widget.changeStateFunction,
            child: const Text(
              "Skip",
            ),
          ),
        ],
      ),
    );
  }
}
