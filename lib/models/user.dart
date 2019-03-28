class User extends Object {
  int id;
  String username;
  String email;

  User({this.id, this.username});

  User.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'];

  @override
  String toString() => '$runtimeType($id, name: $username, $email)';
}
