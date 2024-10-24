import 'package:childrens_stories/app/modules/home/cubit/home_cubit.dart';
import 'package:childrens_stories/app/modules/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeModule {
  HomeModule._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => HomeCubit(
              storiesService: context.read(),
            ),
          ),
        ],
        child: const HomePage(),
      );
}
