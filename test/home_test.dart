// Import the relevant packages
import 'package:flutter/material.dart';
import 'package:flutter_code_practical/global.dart';
import 'package:flutter_code_practical/screens/home.dart';
import 'package:flutter_code_practical/view_models/character_info_view_model.dart';
import 'package:flutter_code_practical/view_models/character_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('HomeScreen', () {
    final characterViewModel = CharacterViewModel(Global.simpsonsAPI);
    final characterInfoViewModel = CharacterInfoViewModel.empty();

    Widget makeTestableWidget({required Widget child}) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<CharacterViewModel>.value(
              value: characterViewModel),
          ChangeNotifierProvider<CharacterInfoViewModel>.value(
              value: characterInfoViewModel),
        ],
        child: MaterialApp(home: child),
      );
    }

    // Test 1: Ensure everything is created as expected
    testWidgets('Renders correctly in both portrait and landscape',
        (WidgetTester tester) async {
      const String testTitle = 'Test Home';

      await tester.pumpWidget(makeTestableWidget(
          child: const MaterialApp(home: HomeScreen(title: testTitle))));

      // AppBar widget with the testTitle title.
      expect(find.widgetWithText(AppBar, testTitle), findsOneWidget);

      await tester.binding.setSurfaceSize(const Size(1200, 800)); // landscape
      await tester.pump();

      // In landscape mode, Row exists
      expect(find.byType(Row), findsOneWidget);

      await tester.binding.setSurfaceSize(null);
    });

    // Test 2: Test the handleCharacterSelection function
    testWidgets('handleCharacterSelection updates the state',
        (WidgetTester tester) async {
      // Initialize the HomeScreen
      const homeScreen = HomeScreen(title: 'Simpsons');
      await tester.pumpWidget(
          makeTestableWidget(child: const MaterialApp(home: homeScreen)));

      // Access state
      final homeScreenState =
          tester.state(find.byWidget(homeScreen)) as HomeScreenState;

      print('home screen state: $homeScreenState');

      // Call handleCharacterSelection and pass a sample API
      homeScreenState.handleCharacterSelection("test_api");

      // Rebuild the widget after the state change.
      await tester.pump();

      // Expect the selectedCharacterDetailsApi to be updated
      expect(homeScreenState.selectedCharacterDetailsApi, "test_api");
    });

    // You can add more tests below for different functionalities.
  });
}
