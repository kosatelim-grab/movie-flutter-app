import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie_app/page/home/action.dart';

import 'action.dart';
import 'state.dart';
import '../home/state.dart';
import '../home/action.dart';
import '../../widgets/movie_list.dart';
import '../../models/movie.dart';

Widget buildView(SearchState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: TextField(
            key: ValueKey("search_bar"),
            onChanged: (query) => dispatch(SearchActionCreator.updateQuery(query)),
            onSubmitted: (query) => dispatch(SearchActionCreator.search(query)),
            decoration: InputDecoration(
              icon: IconButton(
                key: ValueKey("search_button"),
                icon: Icon(Icons.search),
                onPressed: () => dispatch(SearchActionCreator.search(state.query)),
              ),
              hintText: 'Search movie name',
              border: InputBorder.none,
            )),
      ),
      Expanded(
        child: MovieListWidget(
          state.movies,
          state.favoriteMovies,
          onMovieTap: (movie) => dispatch(SearchActionCreator.tapMovie(movie)),
          onStar: (movie) => dispatch(HomePageActionCreator.addFavoriteMovie(movie)),
          onRemoveStar: (movie) => dispatch(HomePageActionCreator.removeFavoriteMovie(movie)),
        ),
      )
    ],
  );
}

class SearchConnector extends ConnOp<HomePageState, SearchState> {
  @override
  SearchState get(HomePageState state) {
    // TODO: mistake 2
    // SearchState subState = SearchState();

    // TODO: mistake 3
    SearchState subState = state.searchState.clone();
    subState.favoriteMovies = state.favoriteMovies;
    return subState;
  }

  @override
  void set(HomePageState state, SearchState subState) {
    state.searchState = subState;
  }
}
