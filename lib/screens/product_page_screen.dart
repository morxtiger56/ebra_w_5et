import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ebra_w_5et/models/products_modal.dart';
import 'package:flutter/material.dart';

import '../ui/choose_color_size_widget.dart';
import '../ui/favorite_button_widget.dart';

class ProductPageScreen extends StatelessWidget {
  Product product;
  ProductPageScreen({super.key, required this.product});

  static String routeName = '/product-screen';
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
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Product>;
    final Product product = args['product']!;
    safePrint(product.colors);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: const BackButton(
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FavoriteButtonWidget(
              product: product,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: product.id,
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.fill  ,
                    image: NetworkImage(product.images!.first),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    capitalize(product.name),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Available",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    product.description,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ChooseColorSizeWidget(product: product, isColor: true),
                  const SizedBox(
                    height: 20,
                  ),
                  ChooseColorSizeWidget(product: product, isColor: false),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ProductBottomNavBar(product: product),
    );
  }
}

class ProductBottomNavBar extends StatelessWidget {
  const ProductBottomNavBar({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Text(
            "Price: ${(product.price - 0.01).toString()}\$",
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Add To Cart".toUpperCase()),
            ),
          ),
        ],
      ),
    );
  }
}
