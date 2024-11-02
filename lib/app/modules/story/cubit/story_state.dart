part of 'story_cubit.dart';

enum StoryStatus { initial, loading, loaded, error }

enum AudioStatus {
  loading,
  initial,
  recording,
  recorded,
  playing,
  deleted,
  error,
}

class StoryState extends Equatable {
  final StoryStatus status;
  final AudioStatus audioStatus;
  final String? audioPath;
  final String? errorMessage;

  const StoryState({
    required this.status,
    required this.audioStatus,
    this.audioPath,
    this.errorMessage,
  });

  const StoryState.initial()
      : status = StoryStatus.initial,
        audioStatus = AudioStatus.loading,
        audioPath = null,
        errorMessage = null;

  @override
  List<Object?> get props => [status, audioStatus, audioPath, errorMessage];

  StoryState copyWith({
    StoryStatus? status,
    AudioStatus? audioStatus,
    String? audioPath,
    String? errorMessage,
  }) {
    return StoryState(
      status: status ?? this.status,
      audioStatus: audioStatus ?? this.audioStatus,
      audioPath: audioPath ?? this.audioPath,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
