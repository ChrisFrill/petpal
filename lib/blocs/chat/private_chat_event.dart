import 'package:PetPal/models/animal/animal.dart';
import 'package:PetPal/models/chat/message.dart';
import 'package:equatable/equatable.dart';

abstract class PrivateChatEvent extends Equatable {
    int id;

  PrivateChatEvent([List props = const []]) : super(props);
}

class DeletePet extends PrivateChatEvent {
  final Animal chat;

  DeletePet(this.chat) : super([chat]);

  @override
  String toString() => 'DeletePet { Pet: $chat }';
}

class AddMessage extends PrivateChatEvent {
  final Message message;

  AddMessage(this.message) :super([message]);

}

class FetchPrivateChat extends PrivateChatEvent {
  int id;
  FetchPrivateChat({this.id}) : super([id]);

  @override
  String toString() => 'Fetching PrivateChat, id:$id';
}
