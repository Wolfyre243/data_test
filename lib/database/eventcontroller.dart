import 'dart:async';

import 'package:sqflite/sqflite.dart';


import 'package:data_test/components/event_components.dart';
import 'package:data_test/database/database.dart';

Future<void> insertEvent(EventItem event) async {

  final db = await initialiseDB();

  await db.insert(
    'event', 
    event.toMap(), 
    conflictAlgorithm: ConflictAlgorithm.replace
  );
}

Future<List<EventItem>> getAllEvents() async {
  // Get a reference to the database.
  final db = await initialiseDB();

  // Query the table for all the dogs.
  final List<Map<String, Object?>> eventMaps = await db.query('event');

  // Convert the list of each dog's fields into a list of `Dog` objects.
  return [
    for (final {'id': id as int, 'name': name as String, 'date': date as String, 'description': description as String}
        in eventMaps)
      EventItem(id: id, name: name, date: date, description: description)
  ];
}