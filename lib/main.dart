import 'package:PetPal/pages/add_pet.dart';
import 'package:PetPal/pages/authentication.dart';
import 'package:PetPal/pages/chat.dart';
import 'package:PetPal/pages/petfinder.dart';
import 'package:PetPal/pages/pets.dart';
import 'package:PetPal/pages/settings.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
//  debugPrintRebuildDirtyWidgets = true;
  return runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.deepPurple, accentColor: Colors.deepOrange),
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/petfinder': (BuildContext context) => PetFinder(),
        '/authentication': (BuildContext context) => LoginPage(),
        '/pets': (BuildContext context) => Pets(),
        '/addpet': (BuildContext context) => AddPet(),
        '/settings': (BuildContext context) => Settings(),
        '/chat': (BuildContext context) => Chat(),
      },
    );
  }
}
