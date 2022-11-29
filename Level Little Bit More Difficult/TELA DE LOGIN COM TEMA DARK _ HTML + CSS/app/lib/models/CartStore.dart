import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:movienight/models/ProductOnCart.dart';
import 'package:movienight/models/product.dart';

class CartStore extends ChangeNotifier {
  List<ProductOnCart> productsOnCart = [];
  double totalPrice = 0;

  void calculateTotal() {
    double sum = 0;
    for (var i = 0; i < productsOnCart.length; i++) {
      sum += productsOnCart[i].quantity * productsOnCart[i].product.price;
    }
    totalPrice = sum;
  }

  void addToCart(Product product) {
    for (var i = 0; i < productsOnCart.length; i++) {
      if (productsOnCart[i].product.id == product.id) {
        productsOnCart[i].quantity++;
        calculateTotal();
        return;
      }
    }
    productsOnCart.add(ProductOnCart(product, 1));
    calculateTotal();
  }

  void selfAdd(int index) {
    productsOnCart[index].quantity++;
    calculateTotal();
    notifyListeners();
  }

  void selfRemove(int index) {
    if (productsOnCart[index].quantity == 0) {
      return;
    }
    productsOnCart[index].quantity--;
    calculateTotal();
    notifyListeners();
  }

  void removeAllProducts() {
    productsOnCart.clear();
    calculateTotal();
    notifyListeners();
  }
}
