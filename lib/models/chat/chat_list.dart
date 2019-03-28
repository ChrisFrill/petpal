

import 'package:PetPal/models/chat/chat.dart';

class ChatList {
  List<Chat> chats = <Chat>[];

  ChatList.fromJSON(List<dynamic> json)
    : chats = (json)
                .map((item) => Chat.fromJSON(item)).toList();

  Chat findById(int id) => chats.firstWhere((g) => g.id == id);
}