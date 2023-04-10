import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'cart_modal.dart';

class Order {
  String id;
  double total;
  List<CartItem> items;
  Order({
    required this.id,
    required this.total,
    required this.items,
  });

  Order copyWith({
    String? id,
    double? total,
    List<CartItem>? items,
  }) {
    return Order(
      id: id ?? this.id,
      total: total ?? this.total,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'total': total,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      total: map['total']?.toDouble() ?? 0.0,
      items: List<CartItem>.from(map['items']?.map((x) => CartItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() => 'Order(id: $id, total: $total, items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        other.total == total &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode => id.hashCode ^ total.hashCode ^ items.hashCode;
}
