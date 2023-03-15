import 'package:ebra_w_5et/models/products_modal.dart';

class WooCommerceApi {
  static Future<List<Product>> getProducts() async {
    try {
      // Get data using the "products" endpoint
      var products = '';
      return (products as List<Product>);
    } catch (e) {
      print(e);
      throw 'No Internet Connection';
    }
  }
}
