import 'package:PetPal/models/animal/animal.dart';
import 'package:PetPal/models/user.dart';

class Message extends Object {
  int id;
  User user;
  String message;

  Message({this.id, this.user, this.message});

  Message.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        user = User.fromJSON(json['author']),
        message = json['message'];

  @override
  String toString() => '$runtimeType($id, name: $user)';
}

