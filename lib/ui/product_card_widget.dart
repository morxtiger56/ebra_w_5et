import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ebra_w_5et/models/products_modal.dart';
import 'package:ebra_w_5et/screens/product_page_screen.dart';

import 'favorite_button_widget.dart';

class ProductCardWidget extends StatefulWidget {
  final Product product;
  final double height;
  const ProductCardWidget(
      {super.key, required this.product, required this.height});

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductPageScreen.routeName,
          arguments: {"product": widget.product},
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Hero(
                tag: widget.product.id,
                child: Container(
                  padding: const EdgeInsets.all(50),
                  height: widget.height - 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  child: const Center(
                    child: Text('Image'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: FavoriteButtonWidget(
                  product: widget.product,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              capitalize(widget.product.name),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "${NumberFormat("###.0#", "en_US").format(widget.product.price - 0.01)}\$",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
