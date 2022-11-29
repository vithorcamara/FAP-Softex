import 'package:movienight/utils/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';

class CardMovie extends StatelessWidget {
  final Movie movie;

  const CardMovie(this.movie);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () =>
            Navigator.of(context).pushNamed(AppRoutes.MOVIE, arguments: movie),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 120,
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(movie.posterPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            movie.title.length > 20
                                ? movie.title
                                    .replaceRange(20, movie.title.length, '...')
                                : movie.title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                         Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                                movie.tagline.length > 30
                                    ? movie.tagline
                                        .replaceRange(30, movie.tagline.length, '...')
                                    : movie.tagline,
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 12, color: Color.fromARGB(124, 255, 255, 255)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                                movie.voteAverage.toString() +
                                ' | ' +
                                getTimeString(movie.runtime) +
                                ' hours',
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 12, color: Color.fromARGB(124, 255, 255, 255)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ));
  }
}
