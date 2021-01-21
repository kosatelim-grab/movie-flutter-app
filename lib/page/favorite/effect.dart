
import 'package:flutter/material.dart' hide Action, Page;
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';
import '../home/action.dart';

Effect<FavoriteState> buildEffect() {
  return combineEffects(<Object, Effect<FavoriteState>>{
    FavoriteAction.tapMovie: _tapMovie,
  });
}

void _tapMovie(Action action, Context<FavoriteState> ctx) {
  Navigator.of(ctx.context)
      .pushNamed('movie_detail', arguments: {'movie': action.payload, 'canStar': true})
      .then((dynamic movieDetailState) {
        if (movieDetailState != null) {
          ctx.dispatch(HomePageActionCreator.updateFavoriteMovie(movieDetailState.movie));
        }
  });
}