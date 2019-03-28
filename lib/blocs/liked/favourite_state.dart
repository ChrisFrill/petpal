import 'package:PetPal/models/animal/animal.dart';

abstract class FavouriteState  {
  FavouriteState([List props = const []]);
}

class FavouriteUninitialized extends FavouriteState {
  @override
  String toString() => 'FavouriteUninitialized';
}

class FavouriteError extends FavouriteState {
  @override
  String toString() => 'FavouriteError';
}

class FavouriteLoaded extends FavouriteState {
  final List<Animal> favourites;

  FavouriteLoaded({
    this.favourites,
  }) : super([favourites]);

  FavouriteLoaded copyWith({
    List<Animal> favourites,
    bool hasReachedMax,
  }) {
    return FavouriteLoaded(
      favourites: favourites ?? this.favourites,
    );
  }

  @override
  String toString() =>
      'FavouriteLoaded { Favourites: ${favourites.length}}';
}
