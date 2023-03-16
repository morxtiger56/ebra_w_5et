import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ebra_w_5et/models/products_modal.dart';

class WooCommerceApi {
  static Future<List<Product>> getProducts() async {
    try {
      // Get data using the "products" endpoint
      var products = '';
      var response = Amplify.API.get(
        restOptions: const RestOptions(
          path: '/products',
          apiName: 'userApi',
          queryParameters: {
            "get": "getProducts",
          },
        ),
      );
      print('passed');
      print(await response.response);
      return (products as List<Product>);
    } catch (e) {
      print(e);
      throw 'No Internet Connection';
    }
  }
}
