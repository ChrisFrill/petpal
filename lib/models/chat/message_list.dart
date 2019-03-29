import 'package:PetPal/models/chat/message.dart';

class MessageList {
  List<Message> messages = <Message>[];

  MessageList({this.messages});

  MessageList.fromJSON(List<dynamic> json)
    : messages = (json)
                .map((item) => Message.fromJSON(item)).toList().reversed.toList();

  Message findById(int id) => messages.firstWhere((g) => g.id == id);
}