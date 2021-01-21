import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'action.dart';

Reducer<MovieDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<MovieDetailState>>{
      MovieDetailAction.updateMovieDetail: _updateMovieDetail,
      MovieDetailAction.giveStar: _giveStar,
      MovieDetailAction.back: _test,
    },
  );
}

MovieDetailState _updateMovieDetail(MovieDetailState state, Action action) {
  // TODO: mistake 1
  return state.clone()
    ..movie = (action.payload..star = state.movie.star)
    ..isFinishLoading = true;
}

MovieDetailState _giveStar(MovieDetailState state, Action action) {
  if (state?.movie != null) {
    return state.clone()..movie.star = action.payload;
  }
  return state;
}

MovieDetailState _test(MovieDetailState state, Action action) {
  print(action);
  return state;
}
