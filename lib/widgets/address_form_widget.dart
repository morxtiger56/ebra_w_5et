import 'package:flutter/material.dart';

import '../ui/form_filed_widget.dart';

class AddressFormWidget extends StatelessWidget {
  const AddressFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          FormFieldWidget(label: "Country"),
          const SizedBox(
            height: 5,
          ),
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
