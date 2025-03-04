// Import main dependencies
import 'package:flutter/material.dart';
import 'dart:convert';

// Import component dependencies
import 'package:data_test/components/event_components.dart';

class EventsPage extends StatelessWidget {
  final String jsonData = '''
    [
      {"id": 1, "name": "Apple", "date": "4/3/25", "description": "A red fruit"},
      {"id": 2, "name": "Banana", "date": "4/3/25", "description": "A yellow fruit"},
      {"id": 3, "name": "Mango", "date": "4/3/25", "description": "A tropical fruit"}
    ]
  ''';

  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> jsonList = json.decode(jsonData);
    List<EventItem> eventList = jsonList.map((json) => EventItem.fromJson(json)).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Events Page')),
      body: ListView.builder(
        itemCount: eventList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(eventList[index].name),
              subtitle: Text(eventList[index].description),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailScreen(item: eventList[index])),
                );
              }
            )
          );
        }
      )
    );
  }
}