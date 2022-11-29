import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../models/UserStore.dart';
import '../utils/app_routes.dart';

class FirstLoad extends StatefulWidget {
  const FirstLoad({Key? key}) : super(key: key);

  @override
  State<FirstLoad> createState() => _FirstLoadState();
}

class _FirstLoadState extends State<FirstLoad> {
  void checkFirstRoute(UserStore userStore) async {
    if (await userStore.hasUserOnLocalStorage()) {
      await userStore.getUserFromLocalStorage();
      Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
    }else{
      Navigator.of(context).pushReplacementNamed(AppRoutes.LOGIN);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      UserStore userStore = Provider.of<UserStore>(context, listen: false);
      checkFirstRoute(userStore);
    });
  }

  String username = '';

  setUsername(String _username) {
    setState(() {
      username = _username;
    });
  }

  String password = '';

  setPassword(String _password) {
    setState(() {
      password = _password;
    });
  }

  @override
  Widget build(BuildContext context) {
    doLogin() async {
      final store = context.read<UserStore>();
      Response response = await store.login(username, password);
      const CircularProgressIndicator();
      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
      }
    }

    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://image.tmdb.org/t/p/original/5ZuctJh5uX5L2dz1CjA7WsTJwZk.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Color.fromARGB(178, 0, 0, 0), BlendMode.darken),
          ),
        ),
      ),
      const Scaffold(
        backgroundColor: Colors.transparent,
      )
    ]);
  }
}