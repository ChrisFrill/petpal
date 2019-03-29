import 'dart:async';

import 'package:PetPal/api/petpal_api.dart';
import 'package:PetPal/blocs/chat/private_chat_event.dart';
import 'package:PetPal/blocs/chat/private_chat_state.dart';
import 'package:PetPal/models/chat/chat.dart';
import 'package:PetPal/models/chat/message.dart';
import 'package:PetPal/models/chat/message_list.dart';
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
                  chat: Chat(messageList: MessageList(messages: chat.messageList.messages)),
                );
        }
      } catch (_) {
        yield PrivateChatError();
      }
    } else if (event is AddMessage) {
      print("addmessage");
      yield* _mapAddPrivateChatToState(currentState, event);
    }
  }

  Stream<PrivateChatState> _mapAddPrivateChatToState(
    PrivateChatState currentState,
    AddMessage event,
  ) async* {
    if (currentState is PrivateChatLoaded) {
      final List<Message> updatedMessages =
          List.from(currentState.chat.messageList.messages)..add(event.message);
      currentState.chat.messageList.messages = updatedMessages;
      yield PrivateChatLoaded();
    }
  }
}
