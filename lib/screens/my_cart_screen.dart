import 'package:flutter/material.dart';

import '../models/products_modal.dart';
import '../widgets/expanded_product_card_widget.dart';

class MyCartScreen extends StatelessWidget {
  List<Product> products = [
    Product(
      id: "1",
      name: "test",
      price: 10,
      description: "lorem",
      originalPrice: 0.1,
    )
  ];
  MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            //TODO: Change height to be dynamic
            height: 600,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: ListView.builder(
              itemBuilder: (_, index) => ExpandedProductCardWidget(
                product: products[index],
                inCart: true,
              ),
              itemCount: products.length,
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
              color: Theme.of(context).colorScheme.background,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20.0,
                  spreadRadius: 1.0,
                )
              ],
            ),
            //TODO: Add Consomer on the widget
            //TODO: Get the values from the provider
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const BillingSectionWidget(
                    title: "Sub Total",
                    amount: "100.00\$",
                  ),
                  const BillingSectionWidget(
                    title: "Tax",
                    amount: "14.00\$",
                  ),
                  const Divider(),
                  const BillingSectionWidget(
                    title: "Total",
                    amount: "114.00\$",
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: const Text(
                      "Checkout",
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BillingSectionWidget extends StatelessWidget {
  final String title;
  final String amount;
  const BillingSectionWidget({
    super.key,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(amount),
      ],
    );
  }
}
