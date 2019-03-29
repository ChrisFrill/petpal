import 'dart:async';

import 'package:PetPal/api/petpal_api.dart';
import 'package:PetPal/blocs/chat/private_chat_event.dart';
import 'package:PetPal/blocs/chat/private_chat_state.dart';
import 'package:bloc/bloc.dart';

enum LikeEvent { like, dislike, fetch }

class PrivateChatBloc extends Bloc<PrivateChatEvent, PrivateChatState> {
  int id;

  PrivateChatBloc({this.id});

  @override
  PrivateChatState get initialState => PrivateChatUninitialized();

  @override
  Stream<PrivateChatState> mapEventToState(
      PrivateChatState currentState, PrivateChatEvent event) async* {
    if (event is FetchPrivateChat) {
      try {
        if (currentState is PrivateChatUninitialized) {
          print("object");
          print(event.id);
          print(event);
          print(PetPalApi().getUserChat(event.id));
          final chat = await PetPalApi().getUserChat(event.id);
          yield PrivateChatLoaded(chat: chat);
        }
        if (currentState is PrivateChatLoaded) {
          final chat = await PetPalApi().getUserChat(event.id);
          yield chat == null
              ? currentState.copyWith()
              : PrivateChatLoaded(
                  chat: currentState.chat,
                );
        }
      } catch (_) {
        yield PrivateChatError();
      }
    }
  }
}
