import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'movie.dart';

class FavoriteListModel extends ChangeNotifier {
  static const prefsKey = "FavoriteListModel";
  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  FavoriteListModel() {
    () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String value = prefs.getString(prefsKey);
      if (value?.isEmpty ?? true) return;

      var json = jsonDecode(value);
      _movies = List<Movie>.from(json.map((x) => Movie.fromJson(x)));
      notifyListeners();
    }();
  }

  void _update() async {
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(prefsKey, jsonEncode(_movies));
  }

  void add(Movie movie) {
    _movies.add(movie);
    _update();
  }

  Movie get(String imdbId) {
    return _movies.firstWhere((x) => x.imdbId == imdbId);
  }

  void giveStar(String imdbId, int star) {
    get(imdbId).star = star;
    _update();
  }

  bool has(String imbdId) {
    return _movies.indexWhere((x) => x.imdbId == imbdId) > -1;
  }

  void remove(String imdbId) {
    var idx = _movies.indexWhere((x) => x.imdbId == imdbId);
    if (idx >= 0) _movies.removeAt(idx);
    _update();
  }
}
