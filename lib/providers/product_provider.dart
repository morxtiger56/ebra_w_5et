import 'dart:convert';
import 'dart:typed_data';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ebra_w_5et/helpers/api_service.dart';
import 'package:flutter/material.dart';

import '../models/products_modal.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _favorites = [];

  List<Product> get favorites => _favorites;

  set favorites(List<Product> value) {
    _favorites = value;
  }

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
    for (var element in (jsonDecode(response.body) as List<dynamic>)) {
      Product product = Product.fromJson(element);
      products.add(product);
    }

    checkFavorites();

    notifyListeners();
  }

  void checkFavorites() {
    for (var product in favorites) {
      var index = products.indexWhere((element) => product.id == element.id);
      products[index].likeProduct();
    }
  }

  Product getProduct(String id) {
    return products.firstWhere((element) => element.id == id);
  }

  Future<void> getUserFavorites() async {
    if (favorites.isNotEmpty) {
      return;
    }
    var user = await Amplify.Auth.getCurrentUser();
    var response = await Amplify.API
        .get(
          restOptions: RestOptions(
            path: "/favorites",
            queryParameters: {
              "id": user.userId,
            },
            apiName: "userApi",
          ),
        )
        .response;
    for (var element in (jsonDecode(response.body) as List<dynamic>)) {
      favorites.add(Product.fromJson(element));
    }
  }

  Future<String> toggleFavorite(String id) async {
    var product = products.firstWhere((element) => element.id == id);
    final isFavorite = product.likeProduct();
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
      if (isFavorite) {
        var response = await Amplify.API.put(restOptions: params).response;
        favorites.add(product);
        return "Product added to favorites";
      } else {
        var response = await Amplify.API.delete(restOptions: params).response;
        favorites.removeWhere((element) => element.id == product.id);
        return "Product removed from favorites";
      }
    } catch (e) {
      print(e);
      product.likeProduct();
      notifyListeners();
      if (isFavorite) {
        return "Failed to add product to favorites";
      } else {
        return "Failed to remove product to favorites";
      }
    }
  }
}
