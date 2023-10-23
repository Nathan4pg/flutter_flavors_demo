import 'package:flutter/material.dart';
import 'package:flutter_code_practical/app.dart';
import 'package:flutter_code_practical/global.dart';

void main() {
  runApp(MyApp(
    flavor: 'The Wire',
    charAPI: Global.theWireAPI,
    imgPrefix: Global.imageURLPrefix,
  ));
}
