import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../common/const.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  MovieDetailPage(this.movie);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState(movie);
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  Movie movie;
  bool isFinishLoading = false;

  _MovieDetailPageState(this.movie) {
    _loadDetail(movie.imdbId);
  }

  void _showAlert(String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  void _loadDetail(String imdbId) {
    var uri = Uri.http(
        apiWebsite, '', {'i': imdbId, 'plot': 'full', 'apikey': apiToken});
    http.get(uri.toString()).then((resp) {
      if (resp.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(resp.body);
        try {
          setState(() {
            movie = Movie.fromJson(data);
            isFinishLoading = true;
          });
        } catch (e, s) {
          print(e);
          print(s);
          _showAlert("Data is corrupted.");
        }
      } else {
        _showAlert("Load data unsuccessfully.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
        ),
        body: Container(
            margin: EdgeInsets.all(16),
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
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isFinishLoading) Text("Loading..."),
                            if (isFinishLoading) ...rightSide,
                          ],
                        ))),
              ],
            )));
  }
}
