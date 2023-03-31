import 'package:ebra_w_5et/models/products_modal.dart';
import 'package:ebra_w_5et/providers/cart_provider.dart';
import 'package:ebra_w_5et/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui/choose_color_size_widget.dart';
import '../ui/favorite_button_widget.dart';

class ProductPageScreen extends StatefulWidget {
  Product product;
  ProductPageScreen({super.key, required this.product});

  static String routeName = '/product-screen';

  @override
  State<ProductPageScreen> createState() => _ProductPageScreenState();
}

class _ProductPageScreenState extends State<ProductPageScreen> {
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

  String currentColor = "";
  String currentSize = "";

  void _changeColor(Color value) {
    setState(() {
      currentColor = value.value.toRadixString(16);
    });
  }

  void _changeSize(String value) {
    print(value);
    setState(() {
      currentSize = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String productId = args['productId']!;
    Product product = Provider.of<ProductProvider>(
      context,
      listen: false,
    ).getProduct(
      productId,
    );

    Future<void> _addToCart() async {
      try {
        Provider.of<CartProvider>(context, listen: false)
            .addToCart(
                product,
                {
                  "color": currentColor.isEmpty
                      ? product.colors![0].value.toRadixString(16)
                      : currentColor,
                  "size": currentSize
                },
                1)
            .then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    value,
                  ),
                ),
              ),
            );
      } catch (e) {
        print(e);
      }
    }

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
                    fit: BoxFit.fill,
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
                  ChooseColorSizeWidget(
                    product: product,
                    isColor: true,
                    changeValue: _changeColor,
                    activeValue: currentColor.isEmpty
                        ? product.colors![0]
                        : Color(int.parse(currentColor, radix: 16)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ChooseColorSizeWidget(
                    product: product,
                    isColor: false,
                    changeValue: _changeSize,
                    activeValue:
                        currentSize.isEmpty ? product.sizes![0] : currentSize,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ProductBottomNavBar(
        product: product,
        addToCart: _addToCart,
      ),
    );
  }
}

class ProductBottomNavBar extends StatelessWidget {
  const ProductBottomNavBar({
    super.key,
    required this.product,
    required this.addToCart,
  });

  final Product product;
  final VoidCallback addToCart;

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
              onPressed: addToCart,
              child: Text("Add To Cart".toUpperCase()),
            ),
          ),
        ],
      ),
    );
  }
}
