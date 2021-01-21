import 'package:fish_redux/fish_redux.dart';
import 'package:movie_app/models/movie.dart';

enum MovieDetailAction { updateMovieDetail, loadMovie, giveStar, back }

class MovieDetailActionCreator {
  static Action updateMovieDetail(Movie movie) {
    return Action(MovieDetailAction.updateMovieDetail, payload: movie);
  }

  static Action loadMovieList(String imbdbId) {
    return Action(MovieDetailAction.loadMovie, payload: imbdbId);
  }

  static Action giveStar(int star) {
    return Action(MovieDetailAction.giveStar, payload: star);
  }

  static Action back() {
    return Action(MovieDetailAction.back);
  }
}
