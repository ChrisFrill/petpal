import 'dart:async';
import 'package:PetPal/api/petpal_api.dart';
import 'package:PetPal/blocs/pets/pets_bloc.dart';
import 'package:PetPal/blocs/pets/pets_event.dart';
import 'package:PetPal/blocs/pets/pets_state.dart';
import 'package:PetPal/models/animal/animal.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import './dummyCard.dart';
import './activeCard.dart';

//import 'package:animation_exp/PageReveal/page_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class SwipeCard extends StatefulWidget {
  @override
  _SwipeCardState createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> with TickerProviderStateMixin {
  final PetsBloc _petsBloc = PetsBloc();
  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  int flag = 0;
  Animal animal;

  _SwipeCardState() {
    _petsBloc.dispatch(FetchPets());
  }

  void initState() {
    super.initState();

    _buttonController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    rotate = Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          _petsBloc.dispatch(
            DeletePet(
              animal,
            ),
          );
          _buttonController.reset();
        }
      });
    });

    right = Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    bottom = Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    width = Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _swipeAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  dismissImg(Animal animal) {
    setState(() {
      _petsBloc.dispatch(DeletePet(animal));
    });
  }

  addImg(Animal animal) {
    setState(() {
      _petsBloc.dispatch(DeletePet(animal));
    });
  }

  swipeRight() {
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    _swipeAnimation();
  }

  swipeLeft() {
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    _swipeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    double initialBottom = 15.0;
    double backCardPosition = initialBottom + 2 * 10 + 10;
    double backCardWidth = -10.0;
    return BlocBuilder(
      bloc: _petsBloc,
      builder: (BuildContext context, PetsState state) {
        if (state is PetsUninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PetsLoaded) {
          return Scaffold(
            body: Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: state.pets.length > 0
                  ? Stack(
                      alignment: AlignmentDirectional.center,
                      children: state.pets.map((item) {
                        if (state.pets.indexOf(item) == state.pets.length - 1) {
                          return swipeCard(
                              item,
                              bottom.value,
                              right.value,
                              0.0,
                              backCardWidth + 10,
                              rotate.value,
                              rotate.value < -10 ? 0.1 : 0.0,
                              context,
                              dismissImg,
                              flag,
                              addImg,
                              swipeRight,
                              swipeLeft);
                        } else {
                          backCardPosition = backCardPosition - 10;
                          backCardWidth = backCardWidth + 10;

                          return swipeCardDummy(item, backCardPosition, 0.0,
                              0.0, backCardWidth, 0.0, 0.0, context);
                        }
                      }).toList())
                  : Text("No Pets Left",
                      style:
                          TextStyle(color: Colors.deepPurple, fontSize: 50.0)),
            ),
            bottomNavigationBar: Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Tooltip(
                      child: FlatButton.icon(
                        icon: IconTheme(
                          data: IconThemeData(color: Colors.red, size: 50),
                          child: Icon(Icons.close),
                        ),
                        label: Text(""),
                        onPressed: () {
                          animal = state.pets[state.pets.length - 1];
                          swipeLeft();
                        },
                      ),
                      message: "Not interested",
                    ),
                    Tooltip(
                      child: FlatButton.icon(
                        icon: IconTheme(
                          data: IconThemeData(color: Colors.green, size: 50),
                          child: Icon(Icons.pets),
                        ),
                        label: Text(""),
                        onPressed: () {
                          PetPalApi().wantToAdoptAnimal(
                              context, state.pets[state.pets.length - 1].id);
                          swipeRight();
                        },
                      ),
                      message: "Adopt",
                    ),
                    Tooltip(
                      child: FlatButton.icon(
                        icon: IconTheme(
                          data:
                              IconThemeData(color: Colors.deepOrange, size: 50),
                          child: Icon(Icons.favorite),
                        ),
                        label: Text(""),
                        onPressed: () {
                          PetPalApi().likeAnimal(
                            context,
                            state.pets[state.pets.length - 1].id,
                          );
                          animal = state.pets[state.pets.length - 1];
                          swipeRight();
                        },
                      ),
                      message: "Like",
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is PetsError) {
          return Text("Error");
        }
      },
    );
  }
}
