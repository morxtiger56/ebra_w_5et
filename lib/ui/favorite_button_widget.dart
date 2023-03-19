import 'package:flutter/material.dart';

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
          widget.product.likeProduct();
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
