import 'package:flutter/foundation.dart';
import 'package:flutter_code_practical/models/character.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CharacterViewModel extends ChangeNotifier {
  final Uri charAPI;
  List<Character> _characters = [];
  List<Character> _filteredCharacters = [];
  Character? _selectedCharacter;
  String errorMsg = '';
  bool _isLoading = false;

  CharacterViewModel(this.charAPI) {
    fetchCharacters();
  }

  List<Character> get characters => _characters;
  List<Character> get filteredCharacters => _filteredCharacters;
  Character? get selectedCharacter => _selectedCharacter;
  bool get isLoading => _isLoading;

  Future<void> fetchCharacters() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(charAPI);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['RelatedTopics'] != null) {
          _characters = (jsonResponse['RelatedTopics'] as List)
              .map((character) => Character.fromJson({
                    'name': character['Text']?.split(' - ')[0],
                    'detailsApi': Uri.encodeFull(
                      character['FirstURL']
                              ?.replaceFirst('https://', 'https://api.') +
                          '&format=json',
                    )
                  }))
              .toList();

          _filteredCharacters = [..._characters];
        } else {
          errorMsg = 'Unexpected response format.';
        }
      } else {
        errorMsg = 'There was an error with the server response.';
      }
    } catch (e) {
      errorMsg = 'Error fetching character list.';

      if (kDebugMode) {
        print(e);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to filter characters based on search query
  void search(String searchText) {
    _filteredCharacters = _characters
        .where((character) =>
            character.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    notifyListeners();
  }

  // Method to update the currently selected character
  void updateSelectedCharacter(Character character) {
    _selectedCharacter = character;
    notifyListeners();
  }
}
