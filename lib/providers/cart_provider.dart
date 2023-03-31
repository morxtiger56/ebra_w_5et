import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ebra_w_5et/models/cart_modal.dart';
import 'package:flutter/foundation.dart';

import '../models/products_modal.dart';

class CartProvider with ChangeNotifier {
  CartModal? cart;
  CartProvider();
  Map<String, double> totalBreakDown = {
    "subTotal": 0,
    "tax": 0,
    "total": 0,
  };

  Future<void> getCart() async {
    try {
      var user = await Amplify.Auth.getCurrentUser();
      var response = await Amplify.API
          .get(
              restOptions: RestOptions(
            path: "/cart",
            apiName: "userApi",
            queryParameters: {
              "id": user.userId,
            },
          ))
          .response;

      cart = CartModal.fromMap(jsonDecode(response.body));
      getTotal();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void getTotal() {
    print("before");
    if (cart!.items.isEmpty) {
      return;
    }
    print("after");
    totalBreakDown = {
      "subTotal": 0,
      "tax": 0,
      "total": 0,
    };
    for (var element in cart!.items) {
      totalBreakDown["subTotal"] =
          totalBreakDown["subTotal"]! + element.product.price;
    }
    totalBreakDown["tax"] = totalBreakDown["subTotal"]! * 14 / 100;
    totalBreakDown["total"] =
        totalBreakDown["subTotal"]! + totalBreakDown["tax"]!;

    notifyListeners();
  }

  Future<String> addToCart(
    Product product,
    Map<String, String> options,
    int quantity,
  ) async {
    try {
      var cartId = "";
      if (cart != null) {
        cart!.addToCart(product, options, quantity);
        cartId = cart!.id;
      }
      notifyListeners();
      var user = await Amplify.Auth.getCurrentUser();
      var body = json.encode({
        "product": product.id,
        "options": {
          "color": options["color"]!.toString(),
          "size": options["size"]!,
        },
        "quantity": quantity
      });
      var params = RestOptions(
        path: "/cart",
        apiName: "userApi",
        body: Uint8List.fromList(
          body.codeUnits,
        ),
        queryParameters: {
          "id": user.userId,
          "cartId": cartId,
        },
      );

      var res = await Amplify.API.post(restOptions: params).response;
      if (cartId.isEmpty) {
        cart = CartModal(id: res.body, items: []);
        cart!.addToCart(product, options, quantity);
      }
      return "Product Added";
    } catch (e) {
      return "Failed to add item";
    }
  }
}
