import 'package:fish_redux/fish_redux.dart';

import '../../models/movie.dart';

class FavoriteState implements Cloneable<FavoriteState> {
  List<Movie> favoriteMovies;

  @override
  FavoriteState clone() {
    return FavoriteState();
  }
}

FavoriteState initState(dynamic args) {
  return FavoriteState();
}
