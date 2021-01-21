import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';

class HomePageStore {
  static Store<HomePageState> _favoriteMovieStore;

  static Store<HomePageState> get store => _favoriteMovieStore ??= createStore<HomePageState>(HomePageState(), buildReducer());
}
