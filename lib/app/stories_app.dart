import 'package:childrens_stories/app/core/bindings/app_bindings.dart';
import 'package:childrens_stories/app/core/constants/app_routes.dart';
import 'package:childrens_stories/app/core/ui/theme/app_theme.dart';
import 'package:childrens_stories/app/modules/home/home_module.dart';
import 'package:childrens_stories/app/modules/story/story_module.dart';
import 'package:flutter/material.dart';
import 'package:childrens_stories/app/data/models/story_model.dart';

class StoriesApp extends StatelessWidget {
  const StoriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBindings(
      child: MaterialApp(
        title: "Historias Infantis",
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        initialRoute: AppRoutes.home,
        onGenerateRoute: (settings) {
          if (settings.name == AppRoutes.story) {
            final story = settings.arguments as StoryModel;

            return MaterialPageRoute(
              builder: (_) => FutureBuilder<Widget>(
                future: StoryModule.getPage(
                    story), // Carrega a página de forma assíncrona
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
                    } else {
                      return const Center(
                        child: Text("Erro ao carregar a história"),
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            );
          } else if (settings.name == AppRoutes.home) {
            return MaterialPageRoute(
              builder: (_) => HomeModule.page,
            );
          }
          return null;
        },
      ),
    );
  }
}
