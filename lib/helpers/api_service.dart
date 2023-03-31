import 'package:amplify_flutter/amplify_flutter.dart';

class WooCommerceApi {
  static Future<RestResponse> getProducts() async {
    try {
      // Get data using the "products" endpoint
      const options = RestOptions(
        path: '/products',
        apiName: 'userApi',
        queryParameters: {
          "get": "getProducts",
        },
      );
      final restResponse = Amplify.API.get(restOptions: options);

      return restResponse.response;
    } catch (e) {
      throw 'No Internet Connection';
    }
  }

  static Future<RestResponse> addToFavorites(
      String id, String productId) async {
    try {
      // Get data using the "products" endpoint
      var options = RestOptions(
        path: '/favorites',
        apiName: 'userApi',
        queryParameters: {
          "id": id,
          "productId": productId,
        },
      );
      final restResponse = Amplify.API.post(restOptions: options);

      return restResponse.response;
    } catch (e) {
      throw 'No Internet Connection';
    }
  }

  static Future<RestResponse> removeFromFavorites(
      String id, String productId) async {
    try {
      // Get data using the "products" endpoint
      var options = RestOptions(
        path: '/favorites',
        apiName: 'userApi',
        queryParameters: {
          "id": id,
          "productId": productId,
        },
      );
      final restResponse = Amplify.API.delete(restOptions: options);

      return restResponse.response;
    } catch (e) {
      throw 'No Internet Connection';
    }
  }
}
