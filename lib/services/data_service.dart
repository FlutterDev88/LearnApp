import 'dart:async';
import 'dart:convert';

import 'package:learn_app/configs/environment_configuration.dart';
import 'package:learn_app/models/learn_content.dart';
import 'package:learn_app/models/tag.dart';
import 'package:learn_app/services/http_service.dart';

class DataService {
  static String tagListAPI = '${EnvironmentConfiguration.baseAPIURL}c498ac6a-5be7-4ac3-b407-b703af3e2247';
  static String learnContentAPI = '${EnvironmentConfiguration.baseAPIURL}742454fc-089b-47df-b7c1-4c1ce4091586';

  static Future<List<Tag>> getTag() async {
    List<Tag> tags = [];

    var response = await HttpService.get(tagListAPI);
    Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> resultData = data['tags'] as List<dynamic>;
    
    for (var element in resultData) {
      Map<String, dynamic> tagData = element as Map<String, dynamic>;
      Tag tag = Tag.fromJson(tagData);
      tags.add(tag);
    }

    return tags;
  }

  static Future<List<LearnContent>> getLearnContent() async {
    List<LearnContent> learnContents = [];

    var response = await HttpService.get(learnContentAPI);
    Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> resultData = data['learn_content'] as List<dynamic>;
    
    for (var element in resultData) {
      Map<String, dynamic> learnContentData = element as Map<String, dynamic>;
      LearnContent learnContent = LearnContent.fromJson(learnContentData);
      learnContents.add(learnContent);
    }

    return learnContents;
  }
}