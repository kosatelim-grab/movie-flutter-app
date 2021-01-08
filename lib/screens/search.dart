import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/widgets/movie_list.dart';
import 'package:provider/provider.dart';
import '../common/const.dart';
import '../models/movie_list.dart';
import '../models/favorite_list.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  void _showAlert(String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  void _search(String query) async {
    if (query.length < 3) {
      _showAlert("Title is too short.");
      return;
    }

    var uri = Uri.http(apiWebsite, '', {'s': query, 'apikey': apiToken});
    http.Response resp = await http.get(uri.toString());
    if (resp.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(resp.body);
      if (data['Search'] == null || data['Search'] == "") {
        _showAlert("No Result.");
      } else {
        try {
          Provider.of<MovieListModel>(context, listen: false)
              .loadJson(data['Search']);
        } catch (e, s) {
          print(e);
          print(s);
          _showAlert("Data is corrupted.");
        }
      }
    } else {
      _showAlert("Load data unsuccessfully.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: TextField(
              onSubmitted: _search,
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                hintText: 'Search movie name',
                border: InputBorder.none,
              )),
        ),
        Expanded(
            child: Consumer2<MovieListModel, FavoriteListModel>(
                builder: (context, movieList, favoriteList, child) =>
                    MovieListWidget(movieList.movies, favoriteList))),
      ],
    );
  }
}
