import 'package:flutter/material.dart';

import './login.dart';
import './registration.dart';
import '../icons/petpal_icons.dart';

class Authentication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Sign in'),
              Tab(text: 'Sign up'),
            ],
          ),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                PetPal.pets,
              ),
              Text('Petpal')
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Login(),
            Registration(),
          ],
        ),
      ),
    );
  }
}
