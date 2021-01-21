import 'package:fish_redux/fish_redux.dart';
import 'package:movie_app/models/movie.dart';

enum SearchAction { search, updateMovieList, tapMovie }

class SearchActionCreator {
  static Action updateMovieList(List<Movie> movies) {
    return Action(SearchAction.updateMovieList, payload: movies);
  }

  static Action search(String query) {
    return Action(SearchAction.search, payload: query);
  }

  static Action tapMovie(Movie movie) {
    return Action(SearchAction.tapMovie, payload: movie);
  }
}
