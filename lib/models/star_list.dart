import 'package:flutter/foundation.dart';
import 'movie.dart';

class StarListModel extends ChangeNotifier {
  final List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  void add(Movie movie) {
    _movies.add(movie);
    notifyListeners();
  }

  bool has(String imbdId) {
    return _movies.indexWhere((x) => x.imdbId == imbdId) > -1;
  }

  void remove(String imdbId) {
    var idx = _movies.indexWhere((x) => x.imdbId == imdbId);
    if (idx >= 0) _movies.removeAt(idx);
    notifyListeners();
  }
}
