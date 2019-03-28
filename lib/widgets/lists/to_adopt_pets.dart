import 'package:PetPal/blocs/to_adopt/to_adopt_bloc.dart';
import 'package:PetPal/blocs/to_adopt/to_adopt_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToAdoptPets extends StatefulWidget {
  @override
  _ToAdoptPetsState createState() => _ToAdoptPetsState();
}

class _ToAdoptPetsState extends State<ToAdoptPets> {
  final ToAdoptBloc _toAdoptBloc = ToAdoptBloc();

  _ToAdoptPetsState() {
    _toAdoptBloc.dispatch(LikeEvent.fetch);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200.0,
        child: BlocBuilder(
          bloc: _toAdoptBloc,
          builder: (BuildContext context, ToAdoptState state) {
            if (state is ToAdoptUninitialized) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ToAdoptError) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  "Error loading pets",
                  style: TextStyle(color: Colors.deepPurple, fontSize: 50.0),
                ),
              );
            }

            if (state is ToAdoptLoaded) {
              if (state.petsToAdopt.length == 0) {
                return Center(
                  child: Text(
                    "No pets",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 50.0),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: state.petsToAdopt.length,
                  itemBuilder: (BuildContext ctxt, int index) => ListTile(
                        title: Text(state.petsToAdopt[index].name),
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(Uri.http(
                                    "10.27.99.28:8080",
                                    "/assets/" +
                                        state.petsToAdopt[index].photoPath)
                                .toString())),
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

_buildCard(BuildContext context, ToAdoptLoaded state, int index) {
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
                            "/assets/" + state.petsToAdopt[index].photoPath)
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
//                             child: Text(state.ToAdopts[index].name),
//                           ),
//                         ],
//                       ),
//                   itemCount: state.ToAdopts.length,
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
//                                                   state.ToAdopts[index]
//                                                       .photoPath)
//                                           .toString()),
//                                       fit: BoxFit.cover),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
