import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';
import 'effect.dart';

class FavoritePage extends Page<FavoriteState, Map<String, dynamic>> {
  FavoritePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          view: buildView,
        );
}
