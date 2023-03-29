import 'package:flutter/material.dart';

import 'package:ebra_w_5et/models/products_modal.dart';

import '../widgets/expanded_product_card_widget.dart';

class FavoritesScreen extends StatelessWidget {
  //TODO: Get all favorites

  List<Product> products = [
    Product(
      id: "1",
      name: "test",
      price: 10,
      description: "lorem",
      originalPrice: 0.1,
    )
  ];
  FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        //TODO: Change height to be dynamic
        height: 500,
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: ListView.builder(
          itemBuilder: (_, index) => ExpandedProductCardWidget(
            product: products[index],
            inCart: false,
          ),
          itemCount: products.length,
        ),
      ),
    );
  }
}
