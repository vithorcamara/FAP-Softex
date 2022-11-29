import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movienight/models/CartStore.dart';

import '../utils/app_routes.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Consumer<CartStore>(builder: (context, cart, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cart.productsOnCart.length,
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          Row(children: [
                            CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(cart
                                    .productsOnCart[index].product.imageUrl)),
                            SizedBox(width: 24),
                            Expanded(
                              child: Text(
                                cart.productsOnCart[index].product.name,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  context.read<CartStore>().selfRemove(index);
                                },
                                icon: Icon(Icons.remove_circle)),
                            Text("${cart.productsOnCart[index].quantity}"),
                            IconButton(
                                onPressed: () {
                                  context.read<CartStore>().selfAdd(index);
                                },
                                icon: Icon(Icons.add_circle))
                          ]),
                        ],
                      );
                    })),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  Text('R\$ ${cart.totalPrice.toStringAsFixed(2)}',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
        );
      }),
      bottomNavigationBar: Consumer<CartStore>(
        builder: (context, cart, child) {
          return Container(
              height: 70,
              child: ElevatedButton(
                  onPressed: cart.productsOnCart.length == 0
                      ? null
                      : () {
                          Navigator.of(context).pushNamed(AppRoutes.ADRESS);
                        },
                  child: Text(
                    'Buy!',
                    style: TextStyle(fontSize: 24),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                    cart.productsOnCart.length == 0
                        ? Color.fromARGB(224, 54, 54, 54)
                        : Color.fromARGB(225, 255, 0, 0),
                  ))));
        },
      ),
    );
  }
}

/* 
Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(children: [
                CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://i.kym-cdn.com/entries/icons/original/000/033/421/cover2.jpg')),
                SizedBox(width: 24),
                Expanded(
                  child: Text(
                    'Item Name',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.remove_circle)),
                Text('Quantidade'),
                IconButton(onPressed: () {}, icon: Icon(Icons.add_circle))
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  Text('R\$ 99.99')
                ],
              )
            ],
          ),
        )*/