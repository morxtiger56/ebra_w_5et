import 'package:ebra_w_5et/models/products_modal.dart';
import 'package:ebra_w_5et/ui/product_card_widget.dart';
import 'package:flutter/material.dart';

class ListProductsWidget extends StatefulWidget {
  List<Product> products;
  ListProductsWidget({super.key, required this.products});

  @override
  State<ListProductsWidget> createState() => _ListProductsWidgetState();
}

class _ListProductsWidgetState extends State<ListProductsWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  double height = 200;

  getHeight() {
    height = MediaQuery.of(context).size.height - 70 - 200;
    return height;
  }

  @override
  Widget build(BuildContext context) {
    /// Creating a grid layout with 2 columns and a spacing of 10.0 and 20.0.

    var girdShape = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 20.0,
      childAspectRatio: (MediaQuery.of(context).size.width / 4) /
          (MediaQuery.of(context).size.height / 5),
    );

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: SizedBox(
        height: getHeight(),
        child: GridView.builder(
          gridDelegate: girdShape,
          itemBuilder: (context, index) => ProductCardWidget(
            key: GlobalObjectKey(widget.products[index].id),
            product: widget.products[index],
            height: (MediaQuery.of(context).size.width / 5) * 4,
          ),
          itemCount: widget.products.length,
        ),
      ),
    );
  }
}
