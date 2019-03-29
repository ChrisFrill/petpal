import 'package:PetPal/blocs/liked/favourite_bloc.dart';
import 'package:PetPal/blocs/liked/favourite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikedPets extends StatefulWidget {
  @override
  _LikedPetsState createState() => _LikedPetsState();
}

class _LikedPetsState extends State<LikedPets> {
  final FavouriteBloc _favouriteBloc = FavouriteBloc();

  _LikedPetsState() {
    _favouriteBloc.dispatch(LikeEvent.fetch);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200.0,
        child: BlocBuilder(
          bloc: _favouriteBloc,
          builder: (BuildContext context, FavouriteState state) {
            if (state is FavouriteUninitialized) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is FavouriteError) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  "Error loading pets",
                  style: TextStyle(color: Colors.deepPurple, fontSize: 50.0),
                ),
              );
            }

            if (state is FavouriteLoaded) {
              if (state.favourites.length == 0) {
                return Center(
                  child: Text(
                    "No Pets Liked",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 50.0),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: state.favourites.length,
                  itemBuilder: (BuildContext ctxt, int index) => ListTile(
                        title: Text(state.favourites[index].name),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            Uri.http(
                                    "10.27.99.28:8080",
                                    "/assets/" +
                                        state.favourites[index].photoPath)
                                .toString(),
                          ),
                        ),
                        trailing: Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ),
                  scrollDirection: Axis.vertical,
                );
              }
            }
          },
        ));
  }
}

_buildCard(BuildContext context, FavouriteLoaded state, int index) {
  Size screenSize = MediaQuery.of(context).size;
  return Card(
    color: Colors.transparent,
    elevation: 0.0,
    child: Container(
      width: screenSize.width,
      height: screenSize.height / 1.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 487 / 451,
            child: Container(
              width: screenSize.width,
              height: screenSize.height / 1.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(Uri.http("10.27.99.13:8080",
                            "/assets/" + state.favourites[index].photoPath)
                        .toString()),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ],
      ),
    ),
  );
}

// GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 1.0,
//                   ),
//                   itemBuilder: (BuildContext ctxt, int index) => Stack(
//                         children: <Widget>[
//                           _buildCard(context, state, index),
//                           Positioned(
//                             bottom: 20,
//                             left: 20,
//                             child: Text(state.favourites[index].name),
//                           ),
//                         ],
//                       ),
//                   itemCount: state.favourites.length,
//                 );

// Card(
//                         color: Colors.transparent,
//                         elevation: 4.0,
//                         child: Container(
//                           width: screenSize.width,
//                           height: screenSize.height / 1.4,
//                           decoration: BoxDecoration(
//                             color: Color.fromRGBO(121, 114, 173, 1.0),
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           child: Column(
//                             children: <Widget>[
//                               Container(
//                                 width: screenSize.width,
//                                 height: screenSize.height / 1.4,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(8.0),
//                                       topRight: Radius.circular(8.0)),
//                                   image: DecorationImage(
//                                       image: NetworkImage(Uri.http(
//                                               "192.168.0.206:8080",
//                                               "/assets/" +
//                                                   state.favourites[index]
//                                                       .photoPath)
//                                           .toString()),
//                                       fit: BoxFit.cover),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
