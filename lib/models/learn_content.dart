import 'package:learn_app/models/tag.dart';

List<LearnContent> documentsFromJson(var data) => (data as List).map((e) => LearnContent.fromJson(e)).toList();
class LearnContent {
  String createdAt;
  String type;
  String title;
  String description;
  String thumbnailUrl;
  String contentUrl;
  Tag tag;
  bool save;
  
  LearnContent({
    required this.createdAt, 
    required this.type,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.contentUrl,
    required this.tag,
    required this.save,
  });

  factory LearnContent.fromJson(Map<String, dynamic> json) {
    return LearnContent(
      createdAt: json['created_at'],
      type: json['type'],
      title: json['title'],
      description: json['description'],
      thumbnailUrl: json['thumbnail_url'],
      contentUrl: json['content_url'],
      tag: Tag.fromJson(json['tags'][0]),
      save: false
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['type'] = type;
    data['title'] = title;
    data['description'] = description;
    data['thumbnail_url'] = thumbnailUrl;
    data['content_url'] = contentUrl;
    data['tags'] = tag;
    return data;
  }
}