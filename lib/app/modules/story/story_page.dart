import 'package:childrens_stories/app/core/extensions/size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:childrens_stories/app/data/models/story_model.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({
    super.key,
  });

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    final story = ModalRoute.of(context)?.settings.arguments as StoryModel;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.mic),
      ),
    );
  }
}
