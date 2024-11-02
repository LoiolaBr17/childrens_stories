import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:childrens_stories/app/core/extensions/size_extensions.dart';
import 'package:childrens_stories/app/modules/story/cubit/story_cubit.dart';
import 'package:childrens_stories/app/data/models/story_model.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> with WidgetsBindingObserver {
  late StoryCubit _storyCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _storyCubit =
        context.read<StoryCubit>(); // Armazena uma referência ao StoryCubit
    _storyCubit.resetAudio(); // Reinicia o áudio ao entrar na tela
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _storyCubit.stopAudio(); // Para o áudio ao sair da tela
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _storyCubit.stopAudio(); // Pausa o áudio ao sair da tela
    } else if (state == AppLifecycleState.resumed) {
      _storyCubit.resetAudio(); // Reinicia o áudio ao retornar
    }
  }

  @override
  Widget build(BuildContext context) {
    final story = context.read<StoryModel>();

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: context.percentWidth(0.7),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(20),
                    shadowColor: Colors.white,
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      width: context.width,
                      height: context.percentHeight(0.4),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: const Color(0xFF87CEEB),
                        image: DecorationImage(
                          image: AssetImage(story.imagebanner),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  story.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                for (var paragraph in story.content)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      paragraph,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                SizedBox(height: context.percentHeight(.20))
              ],
            ),
          ),
          BlocBuilder<StoryCubit, StoryState>(
            builder: (context, state) {
              // Exibe o player de áudio somente se o áudio estiver gravado ou em reprodução
              if (state.audioStatus == AudioStatus.recorded ||
                  state.audioStatus == AudioStatus.playing) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF121B22),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => _storyCubit.deleteAudio(),
                          icon: const Icon(Icons.delete, color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () => _storyCubit.playAudio(),
                          icon: Icon(
                            state.audioStatus == AudioStatus.playing
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<StoryCubit, StoryState>(
        builder: (context, state) {
          // Exibe o botão de gravação somente se o áudio ainda não foi gravado
          if (state.audioStatus == AudioStatus.initial ||
              state.audioStatus == AudioStatus.error) {
            return FloatingActionButton(
              onPressed: () {
                if (state.audioStatus == AudioStatus.recording) {
                  _storyCubit.stopRecording();
                } else {
                  _storyCubit.startRecording();
                }
              },
              backgroundColor: state.audioStatus == AudioStatus.recording
                  ? Colors.red
                  : Colors.blue,
              child: Icon(
                state.audioStatus == AudioStatus.recording
                    ? Icons.stop
                    : Icons.mic,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
