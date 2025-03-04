import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          // Drawer Header
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.blue),
                ),
                SizedBox(height: 10),
                Text("Wolfyre", style: TextStyle(color: Colors.black, fontSize: 20)),
                Text("f10w3ry42@gmail.com", style: TextStyle(color: Colors.black54))
              ],
            )
          ),
  
          // Drawer List Items
          // Home Page
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pop(context); // Closes the drawer
              Navigator.pushNamed(context, '/');
            },
          ),

          // Profile Page
          ListTile(
            leading: Icon(Icons.person_2),
            title: Text("Profile"),
            onTap: () {
              Navigator.pop(context); // Closes the drawer
              Navigator.pushNamed(context, '/profile');
            },
          ),

          // Events Page
          ListTile(
            leading: Icon(Icons.event),
            title: Text("Events"),
            onTap: () {
              Navigator.pop(context); // Closes the drawer
              Navigator.pushNamed(context, '/events');
            },
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            // onTap: () {
            //   Navigator.pop(context); // Closes the drawer
            //   Navigator.pushNamed(context, '/profile');
            // },
          )

        ],
      )
    );
  }
}