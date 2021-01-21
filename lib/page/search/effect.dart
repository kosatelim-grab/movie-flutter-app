import 'dart:convert';

import 'package:flutter/material.dart' hide Action, Page;
import 'package:fish_redux/fish_redux.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/page/home/action.dart';
import 'package:movie_app/page/movie_detail/page.dart';

import 'action.dart';
import 'state.dart';
import '../home/action.dart';
import '../../models/movie.dart';
import '../../common/const.dart';

Effect<SearchState> buildEffect() {
  return combineEffects(<Object, Effect<SearchState>>{
    SearchAction.search: _search,
    SearchAction.tapMovie: _tapMovie,
  });
}

void _tapMovie(Action action, Context<SearchState> ctx) {
  Navigator.of(ctx.context)
      .pushNamed('movie_detail', arguments: {'movie': action.payload, 'canStar': false});
}

void _showAlert(Context<SearchState> ctx, String text) {
  Scaffold.of(ctx.context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}

void _search(Action action, Context<SearchState> ctx) async {
  String query = action.payload;

  if (query.length < 3) {
    _showAlert(ctx, "Title is too short.");
    return;
  }

  var uri = Uri.http(apiWebsite, '', {'s': query, 'apikey': apiToken});
  http.Response resp = await http.get(uri.toString());
  if (resp.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(resp.body);
    if (data['Search'] == null || data['Search'] == "") {
      _showAlert(ctx, "No Result.");
    } else {
      try {
        List<Movie> movies = data['Search'].map<Movie>((v) => Movie.fromJson(v)).toList();
        ctx.dispatch(SearchActionCreator.updateMovieList(movies));
      } catch (e, s) {
        print(e);
        print(s);
        _showAlert(ctx, "Data is corrupted.");
      }
    }
  } else {
    _showAlert(ctx, "Load data unsuccessfully.");
  }
}