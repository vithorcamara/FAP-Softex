import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movienight/models/movie.dart';
import 'package:movienight/models/CartStore.dart';
import 'package:movienight/models/product.dart';
import 'package:movienight/services/api.dart';
import 'package:movienight/utils/app_routes.dart';
import 'package:provider/provider.dart';

class MovieProductsScreen extends StatefulWidget {
  const MovieProductsScreen({Key? key}) : super(key: key);

  @override
  State<MovieProductsScreen> createState() => _MovieProductsScreenState();
}

class _MovieProductsScreenState extends State<MovieProductsScreen> {
  Future<List<Product>> getProductsOfMovie(context) async {
    if (ModalRoute.of(context)!.settings.arguments == Null) {}
    final arguments = ModalRoute.of(context)!.settings.arguments as Movie;

    Response response = await Api.get('/stores', params: {
      'movieID': arguments.id.toString(),
    });
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      List? listOfProducts = responseJson['store']['products'];
      if (listOfProducts != null) {
        return (responseJson['store']['products'] as List)
            .map((p) => Product.fromJson(p))
            .toList();
      }
      return [];
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProductsOfMovie(context).then((result) {
        setProducts(result);
      });
    });
  }

  List<Product>? products;
  setProducts(List<Product> _products) {
    setState(() {
      products = _products;
    });
  }

  Widget renderProducts() {
    if (products != null) {
      return Column(children: [
        Flexible(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: products!.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(products![index].imageUrl)),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    products![index].name.length > 18
                                        ? products![index].name.replaceRange(18,
                                            products![index].name.length, '...')
                                        : products![index].name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'R\$ ${products![index].price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                            iconSize: 32,
                            color: Colors.white,
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Adicionou produto ${products![index].name} ao carrinho')));
                              final product = context.read<CartStore>();
                              product.addToCart(products![index]);
                            },
                            icon: Icon(
                              Icons.add_circle,
                              color: Color.fromARGB(255, 255, 17, 0),
                            ))
                      ]),
                );
              })),
        ),
      ]);
    }
    return const Text('Loading products...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Products'),
      ),
      body: Center(child: renderProducts()),
      bottomNavigationBar: Container(
          height: 70,
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART);
              },
              child: Text(
                'Check Cart',
                style: TextStyle(fontSize: 24),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 255, 17, 0))))),
    );
  }
}
