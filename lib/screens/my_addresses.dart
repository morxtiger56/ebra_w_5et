import 'package:flutter/material.dart';

import '../widgets/address_card.dart';

class MyAddresses extends StatelessWidget {
  static const routeName = "/my-addresses-management";

  const MyAddresses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Addresses'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('SAVED ADDRESSES'),
              SizedBox(
                height: 10,
              ),
              AddressCard('Default Address'),
              SizedBox(
                height: 10,
              ),
              AddressCard('Address 1'),
            ],
          ),
        ),
      ),
    );
  }
}