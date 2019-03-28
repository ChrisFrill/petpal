import 'package:PetPal/widgets/forms/settings.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Text('Settings'),
            ],
          ),
        ),
        body: SettingsForm());
  }
}
