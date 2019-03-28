import 'package:PetPal/blocs/pets/pets_bloc.dart';
import 'package:PetPal/widgets/navdrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/swipe_animation/index.dart';

class PetFinder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: PetsBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Text('PetPal'),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {
                Navigator.of(context).pushNamed('/chat');
              },
            ),
          ],
        ),
        drawer: NavDrawer(),
        body: Container(child: SwipeCard()),
      ),
    );
  }
}
