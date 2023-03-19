import 'package:flutter/material.dart';

import '../models/products_modal.dart';

class ChooseColorSizeWidget extends StatefulWidget {
  const ChooseColorSizeWidget({
    super.key,
    required this.product,
    required this.isColor,
  });

  final Product product;
  final bool isColor;

  @override
  State<ChooseColorSizeWidget> createState() => _ChooseColorSizeWidgetState();
}

class _ChooseColorSizeWidgetState extends State<ChooseColorSizeWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.isColor) {
      return Column(
        children: [
          const Text(
            "Color",
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: widget.product.colors!
                .map(
                  (e) => Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: e,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      );
    } else {
      return Row(
        children: widget.product.sizes!
            .map(
              (e) => Column(
                children: [
                  const Text(
                    "Sizes",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(
                          child: Text(e),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ],
              ),
            )
            .toList(),
      );
    }
  }
}
