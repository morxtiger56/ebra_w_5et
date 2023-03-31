import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ebra_w_5et/models/cart_modal.dart';
import 'package:flutter/material.dart';

import '../models/products_modal.dart';

class CartProvider with ChangeNotifier {
  CartModal cart = CartModal(id: "", items: []);
  CartProvider();

  Future<void> getCart() async {}

  Future<void> addToCart(
    Product product,
    Map<String, String> options,
    int quantity,
  ) async {
    try {
      cart.addToCart(product, options, quantity);
      Amplify.API.post(restOptions: const RestOptions(path: "/cart"));
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
