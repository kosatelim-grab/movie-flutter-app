import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie_app/page/favorite/action.dart';
import 'package:movie_app/page/home/state.dart';

import 'state.dart';
import 'action.dart';
import '../home/action.dart';
import '../../widgets/movie_list.dart';

Widget buildView(FavoriteState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: MovieListWidget(state.favoriteMovies, state.favoriteMovies,
        showStar: true,
        onMovieTap: (movie) => dispatch(FavoriteActionCreator.tapMovie(movie)),
        onStar: (movie) => dispatch(HomePageActionCreator.addFavoriteMovie(movie)),
        onRemoveStar: (movie) => dispatch(HomePageActionCreator.removeFavoriteMovie(movie))),
  );
}

class FavoriteConnector extends ConnOp<HomePageState, FavoriteState> {
  @override
  FavoriteState get(HomePageState state) {
    return FavoriteState()..favoriteMovies = state.favoriteMovies;
  }

  @override
  void set(HomePageState state, FavoriteState subState) {}
}
