import 'package:flutter_code_practical/models/result_icon.dart';

class RelatedTopic {
  final String firstURL;
  final ResultIcon icon;
  final String result;
  final String text;

  RelatedTopic({
    required this.firstURL,
    required this.icon,
    required this.result,
    required this.text,
  });

  factory RelatedTopic.fromJson(Map<String, dynamic> json) {
    return RelatedTopic(
      firstURL: json['FirstURL'],
      icon: ResultIcon.fromJson(json['Icon']),
      result: json['Result'],
      text: json['Text'],
    );
  }
}
