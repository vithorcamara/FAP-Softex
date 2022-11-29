// ignore_for_file: unnecessary_const

import 'package:movienight/models/genre.dart';
import 'package:movienight/models/movie.dart';
import 'package:flutter/material.dart';

List<Movie> MOVIES = [
  Movie(
      id: 0,
      title: 'The Batman',
      popularity: 5400.092,
      posterPath:
          'https://image.tmdb.org/t/p/original/tuzKA9K5Ae9IzaA0R9oAgbyhAI3.jpg',
      overview:
          'In his second year of fighting crime, Batman uncovers corruption in Gotham City that connects to his own family while facing a serial killer known as the Riddler.',
      status: "Released",
      tagline: "Unmask the truth.",
      voteAverage: 7.8,
      realeaseDate: "2022-03-01",
      runtime: 176),
  Movie(
      id: 0,
      title: 'Sonic the Hedgehog 2',
      popularity: 14361.939,
      posterPath:
          'https://image.tmdb.org/t/p/original/6DrHO1jr3qVrViUO6s6kFiAGM7.jpg',
      overview:
          'after settling in Green Hills, Sonic is eager to prove he has what it takes to be a true hero. His test comes when Dr. Robotnik returns, this time with a new partner, Knuckles, in search for an emerald that has the power to destroy civilizations. Sonic teams up with his own sidekick, Tails, and together they embark on a globe-trotting journey to find the emerald before it falls into the wrong hands.',
      status: "Released",
      tagline: "Welcome to the next level.",
      voteAverage: 7.7,
      realeaseDate: "2022-03-30",
      runtime: 122),
  Movie(
      id: 0,
      title: 'Doctor Strange in the Multiverse of Madness',
      popularity: 5846.845,
      posterPath:
          'https://image.tmdb.org/t/p/original/5ZuctJh5uX5L2dz1CjA7WsTJwZk.jpg',
      overview:
          'Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary."',
      status: "Released",
      tagline: "Enter a new dimension of Strange.",
      voteAverage: 7.5,
      realeaseDate: "2022-05-04",
      runtime: 126)
];
