import 'package:fish_redux/fish_redux.dart';

import '../../models/movie.dart';

class SearchState implements Cloneable<SearchState> {
  List<Movie> movies;
  List<Movie> favoriteMovies;
  String query;

  @override
  SearchState clone() {
    return SearchState()
      ..movies = movies
      ..query = query;
  }
}

SearchState initState(dynamic args) {
  return SearchState();
}
