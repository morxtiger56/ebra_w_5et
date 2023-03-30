import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:ebra_w_5et/providers/auth_provider.dart' as custom;
import 'package:ebra_w_5et/ui/form_filed_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmCodeFormWidget extends StatefulWidget {
  const ConfirmCodeFormWidget({super.key});

  @override
  State<ConfirmCodeFormWidget> createState() => _ConfirmCodeFormWidgetState();
}

class _ConfirmCodeFormWidgetState extends State<ConfirmCodeFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _confirmationCodeController =
      TextEditingController();
  var _loading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_formKey.currentState != null) {
      _formKey.currentState!.dispose();
    }
  }

  Future<void> _confirmCode() async {
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _loading = true;
    });
    try {
      await Provider.of<custom.AuthProvider>(context, listen: false).confirmUser(
        _confirmationCodeController.value.text,
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
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormFieldWidget(
            label: "Confirmation code",
            icon: null,
            controller: _confirmationCodeController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter code";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          FilledButton(
            onPressed: _loading? ()  {}: _confirmCode,

            child: _loading
                ? const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
              ),
            )
                : const Text("Proceed"),
          ),
        ],
      ),
    );
  }
}
