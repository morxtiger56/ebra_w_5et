import 'dart:convert';

import 'package:ebra_w_5et/helpers/api_service.dart';
import 'package:flutter/material.dart';

import '../models/products_modal.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  set products(List<Product> value) {
    _products = value;
  }

  ProductProvider();

  Future<void> getProducts() async {
    products = [];
    var response = await WooCommerceApi.getProducts();
    print(response.toString());
    for (var element in (jsonDecode(response.body) as List<dynamic>)) {
      products.add(Product.fromJson(element));
    }
    notifyListeners();
  }

  Product getProduct(String id) {
    return products.firstWhere((element) => element.id == id);
  }

  void toggleFavorite(String id) {
    var product = products.firstWhere((element) => element.id == id);
    product.likeProduct();
    notifyListeners();
  }
}
