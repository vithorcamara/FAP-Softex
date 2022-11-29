import 'package:flutter/material.dart';
import 'package:movienight/models/tv.dart';

import 'movie.dart';

class User {
  final String id;
  final String username;
  final String password;
  final List<Movie> watchedMovies;
  final List<TV> watchedTvs;
  int totalTimeWatched;

  User(
      {required this.id,
      required this.username,
      required this.password,
      required this.watchedMovies,
      required this.watchedTvs,
      required this.totalTimeWatched});

  void addWatchMovie(Movie movie) {
    watchedMovies.add(movie);
    totalTimeWatched += movie.runtime;
  }

  void removeWatchMovie(Movie movie) {
    if (watchedMovies.contains(movie)) {
      watchedMovies.remove(movie);
      totalTimeWatched -= movie.runtime;
    }
    return;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      password: json['password'],
      watchedMovies: ((json['watchedMovies']) as List)
          .map((movie) => Movie.fromJson(movie))
          .toList(),
      watchedTvs: [],
      totalTimeWatched: json['totalTimeWatched'],
    );
  }
}
