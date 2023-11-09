import 'package:flutter/material.dart';
import 'package:flutter_code_practical/models/character.dart';
import 'package:flutter_code_practical/view_models/character_view_model.dart';
import 'package:flutter_code_practical/view_models/character_info_view_model.dart';
import 'package:flutter_code_practical/widgets/character_info.dart';
import 'package:flutter_code_practical/widgets/loading_skeleton.dart';
import 'package:provider/provider.dart';

class CharacterList extends StatefulWidget {
  final ValueChanged<String?> onSelectCharacter;

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
    final bool isTablet = MediaQuery.of(context).size.shortestSide > 600;

    if (isTablet) {
      viewModel.updateSelectedCharacter(character);
      widget.onSelectCharacter(detailsAPI);
    } else {
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
      // generate skeleton loading components
      int count = 0;
      List<Map<String, dynamic>> loadingItems = [
        {
          'type': 'square',
          'width': '100%',
          'height': 50,
          'margin': [0, 10, 0, 30]
        }
      ];

      while (count < 10) {
        loadingItems.add({
          'type': 'square',
          'width': '100%',
          'height': 30,
          'margin': [0, 0, 0, 30]
        });
        count++;
      }

      if (viewModel.isLoading) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: LoadingSkeleton(items: loadingItems),
        );
      } else if (viewModel.filteredCharacters.isEmpty) {
        return const Center(child: Text('No characters found.'));
      } else {
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
                    tileColor:
                        viewModel.selectedCharacter?.name == character.name
                            ? Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.3)
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
