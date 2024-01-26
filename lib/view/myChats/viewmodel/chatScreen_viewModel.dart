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

  final _messages = <Message>[];
  final _messageController = StreamController<List<Message>>.broadcast();

  String senderId = "";
  String receiverId = "";

  Stream<List<Message>> get messages => _messageController.stream;

  void sendMessage(String message) {
    final newMessage = Message(
      sender: senderId,
      content: message,
    );

    _messages.add(newMessage);
    _messageController.add(_messages);
  }

  ApiResponse<GetAllMessages> myChatData = ApiResponse.idle();

  fetchAllMessages(BuildContext context) async {
    myChatData = ApiResponse.loading();
    _repo
        .fetchAllMessages("65a5fe63290c3bfe7e36d1bb")
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                myChatData = ApiResponse.completed(value),
              }
            else
              {
                myChatData = ApiResponse.error(""),
                showSnackBar(context, "There is some issue at our end"),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            myChatData = ApiResponse.error(""),
            showSnackBar(
                context, "There is some issue at our end, please retry"),
            notifyListeners()
          },
        );
  }
}
