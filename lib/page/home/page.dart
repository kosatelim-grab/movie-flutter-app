import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

import '../search/view.dart' hide buildView;
import '../favorite/view.dart' hide buildView;
import '../favorite/page.dart';
import '../search/page.dart';

class HomePage extends Page<HomePageState, Map<String, dynamic>> {
  HomePage()
      : super(
          initState: initState,
          // effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<HomePageState>(slots: <String, Dependent<HomePageState>>{
            'search': SearchConnector() + SearchPage(),
            'favorite': FavoriteConnector() + FavoritePage(),
          }),
        );
}
