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
}
