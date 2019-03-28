class Animal extends Object {
  int id;
  String name;
  DateTime birthDate;
  String type;
  String gender;
  DateTime fromWhenAvailable;
  String photoPath;
  String spayed;
  String vaccinated;
  String adopted;

  Animal({this.id, this.name});

  Animal.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = json['type'],
        photoPath = json['photoPath'];

  @override
  String toString() => '$runtimeType($id, name: $name, $photoPath, $type)';
}
