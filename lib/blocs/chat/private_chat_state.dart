import 'package:PetPal/models/chat/chat.dart';

abstract class PrivateChatState  {
  PrivateChatState([List props = const []]);
}

class ChatUninitialized extends PrivateChatState {
  @override
  String toString() => 'ChatUninitialized';
}

class ChatError extends PrivateChatState {
  @override
  String toString() => 'ChatError';
}

class ChatLoaded extends PrivateChatState {
  final List<Chat> chats;

  ChatLoaded({
    this.chats,
  }) : super([chats]);

  ChatLoaded copyWith({
    List<Chat> chats,
  }) {
    return ChatLoaded(
      chats: chats ?? this.chats,
    );
  }

  @override
  String toString() =>
      'ChatLoaded { chats: ${chats.length}}';
}
