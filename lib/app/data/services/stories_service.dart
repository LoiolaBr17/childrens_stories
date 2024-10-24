import 'package:childrens_stories/app/data/models/story_model.dart';

abstract class StoriesService {
  Future<List<StoryModel>> findAllStories();
}
