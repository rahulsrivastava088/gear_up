// chat_view_model.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gear_up/data/response/api_response.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/utils/utilities.dart';
import 'package:gear_up/view/myChats/model/getAllMessages_response.dart';
import 'package:gear_up/view/myChats/repo/chatScreen_repo.dart';
import 'package:stacked/stacked.dart';

class ChatViewModel extends BaseViewModel {
  final _repo = ChatRepository();
  List<Message> messages = [];
  String senderId = "";
  String receiverId = "";

  void sendMessage(String message) {
    final newMessage = Message(
      sender: senderId,
      content: message,
    );

    messages.add(newMessage);
  }

  bool chatFetched = false;

  ApiResponse<GetAllMessages> myChatData = ApiResponse.idle();

  Future<List<Message>> fetchAllMessages(BuildContext context) async {

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
                showSnackBar(context, "There is some issue at our end"),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            myChatData = ApiResponse.error(""),
                chatFetched = false,
            showSnackBar(
                context, "There is some issue at our end, please retry"),
            notifyListeners()
          },
        );

        return messages;
  }
}
