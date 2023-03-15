class Product {
  late String id;
  late String name;
  late double price;
  late String description;
  late bool isFavorite;
  late double original_price;
  late Image image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.original_price,
    this.isFavorite = false,
    required this.image,
  });

  Product.fromJson(Map<String, dynamic> object) {
    id = object['id'];
    name = object['name'];
    price = object['price'];
    description = object['description'];
    original_price = object['original_price'];
    image = object['image'] ?? Image.fromJson(object['image']);
  }
}

class Image {
  String url = '';

  Image({required this.url});

  Image.fromJson(Map<String, dynamic> object) {
    url = object['src'];
  }
}
