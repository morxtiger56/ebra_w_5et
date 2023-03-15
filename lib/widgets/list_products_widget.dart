import 'package:ebra_w_5et/models/products_modal.dart';
import 'package:ebra_w_5et/ui/product_card_widget.dart';
import 'package:flutter/material.dart';

import '../helpers/api_service.dart';

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

  Future<void> getProducts() async {
    var data = await WooCommerceApi.getProducts();
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(children: [
        ElevatedButton(
          onPressed: getProducts,
          child: const Text('get products'),
        ),
        SizedBox(
          height: 400,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemBuilder: (context, index) => ProductCardWidget(
              product: widget.products[index],
            ),
            itemCount: widget.products.length,
          ),
        ),
      ]),
    );
  }
}
