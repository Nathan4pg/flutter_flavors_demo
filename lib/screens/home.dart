import 'package:flutter/material.dart';
import 'package:flutter_code_practical/widgets/character_list.dart';
import 'package:flutter_code_practical/widgets/character_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String? selectedCharacterDetailsApi;

  void handleCharacterSelection(String? detailsApi) {
    setState(() {
      selectedCharacterDetailsApi = detailsApi;
    });
  }

  bool isTabletWidth(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.shortestSide;

    return deviceWidth > 600;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (isTabletWidth(context)) {
            return Row(
              children: <Widget>[
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: CharacterList(
                      onSelectCharacter: handleCharacterSelection),
                ),
                const VerticalDivider(
                  color: Colors.grey,
                  width: 1,
                  thickness: 1,
                ),
                Expanded(
                  child: selectedCharacterDetailsApi != null
                      ? CharacterInfo(detailsAPI: selectedCharacterDetailsApi!)
                      : const Center(
                          child: Text(
                            'No character selected',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                ),
              ],
            );
          } else {
            return CharacterList(onSelectCharacter: handleCharacterSelection);
          }
        },
      ),
    );
  }
}
