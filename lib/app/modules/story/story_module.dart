import 'package:childrens_stories/app/modules/story/story_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoryModule {
  StoryModule._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(create: (context) => Container()),
        ],
        child: const StoryPage(),
      );
}
