import 'package:flutter/material.dart';
import 'package:movienight/models/ProductOnCart.dart';
import 'package:movienight/models/genre.dart';
import 'package:movienight/models/product.dart';
import 'package:movienight/models/show.dart';

class Order {
  final bool isSuccessfullydDelivery;
  final List<ProductOnCart> products;
  final double price;
  final int orderDateTimestamp;
  final String id;
  final int receivedOrderDateTimestamp;

  Order(
      {required this.isSuccessfullydDelivery,
      required this.products,
      required this.price,
      required this.orderDateTimestamp,
      required this.id,
      required this.receivedOrderDateTimestamp});

  factory Order.fromJson(Map<String, dynamic> json) {
    Order order = Order(
      isSuccessfullydDelivery: json['isSuccessfullydDelivery'],
      products: json['products']
          .map<ProductOnCart>((product) => ProductOnCart.fromJson(product))
          .toList(),
      price: json['price'],
      orderDateTimestamp: json['orderDateTimestamp'],
      id: json['_id'],
      receivedOrderDateTimestamp: json['receivedOrderDateTimestamp'] ?? 0,
    );
    print(order.orderDateTimestamp);
     return order;
  }
 
}
