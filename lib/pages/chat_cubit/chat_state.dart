
import 'package:chat_app_re/models/message.dart';
import 'package:chat_app_re/pages/chat_cubit/chat_cubit.dart';

ChatCubit object = ChatCubit();

abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class ChatSucccessState extends ChatStates {

  List<Message> messages;
  ChatSucccessState({required this.messages});
}

class ChatFailurState extends ChatStates {}