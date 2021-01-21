import 'package:fish_redux/fish_redux.dart';
import 'package:movie_app/models/movie.dart';

enum HomePageAction { addFavoriteMovie, removeFavoriteMovie, updateFavoriteMovie, changeTab }

class HomePageActionCreator {
  static Action addFavoriteMovie(Movie movie) {
    return Action(HomePageAction.addFavoriteMovie, payload: movie);
  }

  static Action removeFavoriteMovie(Movie movie) {
    return Action(HomePageAction.removeFavoriteMovie, payload: movie);
  }

  static Action updateFavoriteMovie(Movie movie) {
    return Action(HomePageAction.updateFavoriteMovie, payload: movie);
  }

  static Action changeTab(int tab) {
    return Action(HomePageAction.changeTab, payload: tab);
  }
}
