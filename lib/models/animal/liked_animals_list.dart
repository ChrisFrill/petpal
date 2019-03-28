import 'package:PetPal/models/animal/animal.dart';

class LikedAnimalsList {
  List<Animal> animals = <Animal>[];

  LikedAnimalsList.fromJSON(List<dynamic> json)
    : animals = (json)
                .map((item) => Animal.fromJSON(item)).toList();

  Animal findById(int id) => animals.firstWhere((g) => g.id == id);
}