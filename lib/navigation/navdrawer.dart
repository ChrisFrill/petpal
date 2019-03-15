import 'package:flutter/material.dart';

import '../add_pet/add_pet.dart';
import '../petfinder/petfinder.dart';
import '../settings/settings.dart';


class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
              title: Text("Finder"),
              leading: Icon(Icons.search),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PetFinder()),
                );
              }),
          ListTile(
              title: Text("Add pet"),
              leading: Icon(Icons.add),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPet()),
                );
              }),
          ListTile(
            title: Text("Settings"),
            leading: Icon(Icons.settings),
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              }
          ),
          ListTile(
            title: Text("Logout"),
            leading: Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }
}
