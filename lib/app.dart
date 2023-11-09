import 'package:flutter/material.dart';
import 'package:flutter_code_practical/screens/home.dart';
import 'package:flutter_code_practical/view_models/character_view_model.dart';
import 'package:flutter_code_practical/view_models/character_info_view_model.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  final String flavor;
  final Uri charAPI;
  final String imgPrefix;

  const MyApp(
      {Key? key,
      required this.flavor,
      required this.charAPI,
      required this.imgPrefix})
      : super(key: key);

  ThemeData _themeData() {
    final ThemeData simpsonsTheme = ThemeData(
      primarySwatch: Colors.cyan,
      textTheme: GoogleFonts.robotoTextTheme(),
    );

    final ThemeData theWireTheme = ThemeData(
      primarySwatch: Colors.grey,
      hintColor: Colors.black,
      textTheme: GoogleFonts.robotoCondensedTextTheme().apply(
        decorationColor: Colors.white,
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      brightness: Brightness.dark,
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.white),
      ),
    );

    if (flavor == "Simpsons") {
      return simpsonsTheme;
    } else if (flavor == "The Wire") {
      return theWireTheme;
    } else {
      return ThemeData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CharacterViewModel(charAPI),
        ),
        ChangeNotifierProvider<CharacterInfoViewModel>(
          create: (context) => CharacterInfoViewModel.empty(),
        ),
      ],
      child: MaterialApp(
        title: 'Character Viewer',
        debugShowCheckedModeBanner: false,
        theme: _themeData(),
        home: HomeScreen(title: flavor),
      ),
    );
  }
}
