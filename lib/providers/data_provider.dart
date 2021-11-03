
import 'package:flutter/material.dart';
import 'package:learn_app/models/learn_content.dart';
import 'package:learn_app/models/tag.dart';
import 'package:learn_app/services/data_service.dart';

class DataProvider extends ChangeNotifier {
  
  bool isLoading = false;

  List<Tag> tags = [];
  List<LearnContent> contents = [];
  List<LearnContent> curContents = [];
  List<LearnContent> saveContents = [];

  Future<void> getTag() async {
    tags = await DataService.getTag();
    Tag allTag = Tag(name: 'All', color: 'black');
    tags.insert(0, allTag);
  }

  Future<void> getLearnContent() async {
    isLoading = true;
    
    contents = await DataService.getLearnContent();

    for (int i = 0; i < contents.length; i++) {
      LearnContent content = LearnContent(
        createdAt: contents[i].createdAt,
        type: contents[i].type,
        title: contents[i].title,
        description: contents[i].description,
        thumbnailUrl: contents[i].thumbnailUrl,
        contentUrl: contents[i].contentUrl,
        tag: Tag(
          name: contents[i].tag.name,
          color: contents[i].tag.color,
        ),
        save: false,
      );
      
      curContents.add(content);
    }
    
    notifyListeners();
  }

  void getCurContents(String name) {
    curContents.clear();

    if (name != 'All') {
      for(int i = 0; i < contents.length; i++) {
        if (contents[i].tag.name == name) {
          LearnContent content = LearnContent(
            createdAt: contents[i].createdAt,
            type: contents[i].type,
            title: contents[i].title,
            description: contents[i].description,
            thumbnailUrl: contents[i].thumbnailUrl,
            contentUrl: contents[i].contentUrl,
            tag: Tag(
              name: contents[i].tag.name,
              color: contents[i].tag.color,
            ),
            save: contents[i].save,
          );

          curContents.add(content);
        }
      }
    }
    else {
      for (int i = 0; i < contents.length; i++) {
        LearnContent content = LearnContent(
          createdAt: contents[i].createdAt,
          type: contents[i].type,
          title: contents[i].title,
          description: contents[i].description,
          thumbnailUrl: contents[i].thumbnailUrl,
          contentUrl: contents[i].contentUrl,
          tag: Tag(
            name: contents[i].tag.name,
            color: contents[i].tag.color,
          ),
          save: contents[i].save,
        );
        
        curContents.add(content);
      }
    }
  }

  List<LearnContent> getSaveContents() {
    saveContents.clear();

    for(int i = 0; i < curContents.length; i++) {
      LearnContent content = curContents[i];
      if(content.save) {
        saveContents.add(content);
      }
    }

    return saveContents;
  }

  void setSaveContents(String title) {
    for(int i = 0; i < curContents.length; i++) {
      LearnContent content = curContents[i];
      if (content.title == title) {
        curContents[i].save = !curContents[i].save;
        break;
      }
    }

    for(int i = 0; i < contents.length; i++) {
      LearnContent content = contents[i];
      if (content.title == title) {
        contents[i].save = !contents[i].save;
        break;
      }
    }
  }
}