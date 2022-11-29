import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movienight/models/CartStore.dart';
import 'package:movienight/models/order.dart';
import 'package:movienight/models/ordersStore.dart';
import 'package:provider/provider.dart';

import '../models/CartStore.dart';
import '../models/UserStore.dart';
import '../utils/app_routes.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails>
    with TickerProviderStateMixin {
  String cardName = '';
  String cardNumber = '';
  String cvv = '';
  String valideTo = '';
  late AnimationController lottieController;
  @override
  void initState() {
    super.initState();

    lottieController = AnimationController(
      vsync: this,
    );

    lottieController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        lottieController.reset();
      }
    });
  }

  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setCardName(String _cardName) {
      setState(() {
        cardName = _cardName;
      });
    }

    setCardNumber(String _cardNumber) {
      setState(() {
        cardNumber = _cardNumber;
      });
    }

    setCvv(String _cvv) {
      setState(() {
        cvv = _cvv;
      });
    }

    setValideTo(String _valideTo) {
      setState(() {
        valideTo = _valideTo;
      });
    }

    isPaymentValide() {
      if (cardName.isEmpty ||
          cardNumber.isEmpty ||
          cvv.isEmpty ||
          valideTo.isEmpty) {
        return false;
      }
      return true;
    }

    doBuy() async {
      final cartStore = context.read<CartStore>();
      String response = await OrdersStore.addOrders(Order(
          id: '',
          products: cartStore.productsOnCart,
          isSuccessfullydDelivery: false,
          price: cartStore.totalPrice,
          orderDateTimestamp: DateTime.now().millisecondsSinceEpoch,
          receivedOrderDateTimestamp: 0));
      if (response == 'Order generated') {
        Navigator.of(context).pushNamed(AppRoutes.SUCCESS_BUY);
      }
    }

    return Scaffold(body: Consumer<UserStore>(builder: (context, user, child) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Payment',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    )),
              ),
              Column(
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset("assets/lottie/pay.json",
                            animate: true,
                            frameRate: FrameRate.max,
                            reverse: true),
                      ],
                    ),
                  ),
                  TextField(
                    onChanged: (String text) {
                      setCardName(text);
                    },
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Card Name',
                    ),
                  ),
                  TextField(
                    onChanged: (String text) {
                      setCardNumber(text);
                    },
                    inputFormatters: [ TextInputMask(mask: '9999 9999 9999 9999') ],
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Card Number',
                    ),
                  ),
                  TextField(
                    onChanged: (String text) {
                      setCvv(text);
                    },
                    inputFormatters: [ TextInputMask(mask: '999') ],
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'cvv',
                    ),
                  ),
                  TextField(
                    onChanged: (String text) {
                      setValideTo(text);
                    },
                    inputFormatters: [ TextInputMask(mask: '99/99') ],
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Valide To',
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                            color: !isPaymentValide()
                                ? Color.fromARGB(224, 54, 54, 54)
                                : Color.fromARGB(225, 255, 0, 0),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: TextButton(
                            onPressed: !isPaymentValide()
                                ? null
                                : () {
                                    doBuy();
                                  },
                            child: const Text(
                              'BUY',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                        width: double.infinity,
                        height: 52,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(225, 0, 0, 0),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(AppRoutes.CART);
                            },
                            child: const Text(
                              'Back',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ))),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }));
  }
}
