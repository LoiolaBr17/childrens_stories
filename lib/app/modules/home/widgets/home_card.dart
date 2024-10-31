import 'package:childrens_stories/app/core/extensions/size_extensions.dart';
import 'package:childrens_stories/app/modules/story/story_module.dart';
import 'package:flutter/material.dart';
import '../../../data/models/story_model.dart';

class HomeCard extends StatelessWidget {
  final StoryModel story;

  const HomeCard({
    super.key,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FutureBuilder<Widget>(
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
          ),
        );
      },
      child: Container(
        width: context.percentWidth(0.4),
        margin: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(20),
                    shadowColor: Colors.white,
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      width: context.width,
                      height: context.percentHeight(0.22),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: const Color(0xFF87CEEB),
                        image: DecorationImage(
                          image: AssetImage(story.imagebanner),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  story.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
