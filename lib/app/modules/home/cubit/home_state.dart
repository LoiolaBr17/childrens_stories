// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:childrens_stories/app/data/models/story_model.dart';

enum HomeStatus { initial, loading, loaded, error, empty }

class HomeState extends Equatable {
  final HomeStatus status;
  final Map<int, List<StoryModel>>
      categorizedStories; // Agora a chave é o id da categoria

  const HomeState({
    required this.status,
    required this.categorizedStories,
  });

  const HomeState.initial()
      : status = HomeStatus.initial,
        categorizedStories = const {};

  @override
  List<Object?> get props => [status, categorizedStories];

  HomeState copyWith({
    HomeStatus? status,
    Map<int, List<StoryModel>>?
        categorizedStories, // Atualizado para aceitar Map<int, List<StoryModel>>
  }) {
    return HomeState(
      status: status ?? this.status,
      categorizedStories: categorizedStories ?? this.categorizedStories,
    );
  }
}
