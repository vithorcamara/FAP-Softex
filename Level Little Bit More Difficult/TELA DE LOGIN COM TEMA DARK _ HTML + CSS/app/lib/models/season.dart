import 'package:flutter/material.dart';

import 'episode.dart';

class Season {
  final String id;
  final String airDate;
  final String name;
  final String posterPath;
  final String overview;
  final int seasonNumber;
  final List<Episode> episodes;

  const Season({
    required this.id,
    required this.airDate,
    required this.name,
    required this.posterPath,
    required this.overview,
    required this.seasonNumber,
    required this.episodes,
  });
}
