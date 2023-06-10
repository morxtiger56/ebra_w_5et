import '../models/address_modal.dart';
import '../providers/auth_provider.dart';
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
  TextEditingController _countryController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController _buildingNumberController = TextEditingController();
  TextEditingController _apartmentNumberController = TextEditingController();
  TextEditingController _addressDetailsController = TextEditingController();

  AddressModal address = AddressModal(
    id: "",
    city: "",
    area: "",
    buildingNumber: "",
    apartmentNumber: "",
    addressDetails: "",
    isDefault: false,
    country: '',
  );

  String operation = "add address";

  var _loading = false;
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

  Future<void> _editAddress() async {
    if (_formKey.currentState == null) {
      return;
    }
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    address.addressDetails = _addressDetailsController.value.text;
    address.city = _cityController.value.text;
    address.area = _areaController.value.text;
    address.apartmentNumber = _apartmentNumberController.value.text;
    address.country = _countryController.value.text;
    address.buildingNumber = _buildingNumberController.value.text;
    address.isDefault = makeDefault;

    print(address.toString());
    setState(() {
      _loading = true;
    });
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .updateAddress(address, operation)
          .then(
        (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                value,
              ),
            ),
          );
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      print(e);
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
        content: const Text(
          "Failed to update the address",
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
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    if (args != null && args["id"] != null) {
      address = Provider.of<AuthProvider>(context, listen: false)
          .getAddress(args["id"]!);
      operation = "modify address";
      setState(() {
        _cityController = TextEditingController(text: address.city);
        _countryController = TextEditingController(text: address.country);
        _areaController = TextEditingController(text: address.area);
        _buildingNumberController =
            TextEditingController(text: address.buildingNumber);
        _apartmentNumberController =
            TextEditingController(text: address.apartmentNumber);
        _addressDetailsController =
            TextEditingController(text: address.addressDetails);
        makeDefault = address.isDefault;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Addresses'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                  onPressed: _loading ? () {} : _editAddress,
                  child: _loading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
