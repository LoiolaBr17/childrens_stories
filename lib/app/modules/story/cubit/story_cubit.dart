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
    _audioPlayer.onPlayerComplete.listen((_) {
      emit(state.copyWith(
          audioStatus: AudioStatus
              .recorded)); // Reset para o estado recorded ao fim do áudio
    });
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
    if (state.audioStatus == AudioStatus.playing) {
      await _audioPlayer.pause();
      emit(state.copyWith(audioStatus: AudioStatus.recorded)); // Pausa o áudio
    } else {
      await _audioPlayer.setSourceDeviceFile(_audioFilePath);
      await _audioPlayer.resume();
      emit(state.copyWith(audioStatus: AudioStatus.playing)); // Toca o áudio
    }
  }

  Future<void> deleteAudio() async {
    final file = File(_audioFilePath);
    if (await file.exists()) {
      await file.delete();
      await _audioPlayer.release();
      _initAudioPlayer(); // Recria o player após liberação

      emit(state.copyWith(
        audioStatus: AudioStatus.initial,
        audioPath: null,
      ));
    }
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    emit(state.copyWith(
        audioStatus: AudioStatus.recorded)); // Reseta o estado para recorded
  }

  Future<void> resetAudio() async {
    final audioFile = File(_audioFilePath);
    if (await audioFile.exists()) {
      await _audioPlayer.setSourceDeviceFile(_audioFilePath);
      emit(state.copyWith(audioStatus: AudioStatus.recorded));
    } else {
      emit(state.copyWith(
        audioStatus: AudioStatus.initial,
        errorMessage: 'Arquivo de áudio não encontrado.',
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
