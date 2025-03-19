// Import main dependencies
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// Import component dependencies
import 'package:data_test/components/event_components.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  _EventListState createState() => _EventListState();
}
class _EventListState extends State<EventsPage> {
  // String _data = 'No data yet';
  List<EventItem> _data = [];
  String message = "Events";

  // Getter to retrieve local file storage path
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Getter to retrive jsonFile
  Future<File> get _jsonFile async {
    final path = await _localPath;
    return File('$path/data.json');
  }

  Future<void> writeJson(List<EventItem> eventListData) async {
    // Map<String, dynamic>
    final file = await _jsonFile;

    final convertedArr = eventListData.map((event) => event.toMap());

    String jsonString = jsonEncode(convertedArr.toList());
    await file.writeAsString(jsonString);
  }

  Future<void> appendJson(Map<String, dynamic> itemData) async {
    try {
      final newEvent = EventItem.fromJson(itemData);
      
      setState(() {
        _data.add(newEvent);
      });

    } catch (e) {
      setState(() => message = e.toString());
    }
  }

  Future<void> readJson() async {
    try {
      final file = await _jsonFile;
      if (await file.exists()) {
        
        String contents = await file.readAsString();
        // Note that the jsonList has to contain more than 1 entity for it to work as a list.
        // Still trying to figure this out.
        List<dynamic> jsonList = jsonDecode(contents);
        setState(() {
          _data = jsonList.map((json) => EventItem.fromJson(json)).toList();
        });
        
      } else {
        setState(() => message = "No saved data found.");
      }
    } catch (e) {
      setState(() => message = e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Events Page")),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_data[index].name),
              subtitle: Text(_data[index].description),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailScreen(item: _data[index])),
                );
              }
            )
          );
        }
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // appendJson({"id": 1, "name": "grocery", "date": "6/3/2024", "description": "hello"});
              Navigator.pushNamed(context, '/newevent');
            },
            tooltip: "Add JSON Data",
            child: Icon(Icons.add),
          ),SizedBox(height: 10),
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