import 'package:PetPal/models/animal/animal.dart';
import 'package:PetPal/models/user_list.dart';

class Chat extends Object {
  int id;
  UserList users;
  Animal animal;

  Chat({this.id, this.users, this.animal});

  Chat.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        users = UserList.fromJSON(json['users']),
        animal = Animal.fromJSON(json['animal']);

  @override
  String toString() => '$runtimeType($id, name: $users, $animal)';
}

