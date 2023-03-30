import 'package:ebra_w_5et/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products_modal.dart';

class FavoriteButtonWidget extends StatefulWidget {
  Product product;
  FavoriteButtonWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          Provider.of<ProductProvider>(context, listen: false).toggleFavorite(
            widget.product.id,
          ).then((value)  {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text("Product added to favorites"))
            );
          }).catchError((e)  {
            print(e);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text("Failed to product add to favorites"),)
            );
          });
        });
      },
      icon: Icon(
        widget.product.isFavorite
            ? Icons.favorite_rounded
            : Icons.favorite_border_outlined,
      ),
      style: IconButton.styleFrom(
        foregroundColor: widget.product.isFavorite ? Colors.red : Colors.black,
        backgroundColor: Colors.white,
      ),
    );
  }
}
