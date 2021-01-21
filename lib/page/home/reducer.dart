import 'package:fish_redux/fish_redux.dart';
import 'package:movie_app/models/movie.dart';

import 'state.dart';
import 'action.dart';

Reducer<HomePageState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomePageState>>{
      HomePageAction.addFavoriteMovie: _addFavoriteMovie,
      HomePageAction.removeFavoriteMovie: _removeFavoriteMovie,
      HomePageAction.updateFavoriteMovie: _updateFavoriteMovie,
      HomePageAction.changeTab: _changeTab,
    },
  );
}

HomePageState _addFavoriteMovie(HomePageState state, Action action) {
  return state.clone()..favoriteMovies.add(action.payload as Movie);
}

HomePageState _removeFavoriteMovie(HomePageState state, Action action) {
  if (action.payload == null) return state;

  var newState = state.clone();
  var idx = newState.favoriteMovies.indexWhere((x) => x.imdbId == (action.payload.imdbId));
  if (idx >= 0) newState.favoriteMovies.removeAt(idx);
  return newState;
}

HomePageState _updateFavoriteMovie(HomePageState state, Action action) {
  var newState = state.clone();
  Movie movie = action.payload;
  if ((movie?.imdbId ?? "") != "") {
    var idx = newState.favoriteMovies.indexWhere((x) => x.imdbId == movie.imdbId);
    newState.favoriteMovies[idx] = movie;
  }
  return newState;
}

HomePageState _changeTab(HomePageState state, Action action) {
  return state.clone()..currentTab = action.payload;
}
