import 'package:flutter/material.dart';

class Episode {
  final String id;
  final String airDate;
  final String name;
  final String stillPath;
  final String overview;
  final int episodeNumber;
  final double voteAverage;

  const Episode(
      {required this.id,
      required this.airDate,
      required this.name,
      required this.stillPath,
      required this.overview,
      required this.episodeNumber,
      required this.voteAverage});
}
