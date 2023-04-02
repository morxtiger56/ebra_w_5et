import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String myText;
  final String route;
  const MyCard(this.myText, {super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => Navigator.of(context).pushNamed(route),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(myText),
              const Icon(Icons.navigate_next),
            ],
          ),
        ),
      ),
    );
  }
}
