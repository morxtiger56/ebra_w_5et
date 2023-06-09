import '../providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/address_card.dart';
import 'edit_addresses.dart';

class MyAddresses extends StatelessWidget {
  static const routeName = "/my-addresses-management";

  const MyAddresses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Addresses'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditAddresses.routeName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 20,
          ),
          child: UserAddressesWidget(),
        ),
      ),
    );
  }
}

class UserAddressesWidget extends StatelessWidget {
  const UserAddressesWidget({
    super.key,
  });

  final isChoose = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, value, c) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          c!,
          value.user.addresses.isEmpty
              ? Center(
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pushNamed(
                      EditAddresses.routeName,
                    ),
                    child: const Text("Add new address"),
                  ),
                )
              : Column(
                  children: value.user.addresses
                      .map(
                        (e) => AddressCard(
                          e.isDefault ? "Default Address" : "Address",
                          action: () => Navigator.of(context).pushNamed(
                            EditAddresses.routeName,
                            arguments: {"id": e.id},
                          ),
                          address: e,
                        ),
                      )
                      .toList(),
                )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('SAVED ADDRESSES'),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
