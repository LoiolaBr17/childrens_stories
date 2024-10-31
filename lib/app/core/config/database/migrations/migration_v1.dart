import 'package:sqflite/sqlite_api.dart';

import 'migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
     CREATE TABLE audios_stories (
        id INTEGER PRIMARY KEY,
        audio_path TEXT,
      )
    ''');
  }

  @override
  void upgrade(Batch batch) {}
}
