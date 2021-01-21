// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;

import 'page/movie_detail/page.dart';
import 'page/home/page.dart';

void main() => runApp(createApp());

Widget createApp() {
  final AbstractRoutes routes = PageRoutes(
    pages: <String, Page<Object, dynamic>>{
      'home': HomePage(),
      'movie_detail': MovieDetailPage(),
    },
  );

  return MaterialApp(
    title: 'Movie App',
    theme: ThemeData(
      primaryColor: Colors.red,
    ),
    home: routes.buildPage('home', null),
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute<Object>(builder: (BuildContext context) {
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}