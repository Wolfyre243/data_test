// Import main dependencies
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:data_test/data/datamanager.dart';
import 'package:data_test/pages/eventspage.dart';

// Questions
// - How to immediately read data without having to reload the page

// Define the event item class
class EventItem {
  // Define properties
  final int id;
  final String name;
  final String date;
  final String description;

  EventItem({
    required this.id,
    required this.name,
    required this.date,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'description': description
    };
  }

  // Factory constructor
  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      id: json['id'],
      name: json['name'],
      date: json['date'],
      description: json['description'],
    );
  }
}

// Details screen for viewing more details about the event
// TODO: Find out how to turn this into a popup
class DetailScreen extends StatelessWidget {
  // Event item object is passed in from the caller
  final EventItem item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ID (Debug): ${item.id}', style: TextStyle(fontSize: 18)),
            Text('Date: ${item.date}', style: TextStyle(fontSize: 18)),
            Text('Description: ${item.description}', style: TextStyle(fontSize: 18)),
            IconButton(
              onPressed: () {
                EventDataManager.deleteEvent(item.id);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const EventsPage()),
                );
              }, 
              icon: Icon(Icons.delete)
            )
          ],
        ),
      ),
    );
  }
}