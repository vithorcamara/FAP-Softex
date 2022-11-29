import 'package:http/http.dart';
import 'package:movienight/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/UserStore.dart';

class MainDrawer extends StatelessWidget {
  final _urlImage =
      'https://static.generated.photos/vue-static/face-generator/landing/wall/20.jpg';

  Widget buildMenuItem(
      {required String text,
      required IconData icon,
      required Function() onTap}) {
    const color = Colors.white;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        text,
        style: const TextStyle(color: color),
      ),
      onTap: onTap,
    );
  }

  Widget buildDrawerHeader({required name, required urlImage}) {
    return InkWell(
        child: Container(
      child: Row(children: [
        CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
        const SizedBox(
          width: 24,
        ),
        Text(name)
      ]),
    ));
  }

  @override
  Widget build(BuildContext context) {
    doLogout() async{
      final store = context.read<UserStore>();
      Response response = await store.logout();
      const CircularProgressIndicator();
      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.LOGIN);
      }
    }
    final store = context.read<UserStore>();
    return Drawer(
        child: Material(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        children: [
          buildDrawerHeader(name: store.user!.username, urlImage: _urlImage),
          const SizedBox(height: 24),
          const Divider(
            height: 3,
            thickness: 1,
            color: Colors.grey,
          ),
          buildMenuItem(
              text: 'Logout',
              icon: Icons.login,
              onTap: () async { await doLogout();}),
        ],
      ),
    ));
  }
}
