import 'package:ebra_w_5et/providers/product_provider.dart';
import 'package:flutter/material.dart';

import 'package:ebra_w_5et/models/products_modal.dart';
import 'package:provider/provider.dart';

import '../widgets/expanded_product_card_widget.dart';

class FavoritesScreen extends StatelessWidget {
  //TODO: Get all favorites

  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        //TODO: Change height to be dynamic
        height: MediaQuery.of(context).size.height - 100,
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Consumer<ProductProvider>(builder: (context, value, child) {
          List<Product> favorites = value.favorites;
          return ListView.builder(
            itemBuilder: (_, index) => ExpandedProductCardWidget(
              product: favorites[index],
              inCart: false,
            ),
            itemCount: favorites.length,
          );
        }),
      ),
    );
  }
}
