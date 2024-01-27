// chat_view_model.dart
import 'dart:async';

import 'package:gear_up/data/response/api_response.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/view/myChats/model/body/sendMessage_body.dart';
import 'package:gear_up/view/myChats/model/response/getAllMessages_response.dart';
import 'package:gear_up/view/myChats/model/response/sendMessage_response.dart';
import 'package:gear_up/view/myChats/repo/chatScreen_repo.dart';
import 'package:stacked/stacked.dart';

class ChatViewModel extends BaseViewModel {
  final _repo = ChatRepository();
  List<Message> messages = [];
  String senderId = "65957c913b8e563ac1344a3d";
  String receiverId = "";

  bool chatFetched = false;

  ApiResponse<GetAllMessages> myChatData = ApiResponse.idle();

  Future<List<Message>> fetchAllMessages() async {

    //initialize senderID with userId here

    myChatData = ApiResponse.loading();
    _repo
        .fetchAllMessages("65a5fe63290c3bfe7e36d1bb")
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                myChatData = ApiResponse.completed(value),
                messages.addAll(value.messages!),
                chatFetched = true,
                // _messageController.add(_messages),
              }
            else
              {
                myChatData = ApiResponse.error(""),
                chatFetched = false,
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            myChatData = ApiResponse.error(""),
                chatFetched = false,
            notifyListeners()
          },
        );

    return messages;
  }

  SendMessageBody sendMessageBody = SendMessageBody();
  ApiResponse<SendMessageResponse> sendSingleMessagesResponse = ApiResponse.idle();

  sendSingleMessages(String content) async {

    final newMessage = Message(
      sender: senderId,
      content: content,
    );

    messages.add(newMessage);
    notifyListeners();

    sendMessageBody.content = content;
    sendMessageBody.chatId = "65a5fe63290c3bfe7e36d1bb";

    dynamic data = sendMessageBody.toJson();

    sendSingleMessagesResponse = ApiResponse.loading();
    _repo
        .sendMessage(data)
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                sendSingleMessagesResponse = ApiResponse.completed(value),
              }
            else
              {
                sendSingleMessagesResponse = ApiResponse.error(""),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            sendSingleMessagesResponse = ApiResponse.error(""),
            notifyListeners()
          },
        );
  }
}
