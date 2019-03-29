import 'dart:async';
import 'dart:io';

import 'package:PetPal/api/petpal_api.dart';
import 'package:PetPal/blocs/chat/private_chat_bloc.dart';
import 'package:PetPal/blocs/chat/private_chat_event.dart';
import 'package:PetPal/blocs/chat/private_chat_state.dart';
import 'package:PetPal/models/chat/chat.dart';
import 'package:PetPal/models/chat/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PrivateChat extends StatelessWidget {
  final int peerId;
  final String username;
  final String photoPath;

  PrivateChat(
      {@required this.peerId,
      @required this.username,
      @required this.photoPath});

  @override
  Widget build(BuildContext context) {
    print("peerId");

    print(peerId);
    return BlocProvider(
      bloc: PrivateChatBloc(id: peerId),
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text(
            username,
          ),
          centerTitle: true,
        ),
        body: new ChatScreen(
          peerId: peerId,
          photoPath: photoPath,
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final int peerId;
  final String photoPath;

  ChatScreen({Key key, @required this.peerId, this.photoPath})
      : super(key: key);

  @override
  State createState() =>
      new ChatScreenState(peerId: peerId, photoPath: photoPath);
}

class ChatScreenState extends State<ChatScreen> {
  final PrivateChatBloc _privateChatBloc = PrivateChatBloc();
  final String photoPath;

  ChatScreenState({Key key, @required this.peerId, @required this.photoPath});
  int peerId;
  int id;
  var listMessage;
  String groupChatId;
  SharedPreferences prefs;
  File imageFile;
  bool isLoading;
  bool isShowSticker;
  String imageUrl;

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();
  Timer timer;

  @override
  void initState() {
    super.initState();
    //focusNode.addListener(onFocusChange);
    FetchPrivateChat event = FetchPrivateChat(id: peerId);
    print("event");

    print(event);
    _privateChatBloc.dispatch(event);

    const oneSec = const Duration(milliseconds: 500);
    timer =
        Timer.periodic(oneSec, (Timer t) => _privateChatBloc.dispatch(event));
    groupChatId = '';

    isLoading = false;
    isShowSticker = false;
    imageUrl = '';
  }

  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    Map<String, dynamic> body = {'message': content};
    PetPalApi().addMessage(context, body, peerId);
    if (content.trim() != '') {
      textEditingController.clear();

      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {}
  }

  Widget buildItem(int index, Chat chat) {
    if (chat.messageList.messages[index].id != peerId) {
      // Right (my message)
      return Row(
        children: <Widget>[
          Container(
            child: Text(
              chat.messageList.messages[index].message,
              style: TextStyle(color: Colors.white),
            ),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: 200.0,
            decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.only(
                bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Material(
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Container(
                          child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.deepPurple),
                          ),
                          width: 35.0,
                          height: 35.0,
                          padding: EdgeInsets.all(10.0),
                        ),
                    imageUrl:
                        Uri.http("10.27.99.28:8080", "/assets/" + photoPath)
                            .toString(),
                    width: 35.0,
                    height: 35.0,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                ),
                Container(
                  child: Text(
                    chat.messageList.messages[index].message,
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(left: 10.0),
                )
              ],
            ),

            // Time
            isLastMessageLeft(index)
                ? Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse("1000"))),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic),
                    ),
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                  )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['idFrom'] == peerId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['idFrom'] != id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onBackPress() {
    timer.cancel();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      child: Container(
          margin: EdgeInsets.only(top: 20.0),
          height: 600,
          child: Column(
            children: <Widget>[
              Flexible(
                child: BlocBuilder(
                  bloc: _privateChatBloc,
                  builder: (BuildContext context, PrivateChatState state) {
                    if (state is PrivateChatUninitialized) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is PrivateChatError) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Error loading messages",
                          style: TextStyle(
                              color: Colors.deepPurple, fontSize: 50.0),
                        ),
                      );
                    }

                    if (state is PrivateChatLoaded) {
                      if (state.chat.messageList.messages.length == 0) {
                        return Center(
                          child: Text(
                            "No messages",
                            style: TextStyle(
                                color: Colors.deepPurple, fontSize: 50.0),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.all(10.0),
                          itemBuilder: (context, index) =>
                              buildItem(index, state.chat),
                          itemCount: state.chat.messageList.messages.length,
                          reverse: true,
                          controller: listScrollController,
                        );
                      }
                    }
                  },
                ),
              ),
              buildInput(),
            ],
          )),
      onWillPop: onBackPress,
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepPurple)),
              ),
              color: Colors.white.withOpacity(0.8),
            )
          : Container(),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Edit text
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                child: TextField(
                  style: TextStyle(color: Colors.deepPurple, fontSize: 15.0),
                  controller: textEditingController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Type your message...',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  focusNode: focusNode,
                ),
              ),
            ),
          ),

          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () {
                  onSendMessage(textEditingController.text, 0);
                  //_privateChatBloc.dispatch(AddMessage(Message(message: textEditingController.text)));
                },
                color: Colors.deepOrange,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
    );
  }
}
