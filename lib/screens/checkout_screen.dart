import 'package:ebra_w_5et/providers/cart_provider.dart';
import 'package:ebra_w_5et/screens/my_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/address_form_widget.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});
  static const routeName = "/checkout-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Checkout"),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                surfaceTintColor: Colors.transparent,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Consumer<CartProvider>(
                    builder: (_, value, c) => Column(
                      children: [
                        BillingSectionWidget(
                          title: "Sub Total",
                          amount: "${value.totalBreakDown["subTotal"]!}\$",
                        ),
                        BillingSectionWidget(
                          title: "Tax",
                          amount: "${value.totalBreakDown["tax"]!}\$",
                        ),
                        const BillingSectionWidget(
                          title: "Cash on delivery",
                          amount: "5.00\$",
                        ),
                        const Divider(),
                        BillingSectionWidget(
                          title: "Total",
                          amount: "${value.totalBreakDown["total"]! + 5}\$",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Choose payment method :"),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                    child: Card(
                      elevation: 3,
                      surfaceTintColor: Colors.transparent,
                      color: Theme.of(context).colorScheme.background,
                      child: const Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Icon(
                          Icons.credit_card_outlined,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    child: Card(
                      elevation: 3,
                      color: Theme.of(context).colorScheme.primary,
                      child: const Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Icon(
                          Icons.paid_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "*Cash on delivery will add 5 EGP to the total",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Add new address:"),
              const SizedBox(
                height: 10,
              ),
              const AddressFormWidget(),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.radio_button_off),
                label: const Text('Make Default Address'),
              ),
              const SizedBox(
                height: 10,
              ),
              FilledButton(
                onPressed: () {},
                child: const Text("Proceed Checkout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
