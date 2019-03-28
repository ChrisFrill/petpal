import 'dart:async';

import 'package:PetPal/api/petpal_api.dart';
import 'package:PetPal/blocs/liked/favourite_state.dart';

import 'package:bloc/bloc.dart';

enum LikeEvent { like, dislike, fetch}

class FavouriteBloc extends Bloc<LikeEvent, FavouriteState> {
  @override
  FavouriteState get initialState => FavouriteUninitialized();

  @override
  Stream<FavouriteState> mapEventToState(FavouriteState currentState, LikeEvent event) async* {
    if (event == LikeEvent.fetch) {
      try {
        if (currentState is FavouriteUninitialized) {
          print("object");
          print(PetPalApi().getLikedPets().toString());
          final favourites = await PetPalApi().getLikedPets();
          yield FavouriteLoaded(favourites: favourites);
        }
        if (currentState is FavouriteLoaded) {
          final favourites = await PetPalApi().getLikedPets();
          yield favourites.isEmpty
              ? currentState.copyWith()
              : FavouriteLoaded(
                  favourites: currentState.favourites + favourites,
                );
        }
      } catch (_) {
        yield FavouriteError();
      }
    }
  }
}
