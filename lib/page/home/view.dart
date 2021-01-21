import 'package:flutter/material.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:movie_app/page/favorite/view.dart';
import '../search/view.dart';
import '../favorite/view.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(HomePageState state, Dispatch dispatch, ViewService viewService) {
  final List<Widget> _child = [
    viewService.buildComponent('search'),
    viewService.buildComponent('favorite'),
  ];

  return Scaffold(
    appBar: AppBar(
      title: Text('Movie App'),
    ),
    body: _child[state.currentTab],
    bottomNavigationBar: BottomNavigationBar(
      onTap: (tab) => dispatch(HomePageActionCreator.changeTab(tab)),
      currentIndex: state.currentTab,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.search),
          title: Text('Search'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.favorite),
          title: Text('Favorite'),
        ),
      ],
    ),
  );
}
