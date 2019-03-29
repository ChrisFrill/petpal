import 'package:PetPal/models/chat/chat.dart';

abstract class PrivateChatState  {
  PrivateChatState([List props = const []]);
}

class PrivateChatUninitialized extends PrivateChatState {
  @override
  String toString() => 'ChatUninitialized';
}

class PrivateChatError extends PrivateChatState {
  @override
  String toString() => 'ChatError';
}

class PrivateChatLoaded extends PrivateChatState {
  final Chat chat;

  PrivateChatLoaded({
    this.chat,
  }) : super([chat]);

  PrivateChatLoaded copyWith({
    List<Chat> chats,
  }) {
    return PrivateChatLoaded(
      chat: chat ?? this.chat,
    );
  }

  @override
  String toString() =>
      'ChatLoaded { chat: $chat}';
}
