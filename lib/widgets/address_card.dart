import '../models/address_modal.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final String myTitle;
  final AddressModal address;
  final void Function() action;
  const AddressCard(this.myTitle,
      {super.key, required this.address, required this.action});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 10,
          bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(myTitle),
                IconButton(
                  onPressed: action,
                  icon: const Icon(Icons.edit),
                )
              ],
            ),
            const Text('Shipping Address'),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: Text(address.country),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 220,
              child: Text(
                '${address.apartmentNumber}, ${address.buildingNumber} ${address.area}, ${address.city}, ${address.addressDetails} ',
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
