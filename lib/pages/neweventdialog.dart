import 'package:flutter/material.dart';
import 'package:data_test/components/event_components.dart';
import 'package:data_test/pages/eventspage.dart';

import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class NewEventDialog extends StatelessWidget {
  const NewEventDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Event')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NewEventForm(),
            SizedBox(height: 20)
          ]
        )
      )
    );
  }
}

class FormField extends StatelessWidget {
  final String text;
  final TextEditingController controller;

  const FormField({super.key, required this.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: Text(text, style: TextStyle(fontSize: 16))),
          Flexible(child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter text';
              }
              return null;
            },
          ),)
        ]
    );
  }
}

class NewEventForm extends StatefulWidget {
  const NewEventForm({super.key});

  @override
  _NewEventFormState createState() {
    return _NewEventFormState();
  }
}

class _NewEventFormState extends State<NewEventForm> {
  // Unqiue identification of the form for validation purposes
  final _formKey = GlobalKey<FormState>();
  final _eventNameController = TextEditingController();
  final _eventDateController = TextEditingController();
  final _eventDescController = TextEditingController();

  List<EventItem> _data = [];
  String message = "Events";

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Getter to retrive jsonFile
  Future<File> get _jsonFile async {
    final path = await _localPath;
    return File('$path/data.json');
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

  Future<void> writeJson(List<EventItem> eventListData) async {
    // Map<String, dynamic>
    final file = await _jsonFile;

    final convertedArr = eventListData.map((event) => event.toMap());

    String jsonString = jsonEncode(convertedArr.toList());
    await file.writeAsString(jsonString);
  }

  Future<void> addEvent(Map<String, dynamic> itemData) async {
    try {
      // Fetch the data from the file and store it in the _data list.
      await readJson();

      itemData['id'] = _data.length + 1;

      final newEvent = EventItem.fromJson(itemData);
      
      setState(() {
        _data.add(newEvent);
        writeJson(_data);
      });

    } catch (e) {
      setState(() => message = e.toString());
    }
  }
  
  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDateController.dispose();
    _eventDescController.dispose();
    super.dispose();
  }

  @override 
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.0,
          children: [
            FormField(text: "Event Name", controller: _eventNameController),
            FormField(text: "Date", controller: _eventDateController),
            FormField(text: "Description (optional)", controller: _eventDescController),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Display message
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('Name: ${_eventNameController.text}, Date: ${_eventDateController.text}, Description: ${_eventDescController.text}')
                        );
                      }
                    );

                    // Actually add the event into the _data list
                    addEvent({
                      'name': _eventNameController.text,
                      'date': _eventDateController.text,
                      'description': _eventDescController.text,
                    });
                    // Redirect user
                    Navigator.pushNamed(context, '/events');
                  }
                }, 
                child: const Text('Submit'),
              )
            )
          ],
        )
      )
    );
  }
}
