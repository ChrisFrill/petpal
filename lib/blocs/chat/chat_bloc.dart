import 'dart:async';

import 'package:PetPal/api/petpal_api.dart';
import 'package:PetPal/blocs/chat/chat_state.dart';
import 'package:bloc/bloc.dart';

enum LikeEvent { like, dislike, fetch }

class ChatBloc extends Bloc<LikeEvent, ChatState> {
  @override
  ChatState get initialState => ChatUninitialized();

  @override
  Stream<ChatState> mapEventToState(
      ChatState currentState, LikeEvent event) async* {
    if (event == LikeEvent.fetch) {
      try {
        if (currentState is ChatUninitialized) {
          print("object");
          print(PetPalApi().getUserChats());
          final chats = await PetPalApi().getUserChats();
          yield ChatLoaded(chats: chats);
        }
        if (currentState is ChatLoaded) {
          final chats = await PetPalApi().getUserChats();
          yield chats.isEmpty
              ? currentState.copyWith()
              : ChatLoaded(
                  chats: currentState.chats,
                );
        }
      } catch (_) {
        yield ChatError();
      }
    }
  }
}
