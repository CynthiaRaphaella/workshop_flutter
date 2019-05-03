class Item {
  String id;
  String description;
  bool state;

  Item({this.id, this.description, this.state = false});

  Map<String, dynamic> toJson() =>
      {'description': description, 'state': state};

  static Item fromJson(Map<String, dynamic> json) => Item(
      id: json['id'], description: json['description'], state: json['state']);
}
