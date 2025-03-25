// Import Main Dependencies
import 'package:flutter/material.dart';

// Import screens/pages
import 'package:data_test/pages/homepage.dart';
import 'package:data_test/pages/profilepage.dart';
import 'package:data_test/pages/settingspage.dart';
import 'package:data_test/pages/eventspage.dart';
import 'package:data_test/pages/neweventdialog.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Scaffold(
      //   body: Center(
      //     child: Text('Hello World!'),
      //   ),
      // ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Data Test',

      // Define routes
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
        '/settings': (context) => SettingsPage(),
        '/events': (context) => EventsPage(),
        '/newevent': (context) => NewEventDialog(),
      },
    );
  }
}
