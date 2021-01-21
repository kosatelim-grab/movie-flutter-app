import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'effect.dart';
import 'state.dart';
import 'view.dart';

class MovieDetailPage extends Page<MovieDetailState, Map<String, dynamic>> {
  MovieDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
        );
}
