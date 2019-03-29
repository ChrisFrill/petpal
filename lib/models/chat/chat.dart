import 'package:PetPal/models/animal/animal.dart';
import 'package:PetPal/models/chat/message.dart';
import 'package:PetPal/models/chat/message_list.dart';
import 'package:PetPal/models/user_list.dart';

class Chat extends Object {
  int id;
  UserList users;
  Animal animal;
  MessageList messageList;

  Chat({this.id, this.users, this.animal, this.messageList});

  Chat.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        users = UserList.fromJSON(json['users']),
        animal = Animal.fromJSON(json['animal']),
        messageList = MessageList.fromJSON(json['messages']);

  @override
  String toString() => '$runtimeType($id, name: $users, $animal, $messageList)';
}

