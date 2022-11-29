import 'package:movienight/utils/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/UserStore.dart';
import '../models/movie.dart';

class AspectRatioMovieCard extends StatelessWidget {
  final Movie movie;

  const AspectRatioMovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushNamed(AppRoutes.MOVIE, arguments: movie),
              child: AspectRatio(
                  aspectRatio: 4 / 5,
                  child: Container(
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(movie.posterPath),
                              fit: BoxFit.cover))))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ElevatedButton(
              onPressed: () {
                context.read<UserStore>().removeMovie(movie.id);
              },
              child: Text('Remove')),
        )
      ],
    );
  }
}
