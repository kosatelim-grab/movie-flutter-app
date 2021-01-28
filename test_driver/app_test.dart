import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Movie App/', () {
    final searchBarFinder = find.byValueKey('search_bar');
    final searchButtonFinder = find.byValueKey('search_button');
    final movieListFinder = find.byValueKey('movie_list');
    final favoriteIcon = find.byValueKey('favorite_icon');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('search movie', () async {
      await driver.waitFor(searchBarFinder);
      await driver.tap(searchBarFinder);
      await driver.enterText('batman');
      await driver.waitFor(find.text('batman'));
      await driver.tap(searchButtonFinder);
      await driver.waitFor(movieListFinder);
    });

    test('favorite movie', () async {
      for (var i = 0; i < 5; i++) {
        await driver.tap(
            find.descendant(of: find.byValueKey('movie_tile_$i'), matching: favoriteIcon, firstMatchOnly: true)
        );
      }
      await driver.tap(find.text('Favorite'));
      await driver.waitFor(movieListFinder);
    });

    test('show movie detail', () async {
      await driver.tap(find.byValueKey('movie_tile_0'));
      await driver.waitForAbsent(find.text('Loading...'));
      await driver.tap(find.byType('BackButton'));
    });

    test('rate movie', () async {
      for (var i = 0; i < 5; i++) {
        await driver.tap(find.byValueKey('movie_tile_$i'));
        await driver.tap(find.byValueKey('star_${i+1}'));
        await driver.tap(find.byType('BackButton'));
        await driver.waitFor(find.text('${i+1}'));
      }
    });

    test('remove favorite movie', () async {
      // TODO: mistake 1
      for (var i = 4; i >= 0; i--) {
        await driver.tap(
            find.descendant(of: find.byValueKey('movie_tile_$i'), matching: favoriteIcon, firstMatchOnly: true)
        );
      }
      await driver.waitForAbsent(movieListFinder);
    });
  });
}