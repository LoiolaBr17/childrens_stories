import 'package:childrens_stories/app/data/models/story_model.dart';

abstract interface class StoriesRepository {
  Future<List<StoryModel>> findAllStories();
}
