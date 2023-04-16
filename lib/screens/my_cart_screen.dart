import '../providers/cart_provider.dart';
import '../screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/expanded_product_card_widget.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CartProvider>(context, listen: false).getTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 380,
                child: Consumer<CartProvider>(builder: (_, value, child) {
                  if (value.cart == null) {
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
                      inCart: true,
                    ),
                    itemCount: value.cart!.items.length,
                  );
                }),
              ),
            ),
          ),
          Consumer<CartProvider>(builder: (_, value, child) {
            if (value.cart == null) {
              return const Text("");
            }
            return Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
                color: Theme.of(context).colorScheme.background,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20.0,
                    spreadRadius: 1.0,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BillingSectionWidget(
                      title: "Sub Total",
                      amount: "${value.totalBreakDown["subTotal"]!}\$",
                    ),
                    BillingSectionWidget(
                      title: "Tax",
                      amount: "${value.totalBreakDown["tax"]!}\$",
                    ),
                    const Divider(),
                    BillingSectionWidget(
                      title: "Total",
                      amount: "${value.totalBreakDown["total"]!}\$",
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(CheckoutScreen.routeName);
                      },
                      child: const Text(
                        "Checkout",
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class BillingSectionWidget extends StatelessWidget {
  final String title;
  final String amount;
  const BillingSectionWidget({
    super.key,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(amount),
      ],
    );
  }
}
