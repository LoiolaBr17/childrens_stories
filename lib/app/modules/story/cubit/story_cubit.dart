import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:record/record.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  late AudioPlayer _audioPlayer; // Tornar lazy para reinicializar
  final String _audioFilePath;

  StoryCubit({required String audioFilePath})
      : _audioFilePath = audioFilePath,
        super(const StoryState.initial()) {
    _initAudioPlayer();
    _checkIfAudioExists();
  }

  Future<void> _initAudioPlayer() async {
    _audioPlayer = AudioPlayer();
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
  }

  Future<void> _checkIfAudioExists() async {
    final audioFile = File(_audioFilePath);
    bool exists = await audioFile.exists();
    emit(state.copyWith(
      audioStatus: exists ? AudioStatus.recorded : AudioStatus.initial,
      audioPath: exists ? _audioFilePath : null,
    ));
  }

  Future<void> startRecording() async {
    bool hasPermission = await _audioRecorder.hasPermission();
    if (!hasPermission) {
      emit(state.copyWith(
          audioStatus: AudioStatus.error,
          errorMessage: 'Permissão para gravação não concedida'));
      return;
    }

    // Inicia uma nova gravação e atualiza o estado para "recording"
    await _audioRecorder.start(RecordConfig(), path: _audioFilePath);
    emit(state.copyWith(
        audioStatus: AudioStatus.recording, audioPath: _audioFilePath));
  }

  Future<void> stopRecording() async {
    final path = await _audioRecorder.stop();
    if (path != null) {
      emit(state.copyWith(
        audioStatus: AudioStatus.recorded,
        audioPath: _audioFilePath,
      ));
    }
  }

  Future<void> playAudio() async {
    await _audioPlayer.setSourceDeviceFile(_audioFilePath);
    await _audioPlayer.resume();
    emit(state.copyWith(audioStatus: AudioStatus.recorded));
  }

  Future<void> deleteAudio() async {
    final file = File(_audioFilePath);
    if (await file.exists()) {
      await file.delete();

      // Reinicializa o player para limpar qualquer cache do áudio anterior
      await _audioPlayer.release();
      _initAudioPlayer(); // Recria o player após liberação

      emit(state.copyWith(
        audioStatus: AudioStatus.initial,
        audioPath: null,
      ));
    }
  }

  @override
  Future<void> close() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    return super.close();
  }
}
