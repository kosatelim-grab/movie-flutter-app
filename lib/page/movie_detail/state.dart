import 'package:fish_redux/fish_redux.dart';
import 'package:movie_app/page/home/state.dart';

import '../../models/movie.dart';

class MovieDetailState implements Cloneable<MovieDetailState> {
  Movie movie;
  bool isFinishLoading;
  bool canStar;

  @override
  MovieDetailState clone() {
    return MovieDetailState()
      ..movie = movie
      ..isFinishLoading = isFinishLoading
      ..canStar = canStar;
  }
}

MovieDetailState initState(Map<String, dynamic> args) {
  return MovieDetailState()
    ..movie = args['movie']
    ..canStar = args['canStar'] ?? false
    ..isFinishLoading = false;
}
