import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import '../providers/auth_provider.dart' as custom;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui/form_filed_widget.dart';

class CompleteProfileFormWidget extends StatefulWidget {
  const CompleteProfileFormWidget({
    super.key,
  });

  @override
  State<CompleteProfileFormWidget> createState() =>
      _CompleteProfileFormWidgetState();
}

class _CompleteProfileFormWidgetState extends State<CompleteProfileFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  var _loading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_formKey.currentState != null) {
      _formKey.currentState!.dispose();
    }
    _nameController.dispose();
    _dateController.dispose();
    _countryController.dispose();
    _phoneNumberController.dispose();
  }

  Future<void> _updateAttributes() async {
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _loading = true;
    });
    try {
      print(_nameController.value.text);
      await Provider.of<custom.AuthProvider>(context, listen: false)
          .updateMultipleUserAttributes(
        name: _nameController.value.text,
        dateOfBirth: _dateController.value.text,
        phoneNumber: _phoneNumberController.value.text,
        country: _countryController.value.text,
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
      _loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormFieldWidget(
            label: "Full name",
            icon: const Icon(Icons.person_2_outlined),
            controller: _nameController,
          ),
          const SizedBox(
            height: 10,
          ),
          FormFieldWidget(
            label: "Date of birth",
            icon: const Icon(Icons.email_outlined),
            controller: _dateController,
          ),
          const SizedBox(
            height: 10,
          ),
          FormFieldWidget(
            label: "Country",
            icon: const Icon(Icons.location_city_outlined),
            controller: _countryController,
          ),
          const SizedBox(
            height: 10,
          ),
          FormFieldWidget(
            label: "Phone number",
            icon: const Icon(Icons.phone_callback_outlined),
            controller: _phoneNumberController,
          ),
          const SizedBox(
            height: 10,
          ),
          FilledButton(
            onPressed: _loading ? () {} : _updateAttributes,
            child: const Text("Proceed"),
          ),
        ],
      ),
    );
  }
}
