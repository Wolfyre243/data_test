import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initialiseDB() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'eventapp.db'),

    // Initialise DB
    onCreate: (db, version) {
      return db.execute(
        '''
        CREATE TABLE event(
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL,
          date TEXT NOT NULL,
          description TEXT
        );
        '''
      );
    },

    version: 1,
  );

  return database;
}