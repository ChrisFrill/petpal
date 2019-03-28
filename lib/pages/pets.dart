import 'package:PetPal/blocs/liked/favourite_bloc.dart';
import 'package:PetPal/widgets/lists/likedpets.dart';
import 'package:PetPal/widgets/lists/to_adopt_pets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        bloc: FavouriteBloc(),
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Liked pets'),
                Tab(text: 'Pets to adopt'),
              ],
            ),
            title: Row(
              children: <Widget>[Text('My pets')],
            ),
          ),
          body: TabBarView(
            children: [
              LikedPets(),
              ToAdoptPets(),
            ],
          ),
        ),
      ),
    );
  }
}
