import 'package:PetPal/models/animal/animal.dart';
import 'package:PetPal/models/user.dart';

class Chat extends Object {
  int id;
  List<User> users;
  Animal animal;

  Chat({this.id, this.users, this.animal});

  Chat.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        users = json['users'],
        animal = json['animal'];

  @override
  String toString() => '$runtimeType($id, name: $users, $animal)';
}

