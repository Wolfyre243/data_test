// Import main dependencies
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// Import component dependencies
import 'package:data_test/components/event_components.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   List<dynamic> jsonList = json.decode(jsonData);
  //   List<EventItem> eventList = jsonList.map((json) => EventItem.fromJson(json)).toList();

  //   return Scaffold(
  //     appBar: AppBar(title: Text('Events Page')),
  //     // body: ListView.builder(
  //     //   itemCount: eventList.length,
  //     //   itemBuilder: (context, index) {
  //     //     return Card(
  //     //       child: ListTile(
  //     //         title: Text(eventList[index].name),
  //     //         subtitle: Text(eventList[index].description),
  //     //         onTap: () {
  //     //           Navigator.push(
  //     //             context,
  //     //             MaterialPageRoute(builder: (context) => DetailScreen(item: eventList[index])),
  //     //           );
  //     //         }
  //     //       )
  //     //     );
  //     //   }
  //     // )
  //     body: EventList()
  //   );
  // }

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventsPage> {
  // String _data = 'No data yet';
  List<EventItem> _data = [];
  String message = "Events";

  final String testjsonData = '''
    [
      {"id": 1, "name": "Apple", "date": "6/3/2024", "description": "A red fruit"},
      {"id": 2, "name": "Banana", "date": "6/3/2024", "description": "A yellow fruit"},
      {"id": 3, "name": "Mango", "date": "6/3/2024", "description": "A tropical fruit"}
    ]
  ''';

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

  // TODO: Create simpler way to write a list of json data instead of single ones
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
        // Map<String, dynamic> jsonData = jsonDecode(contents);
        // List<dynamic> jsonList = json.decode(contents);

        // Note that the jsonList has to contain more than 1 entity for it to work as a list.
        // Still trying to figure this out.
        List<dynamic> jsonList = jsonDecode(testjsonData);
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
  Widget build(BuildContext context) {
    // List<dynamic> jsonList = json.decode(jsonData);
    // List<EventItem> eventList = jsonList.map((json) => EventItem.fromJson(json)).toList();

    // List<dynamic> testjsonList = json.decode(testjsonData);
    // setState(() {
    //   _data = testjsonList.map((json) => EventItem.fromJson(json)).toList();
    // });
    // List<EventItem> eventList = testjsonList.map((json) => EventItem.fromJson(json)).toList();
    print(message);

    writeJson({"id": 1, "name": "grocery", "date": "6/3/2024", "description": "hello"});

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
          // FloatingActionButton(
          //   onPressed: () {
          //     writeJson({"id": 1, "name": "grocery", "date": "6/3/2024", "description": "hello"});
          //   },
          //   tooltip: "Save JSON Data",
          //   child: Icon(Icons.save),
          // ),
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