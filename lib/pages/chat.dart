import 'package:PetPal/blocs/chat/chat_bloc.dart';
import 'package:PetPal/widgets/lists/chat_user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        bloc: ChatBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[Text('Chat')],
            ),
          ),
          body: ChatUsers(),
        ),
      ),
    );
  }
}
