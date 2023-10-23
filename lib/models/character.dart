class Character {
  final String name;
  final String detailsApi;

  Character(
      {required this.name, required this.detailsApi}); // And other properties

  factory Character.fromJson(Map<String, dynamic> json, {required}) {
    return Character(name: json['name'], detailsApi: json['detailsApi']);
  }
}
