import 'dart:convert';
import 'package:childrens_stories/app/core/constants/data_constants.dart';
import 'package:childrens_stories/app/data/models/category_model.dart';
import 'package:childrens_stories/app/data/models/story_model.dart';
import 'package:childrens_stories/app/data/repositories/stories_repository.dart';
import 'package:flutter/services.dart';

class StoriesRepositoryImpl implements StoriesRepository {
  StoriesRepositoryImpl();

  @override
  Future<List<StoryModel>> findAllStories() async {
    // Carrega o JSON das histórias
    final storiesResponse = await rootBundle.loadString(DataConstants.stories);
    final storiesData = json.decode(storiesResponse) as List<dynamic>;

    // Mapeia cada história para um StoryModel
    final stories = storiesData.map<StoryModel>((storyData) {
      // O campo 'category' contém o objeto completo no JSON
      final category = CategoryModel.fromMap(storyData['category']);

      // Cria e retorna o StoryModel, passando a categoria correta
      return StoryModel(
        id: storyData['id'],
        title: storyData['title'],
        imagebanner: storyData['imagebanner'],
        category: category, // O objeto CategoryModel é criado diretamente
        content: List<String>.from(storyData['content']),
      );
    }).toList();

    return stories;
  }
}
