import 'package:flutter/material.dart';
import 'package:flutter_code_practical/widgets/character_list.dart';
import 'package:flutter_code_practical/widgets/character_info.dart'; // Don't forget to import CharacterInfo

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

  // Helper method to determine if the screen width is that of a tablet.
  bool isTabletWidth(BuildContext context) {
    // 600dp is a common breakpoint for a typical tablet width screen.
    const tabletBreakpoint = 600;
    // MediaQuery.of(context) will provide the screen size
    double deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth > tabletBreakpoint;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: OrientationBuilder(
        builder: (context, orientation) {
          // Check for landscape orientation or tablet width.
          bool isTabletOrLandscape =
              orientation == Orientation.landscape || isTabletWidth(context);

          if (isTabletOrLandscape) {
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
