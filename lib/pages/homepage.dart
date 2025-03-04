// Import main dependencies
import 'package:data_test/components/event_components.dart';
import 'package:flutter/material.dart';

// Import other components
import 'package:data_test/components/appdrawer.dart';
import 'package:data_test/database/eventcontroller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome Home", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),

            // Link to Profile Page
            ElevatedButton(
              onPressed: () { Navigator.pushNamed(context, '/profile'); }, 
              child: Text('Profile')
            ),

            ElevatedButton(
              onPressed: () { 
                var newEvent = EventItem(id: 1, name: 'HelloWorld', date: '4/3/2025', description: 'hi');
                insertEvent(newEvent).then((value) => print('Success'));
               }, 
              child: Text('Add Event')
            )
          ]
        )
      )
    );
  }
}