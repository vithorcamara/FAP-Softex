import 'package:flutter/services.dart';
import 'package:movienight/screens/adress_page.dart';
import 'package:movienight/screens/cart_screen.dart';
import 'package:movienight/screens/firstLoad.dart';
import 'package:movienight/screens/edit_user.dart';
import 'package:movienight/screens/movie_products_screen.dart';
import 'package:movienight/screens/order_details.dart';
import 'package:movienight/screens/order_pages.dart';
import 'package:movienight/screens/payment_details.dart';
import 'package:movienight/screens/qr_code_scanner.dart';
import 'package:movienight/screens/success_buy_screen.dart';
import 'package:movienight/screens/login_screen.dart';
import 'package:movienight/screens/movie_screen.dart';
import 'package:movienight/screens/signup.dart';
import 'package:movienight/screens/success_delivered.dart';
import 'package:movienight/screens/tabs_screen.dart';
import 'package:movienight/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/UserStore.dart';
import 'models/CartStore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  runApp(const MyApp());
  await dotenv.load(fileName: '.env');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserStore()),
        ChangeNotifierProvider(create: (context) => CartStore())
      ],
      child: MaterialApp(
        title: 'MovieNight',
        theme: ThemeData(brightness: Brightness.light),
        darkTheme: ThemeData(
            appBarTheme: const AppBarTheme(
              color: Color.fromARGB(255, 32, 32, 32),
              titleTextStyle: TextStyle(color: Colors.white),
              iconTheme:
                  IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
            colorScheme: ColorScheme.fromSwatch().copyWith(
                brightness: Brightness.dark,
                primary: const Color.fromARGB(255, 35, 38, 43),
                secondary: const Color.fromARGB(255, 255, 255, 255))),
        themeMode: ThemeMode.dark,
        initialRoute: '/firstload',
        routes: {
          AppRoutes.HOME: (ctx) => const TabsScreen(0),
          AppRoutes.PROFILE: (ctx) => const TabsScreen(1),
          AppRoutes.LOGIN: (ctx) => const LoginScreen(),
          AppRoutes.SIGNUP: (ctx) => const SignupScreen(),
          AppRoutes.MOVIE: (ctx) => const MovieScreen(),
          AppRoutes.PRODUCTS: (ctx) => const MovieProductsScreen(),
          AppRoutes.CART: (ctx) => const CartScreen(),
          AppRoutes.FIRSTLOAD: (ctx) => const FirstLoad(),
          AppRoutes.EDITUSER: (ctx) => const EditUser(),
          AppRoutes.SUCCESS_BUY: (ctx) => const SuccessBuy(),
          AppRoutes.ADRESS: (ctx) => const Adress(),
          AppRoutes.PAYMENT_DETAILS: (ctx) => const PaymentDetails(),
          AppRoutes.ORDER_DETAILS: (ctx) => const OrderDetails(),
          AppRoutes.ORDERS: (ctx) => const OrderPage(),
          AppRoutes.SCANNER: (ctx) => const QrCodeScanner(),
          AppRoutes.DELIVERED_SUCCESS: (ctx) => const SuccessDelivered(),
        },
      ),
    );
  }
}
