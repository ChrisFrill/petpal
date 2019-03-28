import 'package:PetPal/widgets/forms/login.dart';
import 'package:PetPal/widgets/forms/registration.dart';
import 'package:flutter/material.dart';

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
                Icons.pets,
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
