import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CharacterInfoViewModel with ChangeNotifier {
  String name;
  String description;
  String shortDescription;
  String imageUrl;
  String errorMsg = '';

  CharacterInfoViewModel({
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.imageUrl,
  });

  CharacterInfoViewModel.empty()
      : name = '',
        description = '',
        shortDescription = '',
        imageUrl = '';

  void updateFromJson(Map<String, dynamic> json) {
    name = json['Heading'] as String;
    description = json['AbstractText'] as String;
    shortDescription = json['Entity'] as String;
    imageUrl =
        Uri.encodeFull("https://duckduckgo.com${(json['Image'] as String)}");
    notifyListeners();
  }

  factory CharacterInfoViewModel.fromJson(Map<String, dynamic> json) {
    return CharacterInfoViewModel(
      name: json['Heading'] as String,
      description: json['AbstractText'] as String,
      shortDescription: json['Entity'] as String,
      imageUrl:
          Uri.encodeFull("https://duckduckgo.com${(json['Image'] as String)}"),
    );
  }

  Future<void> fetchCharacterInfo(charInfoAPI) async {
    try {
      final response = await http.get(Uri.parse(charInfoAPI));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse != null) {
          updateFromJson(jsonResponse);
        } else {
          errorMsg = 'Unexpected response format.';
        }
        notifyListeners();
      } else {
        errorMsg = 'There was an error with the server response.';
        notifyListeners();
      }
    } catch (e) {
      errorMsg = 'Error fetching character list.';

      if (kDebugMode) {
        print(e);
      }

      notifyListeners();
    }
  }
}
