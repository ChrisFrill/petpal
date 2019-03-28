import 'package:PetPal/models/animal/animal.dart';

abstract class ToAdoptState  {
  ToAdoptState([List props = const []]);
}

class ToAdoptUninitialized extends ToAdoptState {
  @override
  String toString() => 'ToAdoptUninitialized';
}

class ToAdoptError extends ToAdoptState {
  @override
  String toString() => 'ToAdoptError';
}

class ToAdoptLoaded extends ToAdoptState {
  final List<Animal> petsToAdopt;

  ToAdoptLoaded({
    this.petsToAdopt,
  }) : super([petsToAdopt]);

  ToAdoptLoaded copyWith({
    List<Animal> petsToAdopt,
    bool hasReachedMax,
  }) {
    return ToAdoptLoaded(
      petsToAdopt: petsToAdopt ?? this.petsToAdopt,
    );
  }

  @override
  String toString() =>
      'ToAdoptLoaded { petsToAdopt: ${petsToAdopt.length}}';
}
