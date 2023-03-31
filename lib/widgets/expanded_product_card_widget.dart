import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/products_modal.dart';
import '../ui/modify_product_in_cart_widget.dart';

class ExpandedProductCardWidget extends StatelessWidget {
  String capitalize(String value) {
    var result = value[0].toUpperCase();
    bool cap = true;
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " " && cap == true) {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
        cap = false;
      }
    }
    return result;
  }

  final Product product;
  final bool inCart;
  const ExpandedProductCardWidget({
    Key? key,
    required this.product,
    required this.inCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          SizedBox(
            height: 150,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: product.images == null
                  ? const Placeholder()
                  : Image.network(
                      product.images!.first,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  capitalize(product.name),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "${NumberFormat("###.0#", "en_US").format(product.price - 0.01)}\$",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("${product.description.substring(0, 100)}..."),
                const SizedBox(
                  height: 10,
                ),
                inCart
                    ? const ModifyProductInCartWidget()
                    : FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                        ),
                        label: const Text(
                          "Add To Cart",
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
