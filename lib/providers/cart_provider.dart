import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ebra_w_5et/models/cart_modal.dart';
import 'package:flutter/foundation.dart';

import '../models/products_modal.dart';

class CartProvider with ChangeNotifier {
  CartModal? cart;
  CartProvider();

  Future<void> getCart() async {}

  Future<void> addToCart(
    Product product,
    Map<String, String> options,
    int quantity,
  ) async {
    try {
      var cartId = "";
      if (cart != null) {
        cart!.addToCart(product, options, quantity);
        cartId = cart!.id;
        return;
      }
      notifyListeners();
      var user = await Amplify.Auth.getCurrentUser();
      var params = RestOptions(
        path: "/cart",
        apiName: "userApi",
        body: Uint8List.fromList(
          CartItem(product: product, options: options, quantity: quantity)
              .toJson()
              .codeUnits,
        ),
        queryParameters: {
          "id": user.userId,
          "cartId": cartId,
        },
      );
      var res = await Amplify.API.post(restOptions: params).response;
      print(res.body);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
