import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:music_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Music App', () {
    testWidgets('Integration testing flows , verify Music App', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.text('No Albums added yet'), findsOneWidget);

      expect(find.byIcon(Icons.search), findsOneWidget);

      // Finds the Search button to tap on.
      final Finder search = find.byIcon(Icons.search);

      // Emulate a tap on the Search button.
      await tester.tap(search);

      // Trigger a frame.
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Verify the search field is clickable
      expect(find.text('Search for albums'), findsOneWidget);

      final searchView = find.byKey(const Key('Search Field'));

      await tester.enterText(searchView, "Akon");

      await tester.pumpAndSettle(const Duration(seconds: 5));

      final Finder search2 = find.byKey(const Key('Search Button'));

      await tester.tap(search2);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      //Verify the first item and check it's clickable in the gridview.
      final akonitem = find.byKey(const Key('0'));

      await tester.tap(akonitem);

      await tester.pumpAndSettle(const Duration(seconds: 5));
      //Verify the Album list is displayed and click on the below given album track name.
      final albumText = find.text("Freedom");

      await tester.tap(albumText);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      final listFinder = find.byType(Scrollable);

      final itemFinder = find.text('13-Freedom');

      // Scroll until the item to be found appears.
      await tester.scrollUntilVisible(
        itemFinder,
        500.0,
        scrollable: listFinder,
      );

      // Verify that the item contains the correct text.
      expect(itemFinder, findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      final back = find.byIcon(Icons.arrow_back);

      await tester.tap(back);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      //Verify that the album can be added into the favourite section

      final fav1 = find.byKey(const Key("Freedom"));

      await tester.tap(fav1);

      await tester.pumpAndSettle(const Duration(seconds: 10));

      final fav2 = find.byKey(const Key("Trouble"));
      await tester.tap(fav2);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      final fav3 = find.byKey(const Key("Angel"));
      await tester.tap(fav3);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      final back2 = find.byIcon(Icons.arrow_back);

      await tester.tap(back2);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      // verify that the back button is clickable and navigates to the home screen

      final back3 = find.byIcon(Icons.arrow_back);

      await tester.tap(back3);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      //Verify that the album can be removed from the favourite section

      final unFav1 = find.byKey(const Key("Freedom"));
      await tester.tap(unFav1);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      final unFav2 = find.byKey(const Key("Trouble"));
      await tester.tap(unFav2);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      final unFav3 = find.byKey(const Key("Angel"));
      await tester.tap(unFav3);

      await tester.pumpAndSettle(const Duration(seconds: 20));
      expect(find.text('No Albums added yet'), findsOneWidget);
    });
  });
}
