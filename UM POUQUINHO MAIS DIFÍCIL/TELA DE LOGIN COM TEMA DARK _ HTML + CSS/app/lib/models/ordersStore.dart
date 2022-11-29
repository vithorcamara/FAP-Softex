import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movienight/models/genre.dart';
import 'package:movienight/models/order.dart';
import 'package:movienight/models/product.dart';
import 'package:movienight/models/show.dart';
import 'package:http/http.dart' as http;
import 'package:movienight/services/api.dart';

class OrdersStore {
  static Future<String> addOrders(Order order) async {
    http.Response response = await Api.post('/orders', {
      "isSuccessfullydDelivery": order.isSuccessfullydDelivery,
      "products": order.products.map((product) => product.toJson()).toList(),
      "price": order.price,
      "orderDateTimestamp": order.orderDateTimestamp,
      "id": order.id,
      "receivedOrderDateTimestamp": order.receivedOrderDateTimestamp,
    });
    return json.decode(response.body)['message'];
  }

  static Future<List<Order>> getOrders() async {
    http.Response response = await Api.get('/orders');
    if (response.statusCode == 200) {
      return (json.decode(response.body)['orders'] as List)
          .map((order) => Order.fromJson(order))
          .toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  static Future<int> updateOrder(Order order) async {
    http.Response response = await Api.put('/orders', {
      "id": order.id,
      "isSuccessfullydDelivery": true,
    });
    return response.statusCode;
  }
}
