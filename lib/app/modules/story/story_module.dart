import 'package:childrens_stories/app/modules/story/cubit/story_cubit.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:childrens_stories/app/data/models/story_model.dart';
import 'package:childrens_stories/app/modules/story/story_page.dart';

class StoryModule {
  StoryModule._();

  static Future<Widget> getPage(StoryModel story) async {
    // Obter o diretório de documentos do aplicativo
    final directory = await getApplicationDocumentsDirectory();
    // Gerar o caminho do arquivo de áudio dinamicamente com base no id da história
    final audioFilePath = '${directory.path}/audio_${story.id}.m4a';

    return MultiProvider(
      providers: [
        Provider<StoryCubit>(
          create: (context) => StoryCubit(audioFilePath: audioFilePath),
        ),
        Provider<StoryModel>(create: (context) => story),
      ],
      child: const StoryPage(),
    );
  }
}
