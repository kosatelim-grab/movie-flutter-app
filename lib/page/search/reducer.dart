import 'package:fish_redux/fish_redux.dart';
import 'package:movie_app/models/movie.dart';

import 'state.dart';
import 'action.dart';

Reducer<SearchState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchState>>{
      SearchAction.updateMovieList: _updateMovieList,
      SearchAction.updateQuery: _updateQuery,
    },
  );
}

SearchState _updateMovieList(SearchState state, Action action) {
  return state.clone()..movies = action.payload;
}

SearchState _updateQuery(SearchState state, Action action) {
  return state.clone()..query = action.payload;
}
