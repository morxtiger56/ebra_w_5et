import 'package:ebra_w_5et/providers/product_provider.dart';
import 'package:flutter/material.dart';

import 'package:ebra_w_5et/models/products_modal.dart';
import 'package:provider/provider.dart';

import '../widgets/expanded_product_card_widget.dart';

class FavoritesScreen extends StatefulWidget {
  //TODO: Get all favorites

  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text("Swipe right to delete item"),
          Container(
            //TODO: Change height to be dynamic
            height: MediaQuery.of(context).size.height - 205,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Consumer<ProductProvider>(builder: (context, value, child) {
              List<Product> favorites = value.favorites;
              return ListView.builder(
                itemBuilder: (_, index) => Dismissible(
                  direction: DismissDirection.endToStart,
                  key: UniqueKey(),
                  onDismissed: (_) {
                    Provider.of<ProductProvider>(context, listen: false)
                        .toggleFavorite(favorites[index].id)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            value,
                          ),
                        ),
                      );
                    });
                  },
                  background: Container(
                    color: Theme.of(context).colorScheme.primary,
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  child: ExpandedProductCardWidget(
                    product: favorites[index],
                    inCart: false,
                  ),
                ),
                itemCount: favorites.length,
              );
            }),
          ),
        ],
      ),
    );
  }
}
