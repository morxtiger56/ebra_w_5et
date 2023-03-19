import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ebra_w_5et/models/products_modal.dart';

class WooCommerceApi {
  static Future<List<Product>> getProducts() async {
    try {
      safePrint("Calling Api");
      // Get data using the "products" endpoint
      var products = <Product>[];
      const options = RestOptions(
        path: '/products',
        apiName: 'userApi',
        queryParameters: {
          "get": "getProducts",
        },
      );
      final restResponse = Amplify.API.get(restOptions: options);
      safePrint("Rest Response $restResponse");

      final response = await restResponse.response;

      for (var element in (jsonDecode(response.body) as List<dynamic>)) {
        products.add(Product.fromJson(element));
      }
      return products;
    } catch (e) {
      safePrint(e);
      throw 'No Internet Connection';
    }
  }
}
