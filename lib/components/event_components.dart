// Import main dependencies
import 'package:flutter/material.dart';

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
        child: Text(item.date, style: TextStyle(fontSize: 24)),
      ),
    );
  }
}