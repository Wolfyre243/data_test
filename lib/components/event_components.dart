// Import main dependencies
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class EventJSON extends StatefulWidget {
  const EventJSON({super.key});

  @override
  _EventJSONState createState() => _EventJSONState();
}

class _EventJSONState extends State<EventJSON> {
  String _data = 'No data yet';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _jsonFile async {
    final path = await _localPath;
    return File('$path/data.json');
  }

  Future<void> writeJson(Map<String, dynamic> jsonData) async {
    final file = await _jsonFile;
    String jsonString = jsonEncode(jsonData);
    await file.writeAsString(jsonString);
  }

  Future<void> readJson() async {
    try {
      final file = await _jsonFile;
      if (await file.exists()) {
        String contents = await file.readAsString();
        Map<String, dynamic> jsonData = jsonDecode(contents);
        setState(() {
          _data = "Name: ${jsonData['name']}, Age: ${jsonData['age']}";
        });
      } else {
        setState(() => _data = "No saved data found.");
      }
    } catch (e) {
      setState(() => _data = "Error reading file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(_data, style: TextStyle(fontSize: 20))),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              writeJson({"name": "John Doe", "age": 30});
            },
            tooltip: "Save JSON Data",
            child: Icon(Icons.save),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: readJson,
            tooltip: "Load JSON Data",
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}

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