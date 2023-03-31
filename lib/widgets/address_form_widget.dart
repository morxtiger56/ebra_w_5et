import 'package:flutter/material.dart';

import '../ui/form_filed_widget.dart';

class AddressFormWidget extends StatefulWidget {
  const AddressFormWidget({
    super.key,
  });

  @override
  State<AddressFormWidget> createState() => _AddressFormWidgetState();
}

class _AddressFormWidgetState extends State<AddressFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormFieldWidget(label: "City"),
          const SizedBox(
            height: 5,
          ),
          FormFieldWidget(label: "Area"),
          const SizedBox(
            height: 5,
          ),
          FormFieldWidget(label: "Building number"),
          const SizedBox(
            height: 5,
          ),
          FormFieldWidget(label: "Apt. number"),
          const SizedBox(
            height: 5,
          ),
          FormFieldWidget(label: "Address details"),
        ],
      ),
    );
  }
}
