// Import Main Dependencies
import 'dart:async';
import 'package:flutter/material.dart';

// Import screens/pages
import 'package:data_test/pages/homepage.dart';
import 'package:data_test/pages/profilepage.dart';
import 'package:data_test/pages/eventspage.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        '/events': (context) => EventsPage()
      },
    );
  }
}
