import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movienight/models/order.dart';
import 'package:movienight/models/ordersStore.dart';
import 'package:provider/provider.dart';
import 'package:movienight/models/CartStore.dart';

import '../utils/app_routes.dart';

class SuccessDelivered extends StatefulWidget {
  const SuccessDelivered({Key? key}) : super(key: key);

  @override
  State<SuccessDelivered> createState() => _SuccessDeliveredState();
}

class _SuccessDeliveredState extends State<SuccessDelivered> {
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
                  child: Center(
                    child: Text(
                      'Thank you!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold,),
                    ),
                  )),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Text(
                    'For confirming that your order has been delivered!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Lottie.asset("assets/lottie/successdelivered.json",
                  repeat: false, animate: true, frameRate: FrameRate.max),
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
                'Back to home',
                style: TextStyle(fontSize: 24),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 255, 17, 0))))),
    );
  }
}
