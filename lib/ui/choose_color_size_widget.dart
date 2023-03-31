import 'package:flutter/material.dart';

import '../models/products_modal.dart';

class ChooseColorSizeWidget extends StatelessWidget {
  const ChooseColorSizeWidget({
    super.key,
    required this.product,
    required this.isColor,
    required this.changeValue,
    required this.activeValue,
  });

  final Function changeValue;
  final Product product;
  final bool isColor;
  final dynamic activeValue;

  @override
  Widget build(BuildContext context) {
    if (isColor) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Color",
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: product.colors!
                .map(
                  (e) => Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => changeValue(e),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: e == activeValue
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.black,
                              width: 2,
                            ),
                            color: e,
                          ),
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Sizes",
          ),
          Row(
            children: product.sizes!
                .map(
                  (e) => Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => changeValue(e),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: e == activeValue
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(e),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      );
    }
  }
}
