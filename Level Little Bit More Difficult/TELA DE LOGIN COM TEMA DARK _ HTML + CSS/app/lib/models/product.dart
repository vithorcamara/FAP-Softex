class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  const Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
