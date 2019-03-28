import 'package:PetPal/models/animal/animal.dart';
import 'package:flutter/material.dart';

Positioned swipeCardDummy(Animal item, double bottom, double right, double left,
    double cardWidth, double rotation, double skew, BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;
  // Size screenSize=(500.0,200.0);
  // print("dummyCard");
  return new Positioned(
    bottom: bottom - 12,
    // right: flag == 0 ? right != 0.0 ? right : null : null,
    //left: flag == 1 ? right != 0.0 ? right : null : null,
    child: new Card(
      color: Colors.transparent,
      elevation: 4.0,
      child: new Container(
        alignment: Alignment.center,
        width: screenSize.width,
        height: screenSize.height / 1.4,
        decoration: new BoxDecoration(
          color: new Color.fromRGBO(121, 114, 173, 1.0),
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: new Column(
          children: <Widget>[
            new Container(
              width: screenSize.width,
              height: screenSize.height / 1.4,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.only(
                    topLeft: new Radius.circular(8.0),
                    topRight: new Radius.circular(8.0)),
                image: DecorationImage(
                  image: NetworkImage(Uri.http(
                          "10.27.99.28:8080", "/assets/" + item.photoPath)
                      .toString()),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
