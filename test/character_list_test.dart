import 'package:flutter/material.dart';
import 'package:flutter_code_practical/models/character.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_code_practical/widgets/character_list.dart';
import 'package:flutter_code_practical/view_models/character_view_model.dart';
import 'package:provider/provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'character_list_test.mocks.dart'; // Import the generated file

@GenerateMocks([CharacterViewModel])
void main() {
  group('CharacterList Widget Tests', () {
    late CharacterViewModel characterViewModel;

    setUp(() {
      characterViewModel = MockCharacterViewModel();
      when(characterViewModel.isLoading).thenReturn(true);
      when(characterViewModel.filteredCharacters)
          .thenReturn([Character(name: 'Iron Man', detailsApi: 'yes')]);
    });

    testWidgets('Shows CircularProgressIndicator when loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<CharacterViewModel>(
          create: (context) => characterViewModel,
          child: MaterialApp(
            home: Scaffold(
              body: CharacterList(onSelectCharacter: (_) {}),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Displays "No characters found." when list is empty',
        (WidgetTester tester) async {
      when(characterViewModel.isLoading).thenReturn(false);
      when(characterViewModel.filteredCharacters).thenReturn([]);

      await tester.pumpWidget(
        ChangeNotifierProvider<CharacterViewModel>(
          create: (context) => characterViewModel,
          child: MaterialApp(
            home: Scaffold(
              body: CharacterList(onSelectCharacter: (_) {}),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('No characters found.'), findsOneWidget);
    });

    testWidgets('Search field functionality', (WidgetTester tester) async {
      when(characterViewModel.isLoading).thenReturn(false);

      await tester.pumpWidget(
        ChangeNotifierProvider<CharacterViewModel>(
          create: (context) => characterViewModel,
          child: MaterialApp(
            home: Scaffold(
              body: CharacterList(onSelectCharacter: (_) {}),
            ),
          ),
        ),
      );

      const String searchText = "Iron";
      await tester.enterText(find.byType(TextField), searchText);
      await tester.pumpAndSettle();
      verify(characterViewModel.search(searchText)).called(1);
    });
  });
}
