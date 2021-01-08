import 'package:flutter/foundation.dart';

@immutable
class Movie {
  final String title;
  final String imdbId;
  final String poster;
  final String type;
  final String year;

  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;

  Movie.fromJson(Map<String, dynamic> json)
      : title = json['Title'],
        imdbId = json['imdbID'],
        poster = json['Poster'],
        type = json['Type'],
        year = json['Year'],
        released = json['Released'],
        runtime = json['Runtime'],
        genre = json['Genre'],
        director = json['Director'],
        writer = json['Writer'],
        actors = json['Actors'],
        plot = json['Plot'];
}
