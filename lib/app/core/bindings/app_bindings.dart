import 'package:childrens_stories/app/core/config/database/sqlite_connection_factory.dart';
import 'package:childrens_stories/app/data/repositories/stories_repository.dart';
import 'package:childrens_stories/app/data/repositories/stories_repository_impl.dart';
import 'package:childrens_stories/app/data/services/stories_service.dart';
import 'package:childrens_stories/app/data/services/stories_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBindings extends StatelessWidget {
  final Widget child;
  const AppBindings({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SqliteConnectionFactory>(
          create: (context) => SqliteConnectionFactory(),
        ),
        Provider<StoriesRepository>(
          create: (context) => StoriesRepositoryImpl(),
        ),
        Provider<StoriesService>(
          create: (context) => StoriesServiceImpl(
            storiesRepository: context.read(),
          ),
        )
      ],
      child: child,
    );
  }
}
