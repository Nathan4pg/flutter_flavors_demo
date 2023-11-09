import 'package:flutter/material.dart';
import 'package:flutter_code_practical/view_models/character_info_view_model.dart';
import 'package:flutter_code_practical/widgets/character_image.dart';
import 'package:flutter_code_practical/widgets/loading_skeleton.dart';
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
    const double setMaxWidth = 400;
    List<Map<String, dynamic>> loadingItems = [
      // character name
      {
        'type': 'square',
        'width': setMaxWidth,
        'height': 40,
        'margin': [0, 8, 0, 16]
      },
      // character image
      {
        'type': 'square',
        'width': setMaxWidth,
        'height': setMaxWidth,
        'margin': [0, 0, 0, 24]
      },
      // description
      {
        'type': 'square',
        'width': setMaxWidth,
        'height': 300,
        'margin': [0, 0, 0, 40]
      }
    ];

    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          appBar: MediaQuery.of(context).size.shortestSide < 600
              ? AppBar(
                  title: const Text('Character Info'),
                )
              : null,
          body: Consumer<CharacterInfoViewModel>(
            builder: (context, viewModel, child) {
              if (_isLoading) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                    child: Center(child: LoadingSkeleton(items: loadingItems)),
                  ),
                );
              } else if (viewModel.name == '') {
                return const Center(
                  child: Text(
                    'Please select a character from the list to the left.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return SingleChildScrollView(
                child: widget.detailsAPI == ''
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Center(
                        child: ConstrainedBox(
                          constraints:
                              const BoxConstraints(maxWidth: setMaxWidth),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  viewModel.name,
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    // Calculate the width to use
                                    double imgWidth =
                                        constraints.maxWidth < setMaxWidth
                                            ? constraints.maxWidth
                                            : setMaxWidth;

                                    return Center(
                                        child: CharacterImage(
                                      imageUrl: viewModel.imageUrl,
                                      imgWidth: imgWidth,
                                      defaultHeight: setMaxWidth,
                                    ));
                                  },
                                ),
                                const SizedBox(height: 24),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxWidth: setMaxWidth),
                                  child: Text(
                                    viewModel.description,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                const SizedBox(height: 40),
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
