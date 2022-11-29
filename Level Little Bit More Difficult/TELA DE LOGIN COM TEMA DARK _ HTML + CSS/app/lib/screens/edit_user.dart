import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../models/UserStore.dart';
import '../utils/app_routes.dart';

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
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
    updateUser() async {
      final store = context.read<UserStore>();
      Response response = await store.updateUser(username);
      const CircularProgressIndicator();
      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
      }
    }

    deleteAccount() async {
      final store = context.read<UserStore>();
      Response response = await store.deleteAccount(username);
      const CircularProgressIndicator();
      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.LOGIN);
      }
    }

    return Scaffold(body: Consumer<UserStore>(builder: (context, user, child) {
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
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: [
                      TextField(
                        onChanged: (String text) {
                          setUsername(text);
                        },
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Username',
                        ),
                      ),
                      const SizedBox(height: 32),
                      const SizedBox(height: 80),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                            width: double.infinity,
                            height: 52,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(226, 255, 255, 255),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: TextButton(
                                onPressed: () {
                                  updateUser();
                                },
                                child: const Text(
                                  'Change username',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 0, 0),
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
                                color: Color(0xE3E50914),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: TextButton(
                                onPressed: () {
                                  deleteAccount();
                                },
                                child: const Text(
                                  'Delete account',
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                            .pushNamed(AppRoutes.PROFILE);
                                },
                                child: const Text(
                                  'Cancel',
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
            ))
      ]);
    }));
  }
}