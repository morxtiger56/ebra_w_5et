import 'package:flutter/material.dart';

class AddressCardWidget extends StatelessWidget {
  const AddressCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 3,
        surfaceTintColor: Colors.transparent,
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Default address",
                  ),
                  Radio(
                    value: "default",
                    groupValue: const [
                      "default",
                    ],
                    onChanged: (value) {},
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Text("Address"),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: const [
                  Icon(Icons.location_on_outlined),
                  Text("Egypt"),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
