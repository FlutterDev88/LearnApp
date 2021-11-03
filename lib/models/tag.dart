List<Tag> documentsFromJson(var data) => (data as List).map((e) => Tag.fromJson(e)).toList();

class Tag {
  String name;
  String color;
  
  Tag({required this.name, required this.color});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['color'] = color;
    return data;
  }
}