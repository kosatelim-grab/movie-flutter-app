import 'package:flutter/material.dart';
import 'package:movie_app/widgets/movie_list.dart';
import 'package:provider/provider.dart';
import '../models/star_list.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Consumer<StarListModel>(
          builder: (context, starList, child) =>
              MovieListWidget(starList.movies, starList)),
    );
  }
}
