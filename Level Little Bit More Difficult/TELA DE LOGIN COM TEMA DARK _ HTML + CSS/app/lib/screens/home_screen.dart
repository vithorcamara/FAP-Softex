import 'dart:convert';

import 'package:movienight/components/card_movie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movienight/components/movie_cover.dart';
import 'package:provider/provider.dart';
import '../data/my_data.dart';
import '../models/UserStore.dart';
import 'package:http/http.dart' as http;

import '../models/movie.dart';

// TESTING - HENRY
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Movie>> futureMovies;
  Future<List<Movie>> fetchMovie() async {
    List<Movie> movies = [];
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=82a3f2dfd69bea3b6c260866328816d2&language=en-US&page=1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      for (var movie in json.decode(response.body)['results']) {
        var movieId = movie["id"];
        final responseMovieDetails = await http.get(Uri.parse(
            'https://api.themoviedb.org/3/movie/$movieId?api_key=82a3f2dfd69bea3b6c260866328816d2&language=en-US'));
        if (responseMovieDetails.statusCode == 200) {
          var movieJson = json.decode(responseMovieDetails.body);

          Movie movieObject = Movie(
              id: movieJson['id'],
              title: movieJson['title'],
              popularity: movieJson['popularity'],
              posterPath: 'https://image.tmdb.org/t/p/original/' +
                  movieJson['poster_path'],
              overview: movieJson['overview'],
              status: movieJson['status'],
              tagline: movieJson['tagline'],
              voteAverage: movieJson['vote_average'],
              realeaseDate: movieJson['release_date'],
              runtime: movieJson['runtime']);

          movies.add(movieObject);
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          throw Exception('Failed to load Movie');
        }
      }
      return movies;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Movie');
    }
  }

  @override
  void initState() {
    super.initState();
    futureMovies = fetchMovie();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
        future: futureMovies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Consumer<UserStore>(
                    builder: (context, user, child) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 45, vertical: 15),
                            child: Text(
                              'Hi ${user.user!.username}!',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                      );
                    },
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                        child: Text(
                          'Trending Movies',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                  ),
                  CarouselSlider(
                      items: snapshot.data!.map((movie) {
                        return MovieCover(movie);
                      }).toList(),
                      options: CarouselOptions(
                        height: 480.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        aspectRatio: 4 / 5,

                        enableInfiniteScroll: false,
                        //autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      )),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                        child: Text(
                          'All Movies',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                  ),
                  Column(
                    children: snapshot.data!.map((movie) {
                      return CardMovie(movie);
                    }).toList(),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }
}
