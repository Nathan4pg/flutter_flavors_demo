import 'package:flutter/material.dart';
import 'package:flutter_code_practical/view_models/character_info_view_model.dart';
import 'package:flutter_code_practical/widgets/character_image.dart';
import 'package:provider/provider.dart';

class CharacterInfo extends StatefulWidget {
  final String detailsAPI;

  const CharacterInfo({Key? key, required this.detailsAPI}) : super(key: key);

  @override
  CharacterInfoState createState() => CharacterInfoState();
}

class CharacterInfoState extends State<CharacterInfo> {
  bool _isLoading = true;

  @override
  void didUpdateWidget(covariant CharacterInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.detailsAPI != oldWidget.detailsAPI) {
      _fetchCharacterData();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCharacterData();
  }

  void _fetchCharacterData() {
    setState(() => _isLoading = true);
    Provider.of<CharacterInfoViewModel>(context, listen: false)
        .fetchCharacterInfo(widget.detailsAPI)
        .then((_) => setState(() => _isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          appBar: orientation == Orientation.portrait
              ? AppBar(
                  title: const Text('Character Info'),
                )
              : null,
          // No AppBar in landscape mode
          body: Consumer<CharacterInfoViewModel>(
            builder: (context, viewModel, child) {
              if (_isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (viewModel.name == '') {
                return const Center(
                  child: Text(
                    'Please select a character from the list to the left.',
                    style: TextStyle(fontSize: 20), // Style as needed
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                  child: widget.detailsAPI == ''
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  viewModel.name,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  viewModel.shortDescription,
                                  style: Theme.of(context).textTheme.titleSmall,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 24),
                                LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    // Calculate the width to use
                                    double imgWidth = constraints.maxWidth < 400
                                        ? constraints.maxWidth
                                        : 400;

                                    return Center(
                                        child: CharacterImage(
                                      imageUrl: viewModel.imageUrl,
                                      imgWidth: imgWidth,
                                    ));
                                  },
                                ),
                                const SizedBox(height: 32),
                                Text(
                                  'Description',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: 24),
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 400),
                                  child: Text(viewModel.description),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
