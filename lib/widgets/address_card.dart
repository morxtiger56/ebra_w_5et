import 'package:ebra_w_5et/screens/edit_addresses.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final String myText;

  const AddressCard(this.myText, {super.key});

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
                Text(myText),
                IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(EditAddresses.routeName),
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
                    child: const Text('Egypt'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 220,
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
