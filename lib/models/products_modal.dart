import 'dart:ui';

class Product {
  late String id;
  late String name;
  late double price;
  late String description;
  late bool isFavorite;
  late double originalPrice;
  late List<Color>? colors;
  late List<String>? sizes;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.originalPrice,
    this.isFavorite = false,
    this.colors,
    this.sizes,
  });

  /// Construct a color from a hex code string, of the format #RRGGBB.
  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Product.fromJson(Map<String, dynamic> object) {
    id = object['id'];
    name = object['text'];
    price = (object['price'] as int).toDouble();
    description = object['description'];
    originalPrice = object['original_price'] != null
        ? (object['original_price'] as int).toDouble()
        : ((object['price'] * 2) as int).toDouble();
    colors = [];
    sizes = [];
    for (var element in (object['colors'] as List<dynamic>)) {
      colors!.add(hexToColor(element));
    }
    for (var element in (object['sizes'] as List<dynamic>)) {
      sizes!.add(element);
    }
    isFavorite = false;
  }

  likeProduct() {
    isFavorite = !isFavorite;
  }
}

class Image {
  String url = '';

  Image({required this.url});

  Image.fromJson(Map<String, dynamic> object) {
    url = object['src'];
  }
}
