import 'package:ebra_w_5et/models/address_modal.dart';
import 'package:ebra_w_5et/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui/form_filed_widget.dart';

class EditAddresses extends StatefulWidget {
  const EditAddresses({super.key});

  static const routeName = "/edit-addresses";

  @override
  State<EditAddresses> createState() => _EditAddressesState();
}

class _EditAddressesState extends State<EditAddresses> {
  var makeDefault = false;
  _changeMakeDefault(value) {
    setState(() {
      makeDefault = !makeDefault;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _buildingNumberController =
      TextEditingController();
  final TextEditingController _apartmentNumberController =
      TextEditingController();
  final TextEditingController _addressDetailsController =
      TextEditingController();

  AddressModal address = AddressModal(
    id: "",
    city: "",
    area: "",
    buildingNumber: "",
    apartmentNumber: "",
    addressDetails: "",
    isDefault: false,
  );

  String action = "add";

  final _loading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_formKey.currentState != null) {
      _formKey.currentState!.dispose();
    }
    _countryController.dispose();
    _cityController.dispose();
    _areaController.dispose();
    _buildingNumberController.dispose();
    _apartmentNumberController.dispose();
    _addressDetailsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    if (args != null && args["id"] != null) {
      address = Provider.of<AuthProvider>(context).getAddress(args["id"]!);
      action = "edit";
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Addresses'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('ADDRESS INFO'),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: FormFieldWidget(
                  label: "Country",
                  controller: _countryController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Filed is required";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: FormFieldWidget(
                  label: "City",
                  controller: _cityController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Filed is required";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: FormFieldWidget(
                  label: "Area",
                  controller: _areaController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Filed is required";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: FormFieldWidget(
                  label: "Building Number",
                  controller: _buildingNumberController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Filed is required";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: FormFieldWidget(
                  label: "Apt. Number",
                  controller: _apartmentNumberController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Filed is required";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: FormFieldWidget(
                  label: "Address Details",
                  controller: _addressDetailsController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Filed is required";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(children: [
                Switch.adaptive(
                  value: makeDefault,
                  onChanged: _changeMakeDefault,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("Make a default address "),
              ]),
              const SizedBox(
                height: 10,
              ),
              FilledButton(
                onPressed: () {},
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
