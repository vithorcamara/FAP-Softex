import 'package:movienight/utils/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';

class MovieCover extends StatelessWidget {
  final Movie movie;

  const MovieCover(this.movie);

  void _selectedMovie(BuildContext context) {
    /*
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return MoviePlacesScreen(movie);
    }));
    */
    Navigator.of(context).pushNamed(
      AppRoutes.COUNTRY_PLACES,
      arguments: movie,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(AppRoutes.MOVIE, arguments: movie),
      child: Container(
        margin: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: NetworkImage(movie.posterPath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
