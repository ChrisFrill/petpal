import 'dart:async';

import 'package:PetPal/api/petpal_api.dart';
import 'package:PetPal/blocs/chat/private_chat_state.dart';
import 'package:bloc/bloc.dart';

enum LikeEvent { like, dislike, fetch }

class PrivateChatBloc extends Bloc<LikeEvent, PrivateChatState> {
  @override
  PrivateChatState get initialState => ChatUninitialized();

  @override
  Stream<PrivateChatState> mapEventToState(
      PrivateChatState currentState, LikeEvent event) async* {
    if (event == LikeEvent.fetch) {
      try {
        if (currentState is ChatUninitialized) {
          print("object");
          print(PetPalApi().getUserChat());
          final chats = await PetPalApi().getUserChat();
          yield ChatLoaded(chats: chats);
        }
        if (currentState is ChatLoaded) {
          final chats = await PetPalApi().getUserChat();
          yield chats.isEmpty
              ? currentState.copyWith()
              : ChatLoaded(
                  chats: currentState.chats + chats,
                );
        }
      } catch (_) {
        yield ChatError();
      }
    }
  }
}
