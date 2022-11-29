import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                  'https://br.web.img3.acsta.net/pictures/22/02/14/18/29/1382589.png'),
            ),
          ),
        )
      ],
    ));
  }
}
