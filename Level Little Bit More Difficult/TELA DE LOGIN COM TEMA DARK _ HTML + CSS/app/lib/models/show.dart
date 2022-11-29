import 'package:flutter/material.dart';
import 'package:movienight/models/genre.dart';

class Show {
  final int id;
  final String title;
  final double popularity;
  final String posterPath;
  final String overview;
  final String status;
  final String tagline;
  final double voteAverage;

  const Show({
    required this.id,
    required this.title,
    required this.popularity,
    required this.posterPath,
    required this.overview,
    required this.status,
    required this.tagline,
    required this.voteAverage,
  });
}
