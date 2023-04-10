import 'package:ebra_w_5et/models/address_modal.dart';
import 'package:ebra_w_5et/providers/auth_provider.dart';
import 'package:ebra_w_5et/providers/cart_provider.dart';
import 'package:ebra_w_5et/screens/edit_addresses.dart';
import 'package:ebra_w_5et/screens/my_cart_screen.dart';
import 'package:ebra_w_5et/widgets/address_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  static const routeName = "/checkout-screen";

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String id = "";
  Future<void> _checkout() async {
    AddressModal address =
        Provider.of<AuthProvider>(context, listen: false).getAddress(id);
    try {
      await Provider.of<CartProvider>(context, listen: false)
          .checkout(address)
          .then(
            (value) => Navigator.of(context).pop(),
          );
    } catch (e) {
      print(e);
    }
  }

  void _chooseAddress(String id) {
    this.id = id;
    Provider.of<CartProvider>(context, listen: false).changeSelectedAddress(id);
  }

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
              Consumer<AuthProvider>(
                builder: (context, value, child) => Column(
                  children: value.user.addresses
                      .map(
                        (e) => Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _chooseAddress(e.id);
                              },
                              icon: Consumer<CartProvider>(
                                builder: (_, value, child) => Icon(
                                  value.selectedAddress == e.id
                                      ? Icons.radio_button_checked_outlined
                                      : Icons.radio_button_off_outlined,
                                ),
                              ),
                            ),
                            AddressCard(
                              e.isDefault ? "Default Address" : "Address",
                              action: () => Navigator.of(context).pushNamed(
                                EditAddresses.routeName,
                                arguments: {"id": e.id},
                              ),
                              address: e,
                            )
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FilledButton(
                onPressed: _checkout,
                child: const Text("Proceed Checkout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
