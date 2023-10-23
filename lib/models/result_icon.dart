class ResultIcon {
  final String height;
  final String url;
  final String width;

  ResultIcon({
    required this.height,
    required this.url,
    required this.width,
  });

  factory ResultIcon.fromJson(Map<String, dynamic> json) {
    return ResultIcon(
      height: json['Height'],
      url: json['URL'],
      width: json['Width'],
    );
  }
}
