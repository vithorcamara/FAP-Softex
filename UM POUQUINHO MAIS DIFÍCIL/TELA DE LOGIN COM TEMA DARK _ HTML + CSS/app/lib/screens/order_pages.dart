import 'dart:convert';

import 'package:movienight/components/card_movie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movienight/components/movie_cover.dart';
import 'package:movienight/components/order_card.dart';
import 'package:movienight/models/order.dart';
import 'package:movienight/models/ordersStore.dart';
import 'package:movienight/services/api.dart';
import 'package:provider/provider.dart';
import '../data/my_data.dart';
import '../models/UserStore.dart';
import 'package:http/http.dart' as http;

import '../models/order.dart';

// TESTING - HENRY
class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late Future<List<Order>> futureOrders;
  Future<List<Order>> fetchOrder() async {
    return OrdersStore.getOrders();
  }

  @override
  void initState() {
    super.initState();
    futureOrders = fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Order>>(
          future: futureOrders,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 20, top: 45, bottom: 15),
                          child: Text(
                            'Your Orders',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          )),
                    ),
                    Column(
                      children: snapshot.data!.map((order) {
                        
                        print(order);
                        return OrderCard(order);
                      }).toList(),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          }),
    );
  }
}
