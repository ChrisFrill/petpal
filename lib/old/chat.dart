import 'package:PetPal/api/tokenhandler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController _controller = TextEditingController();
  var channel;
  final List<String> messages = [];
  SocketIO socketIO;
  String token;

  _connectSocket01() {
    socketIO = SocketIOManager().createSocketIO(
        "http://192.168.0.206:8080", "/greeting",
        );
    print("reached2");

    socketIO.init();
    print("reached3");

    //subscribe event
    socketIO.subscribe("/user/queue/reply", _onSocketInfo);
    print("reached4");

    //connect socket
    socketIO.connect();
        print("reached5");

  }

  _getToken() async {
    token = await TokenHandler().getMobileToken();
  }

  @override
  void initState() {
    super.initState();
    print("reached1");
    _connectSocket01();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: messages.map((m) => Text(m)).toList(),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Form(
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Send a message'),
                  ),
                ),
              ],
            ),

            // StreamBuilder(
            //   stream: channel.stream,
            //   builder: (context, snapshot) {
            //     return Padding(
            //       padding: const EdgeInsets.symmetric(vertical: 24.0),
            //       child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
            //     );
            //   },
            // )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _sendChatMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendChatMessage() async {
    if (socketIO != null) {
      String jsonData =
          '{"message":{"type":"Text","content": ${(_controller.text != null && _controller.text.isNotEmpty) ? '"${_controller.text}"' : '"Hello SOCKET IO PLUGIN :))"'},"owner":"589f10b9bbcd694aa570988d","avatar":"img/avatar-default.png"},"sender":{"userId":"589f10b9bbcd694aa570988d","first":"Ha","last":"Test 2","location":{"lat":10.792273999999999,"long":106.6430356,"accuracy":38,"regionId":null,"vendor":"gps","verticalAccuracy":null},"name":"Ha Test 2"},"receivers":["587e1147744c6260e2d3a4af"],"conversationId":"589f116612aa254aa4fef79f","name":null,"isAnonymous":null}';
      socketIO.sendMessage("/app/message", jsonData, _onReceiveChatMessage);
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}

void _onSocketInfo() {
  print("Subscribed");
}

void _onReceiveChatMessage(dynamic message) {
  print("Message from UFO: " + message);
}
