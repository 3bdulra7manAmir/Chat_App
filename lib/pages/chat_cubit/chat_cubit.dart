import 'package:bloc/bloc.dart';
import 'package:chat_app_re/constants.dart';
import 'package:chat_app_re/models/message.dart';
import 'package:chat_app_re/pages/chat_cubit/chat_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatCubit extends Cubit<ChatStates>
{
  ChatCubit() : super(ChatInitialState());


  CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollections);
  List<Message> messagesList = [];

  void sendMessage({required String message, String? email})
  {
    try
    {
      messages.add({kMessage: message, kCreatedAt: DateTime.now(), 'id' : email });
    } on Exception catch (e)
    {
      print(e);
      emit(ChatFailurState());
    }
  }


  void getMessages()
  {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event)
    {
      messagesList.clear();
      for (var doc in event.docs)
      {
        messagesList.add(Message.fromJson(doc));
      }
      print("success");
      emit(ChatSucccessState(messages: messagesList));
    });
  }

}
