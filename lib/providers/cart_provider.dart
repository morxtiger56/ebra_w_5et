import 'package:ebra_w_5et/models/cart_modal.dart';
import 'package:flutter/material.dart';

import '../models/products_modal.dart';

class CartProvider with ChangeNotifier {
  CartModal cart;
  CartProvider({
    required this.cart,
  });

  Future<void> addToCart(
    Product product,
    Map<String, String> options,
    int quantity,
  ) async {
    cart.addToCart(product, options, quantity);
    notifyListeners();
  }
}
