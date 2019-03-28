import 'dart:math';

import 'package:PetPal/api/petpal_api.dart';
import 'package:PetPal/models/animal/animal.dart';

import './detail.dart';
import 'package:flutter/material.dart';

Positioned swipeCard(
    Animal animal,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    BuildContext context,
    Function dismissImg,
    int flag,
    Function addImg,
    Function swipeRight,
    Function swipeLeft) {
  Size screenSize = MediaQuery.of(context).size;
  // print("Card");
  return Positioned(
    bottom: bottom - 12,
    right: flag == 0 ? right != 0.0 ? right : null : null,
    left: flag == 1 ? right != 0.0 ? right : null : null,
    child: Dismissible(
      key: Key(Random().toString()),
      onDismissed: (DismissDirection direction) {
//          _swipeAnimation();
        if (direction == DismissDirection.endToStart) {
          dismissImg(animal);
        } else {
          addImg(animal);
          PetPalApi().likeAnimal(context, animal.id);
        }
      },
      child: Transform(
        alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
        //transform: null,
        transform: Matrix4.skewX(skew),
        //..rotateX(-math.pi / rotation),
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(
              flag == 0 ? rotation / 360 : -rotation / 360),
          child: Hero(
            tag: "img",
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //      MaterialPageRoute(
                //         builder: (context) =>  DetailPage(type: img)));
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => DetailPage(type: animal),
                ));
              },
              child: Card(
                color: Colors.transparent,
                elevation: 4.0,
                child: Container(
                  width: screenSize.width,
                  height: screenSize.height / 1.4,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(121, 114, 173, 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: screenSize.width,
                        height: screenSize.height / 1.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                          image: DecorationImage(
                            image: NetworkImage(Uri.http("10.27.99.28:8080",
                                    "/assets/" + animal.photoPath)
                                .toString()),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
