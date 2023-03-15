class Category {
  late String id;
  late String name;
  late String description;
  late String parent;
  late Image image;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.parent,
    required this.image,
  });

  Category.fromJson(Map<String, dynamic> object) {
    id = object['id'];
    name = object['name'];
    description = object['description'];
    parent = object['parent'];
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
