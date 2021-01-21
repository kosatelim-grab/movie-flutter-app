import 'package:fish_redux/fish_redux.dart';
import 'package:movie_app/models/movie.dart';

import 'state.dart';
import 'action.dart';

Reducer<SearchState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchState>>{
      SearchAction.updateMovieList: _updateMovieList,
    },
  );
}

SearchState _updateMovieList(SearchState state, Action action) {
  return state.clone()..movies = action.payload;
}
