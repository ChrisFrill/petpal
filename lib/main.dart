import 'package:flutter/material.dart';

import './authentication/authentication_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.deepPurple, accentColor: Colors.deepOrange),
        home: Authentication());
  }
}
