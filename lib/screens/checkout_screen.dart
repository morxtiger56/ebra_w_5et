import 'package:ebra_w_5et/screens/my_cart_screen.dart';
import 'package:flutter/material.dart';

import '../ui/address_card_widget.dart';
import '../widgets/address_form_widget.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

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
                  child: Column(
                    children: const [
                      BillingSectionWidget(
                        title: "Sub Total",
                        amount: "100.00\$",
                      ),
                      BillingSectionWidget(
                        title: "Tax",
                        amount: "14.00\$",
                      ),
                      BillingSectionWidget(
                        title: "Cash on delivery",
                        amount: "5.00\$",
                      ),
                      Divider(),
                      BillingSectionWidget(
                        title: "Total",
                        amount: "119.00\$",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
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
              const Text("Choose shipping address :"),
              const SizedBox(
                height: 10,
              ),
              const AddressCardWidget(),
              const SizedBox(
                height: 10,
              ),
              const Text("Add new address:"),
              const SizedBox(
                height: 10,
              ),
              const AddressFormWidget(),
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
