import 'package:PetPal/api/tokenhandler.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: FutureBuilder(
              future: _getUsername(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return snapshot.hasData ? Text(snapshot.data) : Text('data');
              },
            ),
            // accountName: Text(
            //   Futur
            //   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            // ),
            accountEmail: Text(
              "Account email",
            ),
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage('assets/cat.jpg'),
                  )),
            ),
          ),
          ListTile(
              title: Text("Finder"),
              leading: Icon(Icons.search),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/petfinder');
              }),
          ListTile(
              title: Text("My pets"),
              leading: Icon(Icons.pets),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/pets');
              }),
          ListTile(
              title: Text("Add pet"),
              leading: Icon(Icons.add),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/addpet');
              }),
          ListTile(
              title: Text("Settings"),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/settings');
              }),
          ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.power_settings_new),
              onTap: () {
                TokenHandler().deleteMobileToken();
                Navigator.popUntil(
                  context,
                  ModalRoute.withName('/petfinder'),
                );
                Navigator.of(context).pushNamed('/authentication');
              }),
        ],
      ),
    );
  }
}

Future<String> _getUsername() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  print(preferences.getString("LastUser"));
  return preferences.getString("LastUser");
}
