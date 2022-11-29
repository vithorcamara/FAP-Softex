import 'package:flutter/material.dart';
import 'package:movienight/models/genre.dart';
import 'package:movienight/models/season.dart';
import 'package:movienight/models/show.dart';

class TV extends Show {
  final String realeaseDate;
  final String firstAirDate;
  final String lastAirDate;
  final List<Season> seasons;
  final int numberOfEpisodes;

  const TV(
      {required int id,
      required String title,
      required double popularity,
      required String posterPath,
      required String overview,
      required String status,
      required String tagline,
      required double voteAverage,
      required this.realeaseDate,
      required this.numberOfEpisodes,
      required this.firstAirDate,
      required this.seasons,
      required this.lastAirDate})
      : super(
          id: id,
          title: title,
          popularity: popularity,
          posterPath: posterPath,
          overview: overview,
          status: status,
          tagline: tagline,
          voteAverage: voteAverage,
        );
}
