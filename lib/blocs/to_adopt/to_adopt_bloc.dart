import 'dart:async';

import 'package:PetPal/api/petpal_api.dart';
import 'package:PetPal/blocs/to_adopt/to_adopt_state.dart';
import 'package:bloc/bloc.dart';

enum LikeEvent { like, dislike, fetch}

class ToAdoptBloc extends Bloc<LikeEvent, ToAdoptState> {
  @override
  ToAdoptState get initialState => ToAdoptUninitialized();

  @override
  Stream<ToAdoptState> mapEventToState(ToAdoptState currentState, LikeEvent event) async* {
    if (event == LikeEvent.fetch) {
      try {
        if (currentState is ToAdoptUninitialized) {
          final petsToAdopt = await PetPalApi().getPetsToAdopt();
          yield ToAdoptLoaded(petsToAdopt: petsToAdopt);
        }
        if (currentState is ToAdoptLoaded) {
          final petsToAdopt = await PetPalApi().getPetsToAdopt();
          yield petsToAdopt.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ToAdoptLoaded(
                  petsToAdopt: currentState.petsToAdopt + petsToAdopt,
                );
        }
      } catch (_) {
        yield ToAdoptError();
      }
    }
  }
  

  
}
