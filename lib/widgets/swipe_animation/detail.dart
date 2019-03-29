import 'package:PetPal/models/animal/animal.dart';

import 'package:flutter/material.dart';
import './styles.dart';
import 'package:flutter/scheduler.dart';

class DetailPage extends StatefulWidget {
  final Animal type;
  const DetailPage({Key key, this.type}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState(type: type);
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  AnimationController _containerController;
  Animation<double> width;
  Animation<double> heigth;
  Animal type;
  _DetailPageState({this.type});
  double _appBarHeight = 256.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  void initState() {
    _containerController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
    width = Tween<double>(
      begin: 200.0,
      end: 220.0,
    ).animate(
      CurvedAnimation(
        parent: _containerController,
        curve: Curves.ease,
      ),
    );
    heigth = Tween<double>(
      begin: 400.0,
      end: 400.0,
    ).animate(
      CurvedAnimation(
        parent: _containerController,
        curve: Curves.ease,
      ),
    );
    heigth.addListener(() {
      setState(() {
        if (heigth.isCompleted) {}
      });
    });
    _containerController.forward();
  }

  @override
  void dispose() {
    _containerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.7;
    //print("detail");
    return Theme(
      data: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.deepPurple,
        platform: Theme.of(context).platform,
      ),
      child: Container(
        width: width.value,
        height: heigth.value,
        color: const Color.fromRGBO(106, 94, 175, 1.0),
        child: Hero(
          tag: "img",
          child: Card(
            color: Colors.transparent,
            child: Container(
              alignment: Alignment.center,
              width: width.value,
              height: heigth.value,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  CustomScrollView(
                    shrinkWrap: false,
                    slivers: <Widget>[
                      SliverAppBar(
                        elevation: 0.0,
                        forceElevated: true,
                        leading: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                        expandedHeight: _appBarHeight,
                        pinned: _appBarBehavior == AppBarBehavior.pinned,
                        floating: _appBarBehavior == AppBarBehavior.floating ||
                            _appBarBehavior == AppBarBehavior.snapping,
                        snap: _appBarBehavior == AppBarBehavior.snapping,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(type.name),
                          background: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Container(
                                width: width.value,
                                height: _appBarHeight,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(Uri.http(
                                            "10.27.99.28:8080",
                                            "/assets/" + type.photoPath)
                                        .toString()),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(35.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(bottom: 20.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black12))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.calendar_view_day,
                                              color: Colors.deepPurpleAccent,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text("10 years old"),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.map,
                                              color: Colors.deepPurpleAccent,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text("15 MILES"),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, bottom: 8.0),
                                    child: Text(
                                      "ABOUT",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                      "Are you looking for a friend? Well so am I! Someone to walk on the beach with? Me too! How about a cuddle on the couch and someone who will listen and not judge you? So am I! We have so much in common I’m sure we could even be BFF! I’m not looking for just anyone. Someone who will appreciate my protective nature (no door bells needed!)! I’m not only a little cutie with my curled tail and big brown eyes, I have substance and intelligence! I have learned the basics like sit, down and would love to continue learning  things."),
                                  Container(
                                    margin: EdgeInsets.only(top: 25.0),
                                    padding:
                                        EdgeInsets.only(top: 5.0, bottom: 10.0),
                                    height: 120.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.black12))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "SIMILAR PETS",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            CircleAvatar(
                                                backgroundImage: avatar1),
                                            CircleAvatar(
                                              backgroundImage: avatar2,
                                            ),
                                            CircleAvatar(
                                              backgroundImage: avatar3,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
