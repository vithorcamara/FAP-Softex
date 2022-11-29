import 'package:movienight/components/main_drawer.dart';
import 'package:movienight/models/movie.dart';
import 'package:movienight/screens/cart_screen.dart';
import 'package:movienight/screens/home_screen.dart';
import 'package:movienight/screens/profile_screen.dart';
import 'package:movienight/screens/movie_screen.dart';
import 'package:movienight/screens/movie_products_screen.dart';

import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  final int screenNumber;

  const TabsScreen(this.screenNumber, {Key? key}) : super(key: key);
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  
  int _indexSelectedScreen = 0;

  List<Widget> _screens = [Home(), ProfileScreen(), CartScreen()];

  _selectScreen(int index) {
    setState(() {
      _indexSelectedScreen = index;
    });
  }

  @override
  void initState() {
    _selectScreen(widget.screenNumber > 0 ? widget.screenNumber : 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: _screens[_indexSelectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey,
        currentIndex: _indexSelectedScreen,
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
