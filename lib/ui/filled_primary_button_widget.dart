import 'package:flutter/material.dart';

class PrimaryFilledButtonWidget extends StatelessWidget {
  const PrimaryFilledButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: const Text("Login"),
    );
  }
}
