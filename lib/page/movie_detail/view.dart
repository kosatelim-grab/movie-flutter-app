import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';
import '../../models/movie.dart';

Widget buildView(MovieDetailState state, Dispatch dispatch, ViewService viewService) {
  Movie movie = state.movie;
  bool isFinishLoading = state.isFinishLoading;

  List<Widget> leftSide = [
    Padding(padding: EdgeInsets.symmetric(vertical: 4)),
    Text("${movie.genre}"),
    Padding(padding: EdgeInsets.symmetric(vertical: 2)),
    Text("Released: ${movie.released}"),
    Text("Runtime: ${movie.runtime}"),
  ];

  List<Widget> rightSide = [
    Text(
      movie.title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    Padding(padding: EdgeInsets.symmetric(vertical: 2)),
    Text("Director: ${movie.director}"),
    Text("Writer: ${movie.writer}"),
    Text("Actors: ${movie.actors}"),
    Padding(padding: EdgeInsets.symmetric(vertical: 4)),
    Text("${movie.plot}"),
  ];

  Function(int) _vote = (int star) {
    String imdbId = movie?.imdbId ?? "";
    if (imdbId == "") return;

    dispatch(MovieDetailActionCreator.giveStar(star));
  };

  Row Function() _voteBar = () {
    List<Widget> star = [];
    for (var i = 1; i <= 5; i++) {
      star.add(IconButton(
          icon: Icon(
              (movie.star ?? 0) >= i ? Icons.star : Icons.star_border,
              key: ValueKey('star_$i'),
              size: 32,
              color: Colors.yellow.shade800),
          onPressed: () => _vote(i)));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: star,
    );
  };

  return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        leading: BackButton(
          // TODO: mistake 4
            onPressed: () => dispatch(MovieDetailActionCreator.back())
        ),
      ),
      body: Container(
          margin: EdgeInsets.all(16),
          child: Column(children: [
            Expanded(
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(movie.poster,
                                    key: ValueKey(movie.poster)),
                                if (isFinishLoading) ...leftSide,
                              ]),
                        )),
                    Expanded(
                        flex: 3,
                        child: Container(
                            alignment: Alignment.topCenter,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (!isFinishLoading) Text("Loading..."),
                                    if (isFinishLoading) ...rightSide,
                                  ],
                                )))),
                  ],
                )),
            if (state.canStar) _voteBar(),
          ])));
}