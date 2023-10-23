import 'package:flutter/material.dart';
import 'package:flutter_code_practical/models/character.dart';
import 'package:flutter_code_practical/view_models/character_view_model.dart';
import 'package:flutter_code_practical/view_models/character_info_view_model.dart';
import 'package:flutter_code_practical/widgets/character_info.dart';
import 'package:provider/provider.dart';

class CharacterList extends StatefulWidget {
  final ValueChanged<String?>
      onSelectCharacter; // Callback function to handle character selection

  const CharacterList({Key? key, required this.onSelectCharacter})
      : super(key: key);

  @override
  CharacterListState createState() => CharacterListState();
}

class CharacterListState extends State<CharacterList> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleCharacterTap(BuildContext context, String detailsAPI,
      CharacterViewModel viewModel, Character character) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    if (isLandscape || isTablet) {
      // If in landscape mode, use the callback to inform the parent widget
      viewModel.updateSelectedCharacter(character);
      widget.onSelectCharacter(detailsAPI);
    } else {
      // If not, navigate to the character info page as before
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<CharacterInfoViewModel>(
            create: (context) => CharacterInfoViewModel.empty(),
            child: CharacterInfo(detailsAPI: detailsAPI),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterViewModel>(builder: (context, viewModel, child) {
      if (viewModel.isLoading) {
        // If the view model indicates that we're loading data, show a loading indicator
        return const Center(child: CircularProgressIndicator());
      } else if (viewModel.filteredCharacters.isEmpty) {
        // Optionally handle the case where there are no characters
        return const Center(child: Text('No characters found.'));
      } else {
        // Otherwise, display the list of characters
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _textController,
                onChanged: (value) {
                  setState(() {});
                  viewModel.search(value);
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  suffixIcon: _textController.text.isEmpty
                      ? const Icon(Icons.search)
                      : IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _textController.clear();
                            setState(() {});
                            viewModel.search(_textController.text);
                          },
                        ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.filteredCharacters.length,
                itemBuilder: (context, index) {
                  final character = viewModel.filteredCharacters[index];
                  return ListTile(
                    title: Text(character.name),
                    onTap: () => _handleCharacterTap(
                        context, character.detailsApi, viewModel, character),
                    tileColor: viewModel.selectedCharacter?.name ==
                            character.name
                        ? Theme.of(context).colorScheme.secondary.withOpacity(
                            0.3) // for example, blue with some transparency
                        : null, // default color
                  );
                },
              ),
            ),
          ],
        );
      }
    });
  }
}
