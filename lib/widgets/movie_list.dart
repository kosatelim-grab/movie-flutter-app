import 'package:flutter/material.dart';
import 'package:movie_app/screens/movie_detail.dart';
import '../models/star_list.dart';
import '../models/movie.dart';

class MovieListWidget extends StatelessWidget {
  final List<Movie> movies;
  final StarListModel starListModel;

  Widget _starIcon(Movie movie) {
    bool isStar = starListModel?.has(movie.imdbId);
    return IconButton(
      icon: Icon(isStar ? Icons.star : Icons.star_border),
      onPressed: () => isStar
          ? starListModel?.remove(movie.imdbId)
          : starListModel?.add(movie),
    );
  }

  void _onMovieTap(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieDetailPage(movie)),
    );
  }

  Widget _movieTileWidget(BuildContext context, Movie movie) {
    return InkWell(
        key: ValueKey(movie.imdbId),
        onTap: () => _onMovieTap(context, movie),
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            height: 80,
            child: Row(children: [
              Image.network(movie.poster, width: 50),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title ?? "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(movie.type ?? ""),
                          Text(movie.year ?? "")
                        ],
                      ))),
              _starIcon(movie),
            ])));
  }

  MovieListWidget(this.movies, this.starListModel);

  @override
  Widget build(BuildContext context) {
    if (movies == null || movies.length == 0) {
      return Center(child: Text("no result", textAlign: TextAlign.center));
    }

    return ListView(
        children: movies
            .map<Widget>((movie) => _movieTileWidget(context, movie))
            .toList());
  }
}
