import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:movie_app/screens/movie_detail.dart';
import '../models/favorite_list.dart';
import '../models/movie.dart';

class MovieTileWidget extends StatelessWidget {
  final Movie movie;
  final FavoriteListModel favoriteListModel;
  final void Function() onTap;
  final bool showStar;

  MovieTileWidget(this.movie,
      {this.favoriteListModel, this.onTap, this.showStar});

  Widget _favoriteIcon() {
    bool isFavorite = favoriteListModel?.has(movie.imdbId) ?? false;
    return IconButton(
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red.shade600),
      onPressed: () => isFavorite
          ? favoriteListModel?.remove(movie.imdbId)
          : favoriteListModel?.add(movie),
    );
  }

  Widget _starIcon() {
    if ((movie.star ?? 0) == 0) {
      return Row();
    }
    return Row(children: [
      Text(movie.star.toString(), style: TextStyle(color: Colors.yellow.shade800)),
      Icon(
        Icons.star,
        color: Colors.yellow.shade800,
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        key: ValueKey(movie.imdbId),
        onTap: onTap,
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
              if (showStar) _starIcon(),
              _favoriteIcon(),
            ])));
  }
}

class MovieListWidget extends StatelessWidget {
  final List<Movie> movies;
  final FavoriteListModel favoriteListModel;
  final bool showStar;

  void _onMovieTap(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieDetailPage(movie)),
    );
  }

  MovieListWidget(this.movies, this.favoriteListModel, {this.showStar = false});

  @override
  Widget build(BuildContext context) {
    if (movies == null || movies.length == 0) {
      return Center(child: Text("no result", textAlign: TextAlign.center));
    }

    return ListView(
        children: movies
            .map<Widget>((movie) => MovieTileWidget(movie,
                favoriteListModel: favoriteListModel,
                onTap: () => _onMovieTap(context, movie),
                showStar: showStar))
            .toList());
  }
}
