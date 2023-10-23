import 'package:flutter/material.dart';
import 'package:flutter_code_practical/widgets/character_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:flutter_code_practical/view_models/character_info_view_model.dart';
import 'package:flutter_code_practical/widgets/character_info.dart';

import 'character_info_test.mocks.dart'; // Use the actual generated file name

@GenerateMocks([CharacterInfoViewModel])
void main() {
  group('CharacterInfo Widget Tests', () {
    late MockCharacterInfoViewModel mockViewModel;

    setUp(() {
      mockViewModel = MockCharacterInfoViewModel();
    });

    Future<void> buildCharacterInfoWidget(WidgetTester tester) async {
      when(mockViewModel.name).thenReturn('');

      await tester.pumpWidget(
        ChangeNotifierProvider<CharacterInfoViewModel>(
          create: (_) => mockViewModel,
          child: const MaterialApp(
            home: CharacterInfo(detailsAPI: 'mock_api_endpoint'),
          ),
        ),
      );
    }

    testWidgets('Initial loading state UI', (WidgetTester tester) async {
      await buildCharacterInfoWidget(tester);

      // Verify if CircularProgressIndicator is shown initially
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('UI after data is loaded', (WidgetTester tester) async {
      await buildCharacterInfoWidget(tester);

      when(mockViewModel.name).thenReturn('Character Name');
      when(mockViewModel.shortDescription).thenReturn('Short Description');
      when(mockViewModel.imageUrl).thenReturn('image_url');
      when(mockViewModel.description).thenReturn('Full Description');

      await tester.pumpAndSettle();

      expect(find.text('Character Name'), findsOneWidget);
      expect(find.text('Short Description'), findsOneWidget);
      expect(find.text('Full Description'), findsOneWidget);
      expect(
          find.byType(CharacterImage), findsOneWidget); // Corrected this line
    });

    // ... additional tests
  });
}
