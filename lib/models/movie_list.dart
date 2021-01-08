import 'package:flutter/foundation.dart';
import './movie.dart';

class MovieListModel extends ChangeNotifier {
  List<Movie> _movies = [];

  loadJson(json) {
    _movies = json.map<Movie>((v) => Movie.fromJson(v)).toList();
    notifyListeners();
  }

  List<Movie> get movies => _movies;
  set movies(List<Movie> newMovies) {
    _movies = newMovies;
    notifyListeners();
  }
}
