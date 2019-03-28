import 'package:PetPal/models/user.dart';

class UserList {
  List<User> users = <User>[];

  UserList.fromJSON(List<dynamic> json)
    : users = (json)
                .map((item) => User.fromJSON(item)).toList();

  User findById(int id) => users.firstWhere((g) => g.id == id);
}