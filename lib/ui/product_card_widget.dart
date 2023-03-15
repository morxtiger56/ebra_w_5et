import 'package:ebra_w_5et/models/products_modal.dart';
import 'package:flutter/material.dart';

class ProductCardWidget extends StatefulWidget {
  final Product product;
  const ProductCardWidget({super.key, required this.product});

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
          child: const Center(
            child: Text('Image'),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(widget.product.name),
        Text(widget.product.price.toString()),
      ],
    );
  }
}
