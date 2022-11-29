import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:movienight/models/CartStore.dart';

import '../utils/app_routes.dart';

class SuccessBuy extends StatefulWidget {
  const SuccessBuy({Key? key}) : super(key: key);

  @override
  State<SuccessBuy> createState() => _SuccessBuyState();
}

class _SuccessBuyState extends State<SuccessBuy> {
  //final arguments = ModalRoute.of(context)!.settings.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: Text(
                    'Nice!',
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                  )),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Text(
                    'Your order is being shipped',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Lottie.asset(
                  "assets/lottie/successbuy.json",
                  animate: true,
                  frameRate: FrameRate.max,
                  repeat: false),
            ],
          ),
          alignment: Alignment.center),
      bottomNavigationBar: Container(
          height: 70,
          child: ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text(
                'Home',
                style: TextStyle(fontSize: 24),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 255, 17, 0))))),
    );
  }
}