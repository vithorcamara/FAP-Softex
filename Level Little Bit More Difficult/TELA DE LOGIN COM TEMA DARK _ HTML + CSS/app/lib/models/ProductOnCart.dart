import 'package:movienight/models/product.dart';

class ProductOnCart {
  Product product;
  int quantity = 0;

  ProductOnCart(this.product, this.quantity);

  factory ProductOnCart.fromJson(Map<String, dynamic> json) {
    return ProductOnCart(
      Product.fromJson(json['product']),
      json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}
