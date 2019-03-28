import 'package:PetPal/blocs/chat/chat_bloc.dart';
import 'package:PetPal/blocs/chat/chat_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatUsers extends StatefulWidget {
  @override
  _ChatUsersState createState() => _ChatUsersState();
}

class _ChatUsersState extends State<ChatUsers> {
  final ChatBloc _chatBloc = ChatBloc();

  _ChatUsersState() {
    _chatBloc.dispatch(LikeEvent.fetch);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200.0,
        child: BlocBuilder(
          bloc: _chatBloc,
          builder: (BuildContext context, ChatState state) {
            if (state is ChatUninitialized) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ChatError) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  "Error loading chats",
                  style: TextStyle(color: Colors.deepPurple, fontSize: 50.0),
                ),
              );
            }

            if (state is ChatLoaded) {
              if (state.chats.length == 0) {
                return Center(
                  child: Text("No available chat"),
                );
              } else {
                return ListView.builder(
                  itemCount: state.chats.length,
                  itemBuilder: (BuildContext ctxt, int index) => ListTile(title: Text(state.chats[index].animal.name),
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(Uri.http(
                                    "10.27.99.28:8080",
                                    "/assets/" +
                                        state.chats[index].animal.photoPath)
                                .toString())),
                                trailing: Icon(Icons.cancel, color: Colors.red,),
                      ),
                  scrollDirection: Axis.vertical,
                );
              }
            }
          },
        ));
  }
}

_buildCard(BuildContext context, ChatLoaded state, int index) {
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
                    image: NetworkImage(Uri.http("10.27.99.28:8080",
                            "/assets/" + state.chats[index].animal.photoPath)
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
//                             child: Text(state.Chats[index].name),
//                           ),
//                         ],
//                       ),
//                   itemCount: state.Chats.length,
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
//                                                   state.Chats[index]
//                                                       .photoPath)
//                                           .toString()),
//                                       fit: BoxFit.cover),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
