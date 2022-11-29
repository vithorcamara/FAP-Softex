class AppRoutes {
  static const HOME = '/';
  static const PROFILE = '/profile';
  static const COUNTRY_PLACES = '/country-places';
  static const PLACES_DETAIL = '/place-detail';
  static const SETTINGS = '/settings';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const MOVIE = '/movie';
  static const PRODUCTS = '/products';
  static const CART = '/cart';
  static const FIRSTLOAD = '/firstload';
  static const EDITUSER = '/edituser';
  static const SUCCESS_BUY = '/success-buy';
  static const ADRESS = '/adress';
  static const PAYMENT_DETAILS = '/payment';
  static const ORDER_DETAILS = '/order-details';
  static const ORDERS = '/orders';
  static const SCANNER = '/scanner';
  static const DELIVERED_SUCCESS = '/success-delivered';
}

String getTimeString(int value) {
  final int hour = value ~/ 60;
  final int minutes = value % 60;
  return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
}
