import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSelect extends StatefulWidget {
  const ThemeSelect({super.key});

  @override
  _ThemeSelectState createState() => _ThemeSelectState();
}

class _ThemeSelectState extends State<ThemeSelect> {

  bool theme = false; // 0 = light, 1 = dark

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      print(prefs.getBool('theme'));
      theme = prefs.getBool('theme') ?? false;
    });
  }

  Future<void> _toggleTheme(bool newValue) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('theme', newValue);
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16.0,
      children: [
        Text('Dark Mode'),
        Switch(
          // This bool value toggles the switch.
          value: theme,
          activeColor: Colors.blueGrey,
          onChanged: (bool value) {
            _toggleTheme(value);
          },
        )
      ],
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  Map<String, dynamic> settingsMap = {};

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      settingsMap['theme'] = prefs.getBool('theme') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ThemeSelect(),
            Text('Theme: ${settingsMap['theme']? 'Dark' : 'Light'}'),
            SizedBox(height: 20)
          ]
        )
      )
    );
  }
}