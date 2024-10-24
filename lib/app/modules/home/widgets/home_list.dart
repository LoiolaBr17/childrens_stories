import 'package:childrens_stories/app/core/extensions/size_extensions.dart';
import 'package:childrens_stories/app/modules/home/widgets/home_card.dart';
import 'package:flutter/material.dart';

import '../../../data/models/story_model.dart';

class HomeList extends StatelessWidget {
  final List<StoryModel> stories;
  final String title;
  const HomeList({
    super.key,
    required this.stories,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...stories.map((story) => HomeCard(story: story)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
