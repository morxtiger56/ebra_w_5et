import 'package:flutter/material.dart';

class FormFieldWidget extends StatefulWidget {
  //TODO: Add validator, on field submit

  final String label;
  final Icon? icon;
  final String? Function(String?)? validator;
  var variable;
  TextEditingController? controller;
  FormFieldWidget(
      {Key? key,
      required this.label,
      this.icon,
      this.variable,
      this.controller,
      this.validator})
      : super(key: key);

  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              5,
            ),
          ),
        ),
        prefixIcon: widget.icon,
      ),
      keyboardType: TextInputType.emailAddress,
      onFieldSubmitted: (value) => {
        setState(() {
          widget.variable = value;
        })
      },
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
