import 'dart:developer';

import 'package:childrens_stories/app/data/models/story_model.dart';
import 'package:childrens_stories/app/data/repositories/stories_repository.dart';
import 'package:childrens_stories/app/data/services/stories_service.dart';

class StoriesServiceImpl extends StoriesService {
  final StoriesRepository _storiesRepository;

  StoriesServiceImpl({required StoriesRepository storiesRepository})
      : _storiesRepository = storiesRepository;

  @override
  Future<List<StoryModel>> findAllStories() async {
    final response = await _storiesRepository.findAllStories();
    log(response.length.toString());
    return response;
  }
}
