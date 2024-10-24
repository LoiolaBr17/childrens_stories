import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:childrens_stories/app/data/models/story_model.dart';
import 'package:childrens_stories/app/data/services/stories_service.dart';
import 'package:childrens_stories/app/modules/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final StoriesService _storiesService;

  HomeCubit({
    required StoriesService storiesService,
  })  : _storiesService = storiesService,
        super(const HomeState.initial());

  Future<void> findAllStories() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));

      final stories = await _storiesService.findAllStories();

      // Criar o mapa de categorias e suas histórias
      final Map<int, List<StoryModel>> categorizedStories = {};

      for (var story in stories) {
        final categoryId = story.category.id; // Usar o ID da categoria

        if (categorizedStories.containsKey(categoryId)) {
          categorizedStories[categoryId]!.add(story);
        } else {
          categorizedStories[categoryId] = [story];
        }
      }

      log(categorizedStories.length.toString());
      log('mateus');

      emit(state.copyWith(
        status: HomeStatus.loaded,
        categorizedStories: categorizedStories, // Emite o novo mapa
      ));
    } catch (e) {
      log('Erro ao buscar histórias');
      emit(state.copyWith(status: HomeStatus.error));
    }
  }
}
