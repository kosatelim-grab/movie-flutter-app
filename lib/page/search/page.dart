import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'effect.dart';
import 'state.dart';
import 'view.dart';

class SearchPage extends Page<SearchState, SearchState> {
  SearchPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
        );
}
