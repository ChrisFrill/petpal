class User extends Object {
  int id;
  String name;
  String email;

  User({this.id, this.name});

  User.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'];

  @override
  String toString() => '$runtimeType($id, name: $name, $email)';
}
