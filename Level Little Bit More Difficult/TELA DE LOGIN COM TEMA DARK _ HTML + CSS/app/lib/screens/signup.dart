import 'package:flutter/material.dart';
import 'package:movienight/services/api.dart';
import 'package:provider/provider.dart';

import '../models/UserStore.dart';
import '../utils/app_routes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
      http.Response response =
          await Api.post('/auth', {
        "username": username,
        "password": password,
      });
      if (response.statusCode == 201) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.LOGIN);
      }
    }

    Widget _loginButton() {
      return Container(
          width: double.infinity,
          height: 52,
          decoration: const BoxDecoration(
              color: Color(0xE3E50914),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: TextButton(
              onPressed: () {
                doLogin();
              },
              child: const Text(
                'Create account',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              )));
    }

    Widget _logo() {
      return Column(
        children: [
          SizedBox(
            child: Image.network(
                'https://www.iconpacks.net/icons/1/free-movie-icon-850-thumb.png'),
            height: 100,
          ),
          const Text("MovieNight", style: TextStyle(fontSize: 24)),
        ],
      );
    }

    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.imgur.com/1IHuUzS.jpg'),
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
                    _logo(),
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
                    TextField(
                      onChanged: (String text) {
                        setPassword(text);
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Password',
                          hintText: 'Safe password goes here...'),
                    ),
                    const SizedBox(height: 80),
                    _loginButton(),
                  ],
                ),
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Do you have account?"),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.LOGIN);
                      },
                      child: const Text("Login",
                          style: TextStyle(
                              color: Color(0xE3E50914),
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            ),
          ))
    ]);
  }
}

/*child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: [
                _logo(),
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
                SizedBox(height: 32),
                TextField(
                  onChanged: (String text) {
                    setPassword(text);
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Password',
                      hintText: 'Safe password goes here...'),
                ),
                /*Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        doLogin();
                        Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ),
                  ),*/
                SizedBox(height: 80),
                _loginButton(),
              ],
            ),
            SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                Text("Sign Up",
                    style: TextStyle(
                        color: Color(0xE3E50914), fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),*/
