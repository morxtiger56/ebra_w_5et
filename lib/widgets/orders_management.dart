import 'package:WomenIncome/screens/add_product_screen.dart';
import 'package:flutter/material.dart';

import '../Screens/my_addresses.dart';
import '../screens/my_orders_screen.dart';
import './card.dart';

class OrdersManagement extends StatelessWidget {
  const OrdersManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('ORDERS MANAGEMENT'),
        SizedBox(
          height: 10,
        ),
        MyCard(
          'My orders',
          route: MyOrdersScreen.routeName,
        ),
        SizedBox(
          height: 10,
        ),
        MyCard(
          'My addresses',
          route: MyAddresses.routeName,
        ),
        SizedBox(
          height: 10,
        ),
        MyCard(
          'Add product',
          route: AddProduct.routeName,
        ),
        SizedBox(
          height: 10,
        ),
        // AddressCard('Default Address'),
        Divider(
          indent: 35,
          endIndent: 35,
          height: 50,
        ),
      ],
    );
  }
}
