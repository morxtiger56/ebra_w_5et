import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:ebra_w_5et/models/products_modal.dart';

class CartModal {
  String id;
  List<CartItem> items;
  CartModal({
    required this.id,
    required this.items,
  });

  void addToCart(Product product, Map<String, String> options, int quantity) {
    for (var e in items) {
      if (e.product.id == product.id) {
        e.quantity++;
        return;
      }
    }
    items.add(
      CartItem(
        product: product,
        options: options,
        quantity: quantity,
      ),
    );
  }

  CartModal copyWith({
    String? id,
    List<CartItem>? items,
  }) {
    return CartModal(
      id: id ?? this.id,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory CartModal.fromMap(Map<String, dynamic> map) {
    return CartModal(
      id: map['id'] ?? '',
      items: List<CartItem>.from(map['items']?.map((x) => CartItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModal.fromJson(String source) =>
      CartModal.fromMap(json.decode(source));

  @override
  String toString() => 'CartModal(id: $id, items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartModal &&
        other.id == id &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode => id.hashCode ^ items.hashCode;
}

class CartItem {
  Product product;
  Map<String, String> options;
  int quantity;
  CartItem({
    required this.product,
    required this.options,
    required this.quantity,
  });

  CartItem copyWith({
    Product? product,
    Map<String, String>? options,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      options: options ?? this.options,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'options': options,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromJson(map['product']),
      options: Map<String, String>.from(map['options']),
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source));

  @override
  String toString() =>
      'CartItem(product: $product, options: $options, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem &&
        other.product == product &&
        mapEquals(other.options, options) &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => product.hashCode ^ options.hashCode ^ quantity.hashCode;
}
