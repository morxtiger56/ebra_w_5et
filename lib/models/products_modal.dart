import 'dart:convert';
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
  late List<String>? images;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    this.isFavorite = false,
    required this.originalPrice,
    this.colors,
    this.sizes,
    this.images,
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
    images = [];

    for (var element in (object['colors'] as List<dynamic>)) {
      colors!.add(hexToColor(element));
    }
    for (var element in (object['sizes'] as List<dynamic>)) {
      sizes!.add(element);
    }
    for (var element in (object['images'] as List<dynamic>)) {
      images!.add(element);
    }
    isFavorite = false;
  }

  likeProduct() {
    isFavorite = !isFavorite;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'isFavorite': isFavorite,
      'originalPrice': originalPrice,
      'colors': colors,
      'sizes': sizes,
      'images': images,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, description: $description, isFavorite: $isFavorite, originalPrice: $originalPrice, colors: $colors, sizes: $sizes, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.description == description &&
        other.isFavorite == isFavorite &&
        other.originalPrice == originalPrice &&
        other.colors == colors &&
        other.sizes == sizes &&
        other.images == images;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        description.hashCode ^
        isFavorite.hashCode ^
        originalPrice.hashCode ^
        colors.hashCode ^
        sizes.hashCode ^
        images.hashCode;
  }
}
