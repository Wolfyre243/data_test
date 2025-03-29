// Import main dependencies
import 'package:flutter/material.dart';
import 'dart:convert';

// Import component dependencies
import 'package:data_test/components/event_components.dart';
import 'package:data_test/data/datamanager.dart';
import 'package:data_test/components/appdrawer.dart';


class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  _EventListState createState() => _EventListState();
}
class _EventListState extends State<EventsPage> {
  // String _data = 'No data yet';
  List<EventItem> _data = [];
  String message = "Events";

  Future<void> readJson() async {
    try {
      final file = await DataManager.getJSONFile('data.json');
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
      drawer: AppDrawer(),
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