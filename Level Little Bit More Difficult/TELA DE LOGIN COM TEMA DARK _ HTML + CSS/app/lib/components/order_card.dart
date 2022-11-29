import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movienight/utils/app_routes.dart';

import '../models/order.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard(this.order);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(AppRoutes.ORDER_DETAILS, arguments: order),
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 150,
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(order.products[0].product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                          DateTime.fromMicrosecondsSinceEpoch(
                                  order.orderDateTimestamp * 1000)
                              .toString()
                              .split(' ')
                              .first,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${order.products.length} ${order.products.length > 1 ? 'products' : 'product'}',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(124, 255, 255, 255)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'R\$ ${order.price} ',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(124, 255, 255, 255)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Chip(
                        label: Text(order.isSuccessfullydDelivery
                            ? 'Delivered'
                            : 'Not delivered'),
                        backgroundColor: order.isSuccessfullydDelivery
                            ? Color.fromARGB(255, 8, 126, 61)
                            : Color.fromARGB(255, 93, 93, 93),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    ));
  }
}
