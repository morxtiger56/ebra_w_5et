import 'package:flutter/material.dart';

class ModifyProductInCartWidget extends StatelessWidget {
  const ModifyProductInCartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              style: IconButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.tertiary,
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.add,
              ),
            ),
            const Text("1"),
            IconButton(
              style: IconButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.tertiary,
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.remove,
              ),
            ),
          ],
        ),
        IconButton(
          style: IconButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          onPressed: () {},
          icon: const Icon(
            Icons.delete_outlined,
          ),
        ),
      ],
    );
  }
}
