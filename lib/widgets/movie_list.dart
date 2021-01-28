import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieTileWidget extends StatelessWidget {
  final Movie movie;
  final List<Movie> favoriteMovies;
  final void Function() onTap;
  final Function(Movie) onStar;
  final Function(Movie) onRemoveStar;
  final bool showStar;

  MovieTileWidget({key, this.movie, this.favoriteMovies, this.onTap, this.showStar, this.onStar, this.onRemoveStar}): super(key: key);

  Widget _favoriteIcon() {
    bool isFavorite = favoriteMovies.indexWhere((x) => x.imdbId == movie.imdbId) > -1;
    return IconButton(
      key: ValueKey('favorite_icon'),
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red.shade600),
      onPressed: () => isFavorite ? onRemoveStar(movie) : onStar(movie),
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
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
  final List<Movie> favoriteListModel;
  final bool showStar;
  final Function(Movie) onMovieTap;
  final Function(Movie) onStar;
  final Function(Movie) onRemoveStar;

  MovieListWidget(this.movies, this.favoriteListModel, {this.onMovieTap, this.showStar = false, this.onStar, this.onRemoveStar});

  @override
  Widget build(BuildContext context) {
    if (movies == null || movies.length == 0) {
      return Center(child: Text("no result", textAlign: TextAlign.center));
    }

    return ListView.builder(
        key: ValueKey("movie_list"),
        itemCount: movies.length,
        itemBuilder: (context, index) => MovieTileWidget(
            key: ValueKey('movie_tile_$index'),
            movie: movies[index],
            favoriteMovies: favoriteListModel,
            onTap: () => onMovieTap(movies[index]),
            showStar: showStar,
            onStar: onStar,
            onRemoveStar: onRemoveStar));
  }
}
