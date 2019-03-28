import 'package:PetPal/models/chat/chat.dart';

abstract class ChatState  {
  ChatState([List props = const []]);
}

class ChatUninitialized extends ChatState {
  @override
  String toString() => 'ChatUninitialized';
}

class ChatError extends ChatState {
  @override
  String toString() => 'ChatError';
}

class ChatLoaded extends ChatState {
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
