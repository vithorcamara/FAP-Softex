import 'package:flutter/material.dart';
import 'package:movienight/models/order.dart';
import 'package:movienight/models/ordersStore.dart';
import 'package:provider/provider.dart';

import '../utils/app_routes.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments == Null) {}
    final arguments = ModalRoute.of(context)!.settings.arguments as Order;

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  Text('R\$ ${arguments.price.toStringAsFixed(2)}',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: arguments.products.length,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(children: [
                            CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(arguments
                                    .products[index].product.imageUrl)),
                            SizedBox(width: 24),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${arguments.products[index].quantity}x ${arguments.products[index].product.name}',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    'R\$ ${arguments.products[index].product.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 96, 96, 96)),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ],
                    );
                  })),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          height: 70,
          child: ElevatedButton(
              onPressed: arguments.isSuccessfullydDelivery
                  ? null
                  : () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.SCANNER, arguments: arguments);
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    arguments.isSuccessfullydDelivery
                        ? 'Delivered'
                        : 'Confirm delivery!',
                    style: TextStyle(fontSize: 24),
                  ),
                  if (arguments.isSuccessfullydDelivery)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.thumb_up_sharp),
                    ),
                ],
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 255, 17, 0))))),
    );
  }
}
