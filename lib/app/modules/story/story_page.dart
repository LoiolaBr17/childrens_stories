import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:childrens_stories/app/core/extensions/size_extensions.dart';
import 'package:childrens_stories/app/modules/story/cubit/story_cubit.dart';
import 'package:childrens_stories/app/data/models/story_model.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({super.key});

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
              // Exibe o player de áudio somente se o áudio existir e não estiver carregando
              if (state.audioStatus == AudioStatus.recorded) {
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
                          onPressed: () =>
                              context.read<StoryCubit>().deleteAudio(),
                          icon: const Icon(Icons.delete, color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () =>
                              context.read<StoryCubit>().playAudio(),
                          icon:
                              const Icon(Icons.play_arrow, color: Colors.green),
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
          // Exibe o botão de gravação somente se o áudio não existir e o áudio não estiver carregando
          if (state.audioStatus != AudioStatus.recorded &&
              state.audioStatus != AudioStatus.loading) {
            return FloatingActionButton(
              onPressed: () {
                if (state.audioStatus == AudioStatus.recording) {
                  context.read<StoryCubit>().stopRecording();
                } else {
                  context.read<StoryCubit>().startRecording();
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
