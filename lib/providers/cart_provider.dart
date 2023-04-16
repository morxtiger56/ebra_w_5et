import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import '../models/address_modal.dart';
import '../models/cart_modal.dart';
import 'package:flutter/foundation.dart';

import '../models/order_modal.dart';
import '../models/products_modal.dart';

class CartProvider with ChangeNotifier {
  CartModal? cart;
  List<Order> orders = [];
  CartProvider();
  Map<String, double> totalBreakDown = {
    "subTotal": 0,
    "tax": 0,
    "total": 0,
  };

  String selectedAddress = "";

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

      if (jsonDecode(response.body) == "No open cart found") {
        return;
      }

      cart = CartModal.fromMap(jsonDecode(response.body));
      getTotal();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getOrders() async {
    try {
      var user = await Amplify.Auth.getCurrentUser();
      var response = await Amplify.API
          .get(
              restOptions: RestOptions(
            path: "/orders",
            apiName: "userApi",
            queryParameters: {
              "id": user.userId,
            },
          ))
          .response;
    } catch (e) {}
  }

  void changeSelectedAddress(String id) {
    selectedAddress = id;
    notifyListeners();
  }

  void getTotal() {
    if (cart == null) {
      return;
    }
    if (cart!.items.isEmpty) {
      return;
    }
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

  Future<String> checkout(AddressModal address) async {
    getTotal();
    Order order = Order(
      id: cart!.id,
      total: totalBreakDown["total"]!,
      items: cart!.items,
    );

    var user = await Amplify.Auth.getCurrentUser();

    var params = RestOptions(
      path: '/orders',
      apiName: "userApi",
      queryParameters: {
        "cartId": cart!.id,
        "id": user.userId,
        "total": totalBreakDown["total"]!.toString()
      },
      body: Uint8List.fromList(json.encode(address).codeUnits),
    );
    try {
      await Amplify.API.post(restOptions: params).response;
      orders.add(order);
      cart = CartModal(id: "", items: []);

      totalBreakDown = {
        "subTotal": 0,
        "tax": 0,
        "total": 0,
      };
      notifyListeners();
      return "Order Added";
    } catch (e) {
      print(e);
      return "Order not found";
    }
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
        cart = CartModal(id: jsonDecode(res.body), items: []);
        cart!.addToCart(product, options, quantity);
      }
      return "Product Added";
    } catch (e) {
      return "Failed to add item";
    }
  }
}
