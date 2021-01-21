import 'dart:convert';

import 'package:flutter/material.dart' hide Action, Page;
import 'package:fish_redux/fish_redux.dart';
import 'package:http/http.dart' as http;

import 'action.dart';
import 'state.dart';
import '../../models/movie.dart';
import '../../common/const.dart';

Effect<MovieDetailState> buildEffect() {
  return combineEffects(<Object, Effect<MovieDetailState>>{
    Lifecycle.initState: _init,
    MovieDetailAction.loadMovie: _loadMovieList,
    MovieDetailAction.back: _back,
  });
}

void _init(Action action, Context<MovieDetailState> ctx) {
  ctx.dispatch(MovieDetailActionCreator.loadMovieList(ctx.state.movie?.imdbId));
}

void _showAlert(Context<MovieDetailState> ctx, String text) {
  Scaffold.of(ctx.context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}

void _loadMovieList(Action action, Context<MovieDetailState> ctx) async {
  String imdbId = action.payload;
  if (imdbId == "") return;

  var uri = Uri.http(apiWebsite, '', {'i': imdbId, 'plot': 'full', 'apikey': apiToken});

  http.Response resp = await http.get(uri.toString());
  if (resp.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(resp.body);
    try {
      ctx.dispatch(MovieDetailActionCreator.updateMovieDetail(Movie.fromJson(data)));
    } catch (e, s) {
      print(e);
      print(s);
      _showAlert(ctx, "Data is corrupted.");
    }
  } else {
    _showAlert(ctx, "Load data unsuccessfully.");
  }
}

void _back(Action action, Context<MovieDetailState> ctx) {
  Navigator.of(ctx.context).pop<MovieDetailState>(ctx.state.clone());
}
