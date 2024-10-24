import 'package:childrens_stories/app/core/bindings/app_bindings.dart';
import 'package:childrens_stories/app/core/constants/app_routes.dart';
import 'package:childrens_stories/app/core/ui/theme/app_theme.dart';
import 'package:childrens_stories/app/modules/home/home_module.dart';
import 'package:childrens_stories/app/modules/story/story_module.dart';
import 'package:flutter/material.dart';

class StoriesApp extends StatelessWidget {
  const StoriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBindings(
      child: MaterialApp(
        title: "historias infantis",
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        routes: {
          AppRoutes.home: (_) => HomeModule.page,
          AppRoutes.story: (_) => StoryModule.page,
        },
      ),
    );
  }
}
