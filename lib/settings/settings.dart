import 'package:flutter/material.dart';

import './settings_form.dart';

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
