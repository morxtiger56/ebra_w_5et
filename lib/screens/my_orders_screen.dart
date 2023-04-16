import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widgets/expanded_product_card_widget.dart';

class MyOrdersScreen extends StatelessWidget {
  static const routeName = "/my-orders";

  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("My Orders"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 380,
              child: Consumer<CartProvider>(builder: (_, value, child) {
                if (value.orders.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(600),
                          child: SizedBox(
                            child: Image.asset("assets/45461.jpg"),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Add items first",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemBuilder: (_, index) => ExpandedProductCardWidget(
                    product: value.cart!.items[index].product,
                    inCart: false,
                  ),
                  itemCount: value.cart!.items.length,
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
