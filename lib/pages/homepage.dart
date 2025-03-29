// Import main dependencies
import 'package:flutter/material.dart';

// Import other components
import 'package:data_test/components/appdrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

const dark = Color.fromARGB(255, 17, 17, 17);
const light = Color.fromARGB(255, 255, 255, 255);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool theme = false;
  
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      print(prefs.getBool('theme'));
      theme = prefs.getBool('theme') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {

    // _loadPreferences();

    return Scaffold(
      backgroundColor: theme ? dark : light,
      appBar: AppBar(title: Text('Home Page')),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome Home", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),

            // Link to Profile Page
            ElevatedButton(onPressed: () {
              Navigator.pushNamed(context, '/profile');
            }, 
            child: Text('Profile'))
          ]
        )
      )
    );
  }
}