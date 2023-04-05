import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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
              const Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Country',
                    hintText: '********',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'City',
                    hintText: 'Alexandria',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Area',
                    hintText: 'Smoha',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Building Number',
                    hintText: '12',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Apt. Number',
                    hintText: '12',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address Details',
                    hintText:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et ',
                  ),
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
