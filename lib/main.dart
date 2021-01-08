// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_list.dart';
import 'package:provider/provider.dart';

import 'models/star_list.dart';
import './models/movie_list.dart';
import './screens/home.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<StarListModel>(create: (context) => StarListModel()),
          ChangeNotifierProvider<MovieListModel>(create: (context) => MovieListModel()),
        ],
        child: App(),
      ),
    );

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: HomePage(),
    );
  }
}