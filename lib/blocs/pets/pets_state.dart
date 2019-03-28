
import 'package:PetPal/models/animal/animal.dart';

abstract class PetsState  {
  PetsState([List props = const []]);
}

class PetsUninitialized extends PetsState {
  @override
  String toString() => 'PetsUninitialized';
}

class PetsError extends PetsState {
  @override
  String toString() => 'PetsError';
}

class PetsLoaded extends PetsState {
  final List<Animal> pets;

  PetsLoaded({
    this.pets,
  }) : super([pets]);

  PetsLoaded copyWith({
    List<Animal> pets,
    bool hasReachedMax,
  }) {
    return PetsLoaded(
      pets: pets ?? this.pets,
    );
  }

  @override
  String toString() =>
      'PetsLoaded { Petss: ${pets.length}}';
}
