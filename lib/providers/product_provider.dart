import 'dart:convert';
import 'dart:typed_data';

import 'package:amplify_flutter/amplify_flutter.dart';
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
    if (products.isNotEmpty) {
      return;
    }
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

  Future<void> toggleFavorite(String id) async {
    var product = products.firstWhere((element) => element.id == id);
    product.likeProduct();
    notifyListeners();

    try {
      var user = await Amplify.Auth.getCurrentUser();

      var params = RestOptions(
        path: "/favorites",
        apiName: "userApi",
        queryParameters: {
          "id": user.userId,
          "productId": id,
        },
        body: Uint8List.fromList([]),
      );
      var response = await Amplify.API.put(restOptions: params).response;
      print(response.body);
    } catch (e) {
      print(e);
      product.likeProduct();
      notifyListeners();
    }
  }
}
