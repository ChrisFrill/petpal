import 'package:flutter/material.dart';

import '../navigation/navdrawer.dart';
import '../swipe_animation/index.dart';
import '../icons/petpal_icons.dart';

class PetFinder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Text('PetPal'),
            ],
          ),
        ),
        drawer: NavDrawer(),
        body: CardDemo(),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(10),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new FlatButton(
                  padding: new EdgeInsets.all(0.0),
                  onPressed: () {},
                  child: new Container(
                    height: 60.0,
                    width: 130.0,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: new BorderRadius.circular(60.0),
                    ),
                    child: new Text(
                      "Not interested",
                      style: new TextStyle(color: Colors.white),
                    ),
                  )),
              new FlatButton(
                  padding: new EdgeInsets.all(0.0),
                  onPressed: () {},
                  child: new Container(
                    height: 60.0,
                    width: 130.0,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: new BorderRadius.circular(60.0),
                    ),
                    child: new Text(
                      "Interested",
                      style: new TextStyle(color: Colors.white),
                    ),
                  ))
            ],
          ),
        ));
  }
}
