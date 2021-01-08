import 'package:flutter/material.dart';
import 'package:movie_app/widgets/movie_list.dart';
import 'package:provider/provider.dart';
import '../models/favorite_list.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Consumer<FavoriteListModel>(
          builder: (context, favoriteList, child) =>
              MovieListWidget(favoriteList.movies, favoriteList, showStar: true)),
    );
  }
}
