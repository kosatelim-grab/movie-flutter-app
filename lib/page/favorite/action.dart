import 'package:fish_redux/fish_redux.dart';
import 'package:movie_app/models/movie.dart';

enum FavoriteAction { tapMovie }

class FavoriteActionCreator {
  static Action tapMovie(Movie movie) {
    return Action(FavoriteAction.tapMovie, payload: movie);
  }
}
