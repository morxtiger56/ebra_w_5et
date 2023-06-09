import 'package:WomenIncome/screens/add_product_screen.dart';

import './providers/cart_provider.dart';
import './screens/checkout_screen.dart';
import './screens/edit_addresses.dart';
import './screens/my_addresses.dart';
import './screens/my_orders_screen.dart';

import 'providers/auth_provider.dart';
import 'providers/product_provider.dart';
import 'screens/home.dart';
import 'color_schemes.g.dart';
import 'models/products_modal.dart';
import 'screens/home_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/product_page_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        )
      ],
      child: MaterialApp(
        theme: lightThemeData,
        darkTheme: darkThemeData,
        routes: {
          HomePageScreen.routeName: (context) => const HomePageScreen(),
          ProductPageScreen.routeName: (context) => ProductPageScreen(
                product: Product(
                  id: '',
                  name: '',
                  price: 0,
                  description: '',
                  originalPrice: 0,
                ),
              ),
          MyAddresses.routeName: (_) => const MyAddresses(),
          EditAddresses.routeName: (_) => const EditAddresses(),
          CheckoutScreen.routeName: (_) => const CheckoutScreen(),
          MyOrdersScreen.routeName: (_) => const MyOrdersScreen(),
          AddProduct.routeName: (_) => AddProduct(),
        },
        debugShowCheckedModeBanner: false,
        home: const Home(),
      ),
    );
  }
}
