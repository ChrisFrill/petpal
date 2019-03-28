import 'package:PetPal/models/animal/animal.dart';
import 'package:equatable/equatable.dart';

abstract class PetsEvent extends Equatable {
  PetsEvent([List props = const []]) : super(props);
}

class DeletePet extends PetsEvent {
  final Animal pet;

  DeletePet(this.pet) : super([pet]);

  @override
  String toString() => 'DeletePet { Pet: $pet }';
}

class FetchPets extends PetsEvent {

  @override
  String toString() => 'Fetching pets';
}