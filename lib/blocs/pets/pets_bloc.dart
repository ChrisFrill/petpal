import 'dart:async';

import 'package:PetPal/api/petpal_api.dart';
import 'package:PetPal/blocs/pets/pets_event.dart';
import 'package:PetPal/blocs/pets/pets_state.dart';

import 'package:bloc/bloc.dart';


class PetsBloc extends Bloc<PetsEvent, PetsState> {
  @override
  PetsState get initialState => PetsUninitialized();

  @override
  Stream<PetsState> mapEventToState(
      PetsState currentState, PetsEvent event) async* {
    if (event == FetchPets()) {
      try {
        if (currentState is PetsUninitialized) {
          final pets = await PetPalApi().getPets();
          print(pets);
          yield PetsLoaded(pets: pets);
        }
        if (currentState is PetsLoaded) {
          final pets = await PetPalApi().getPets();
          yield pets.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PetsLoaded(
                  pets: currentState.pets + pets,
                );
        }
      } catch (_) {
        yield PetsError();
      }
    } else if (event is DeletePet) {
      yield* _mapDeletePetToState(currentState, event);
    }
  }

  Stream<PetsState> _mapDeletePetToState(
    PetsState currentState,
    DeletePet event,
  ) async* {
    if (currentState is PetsLoaded) {
      final updatedPets =
          currentState.pets.where((pet) => pet.id != event.pet.id).toList();
      yield PetsLoaded(pets: updatedPets);
    }
  }
}
