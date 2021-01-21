import 'package:fish_redux/fish_redux.dart';
import 'package:movie_app/models/movie.dart';

import '../search/state.dart';

class HomePageState implements Cloneable<HomePageState> {
  List<Movie> favoriteMovies = List<Movie>();
  int currentTab = 0;
  SearchState searchState = SearchState();

  @override
  HomePageState clone() {
    return HomePageState()
      ..favoriteMovies = favoriteMovies
      ..currentTab = currentTab
      ..searchState = searchState;
  }
}

HomePageState initState(Map<String, dynamic> args) {
  return HomePageState();
}
