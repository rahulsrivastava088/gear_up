import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gear_up/data/response/api_response.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/view/myChats/model/body/create_game_body.dart';
import 'package:gear_up/view/myChats/model/body/sendMessage_body.dart';
import 'package:gear_up/view/myChats/model/response/create_game_response.dart';
import 'package:gear_up/view/myChats/model/response/getAllMessages_response.dart';
import 'package:gear_up/view/myChats/model/response/sendMessage_response.dart';
import 'package:gear_up/view/myChats/repo/chat_repository.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/custom_snackbar.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

class ChatViewModel extends BaseViewModel {
  final _repo = ChatRepository();
  List<Message> messages = [];
  String receiverId = "";

  bool chatFetched = false;

  ApiResponse<GetAllMessages> myChatData = ApiResponse.idle();

  Future<List<Message>> fetchAllMessages(String chatID) async {
    //initialize senderID with userId here

    myChatData = ApiResponse.loading();
    _repo
        .fetchAllMessages(chatID)
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
                chatFetched = true,
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            print(error),
            myChatData = ApiResponse.error(""),
            chatFetched = true,
            notifyListeners()
          },
        );

    return messages;
  }

  SendMessageBody sendMessageBody = SendMessageBody();
  ApiResponse<SendMessageResponse> sendSingleMessagesResponse =
      ApiResponse.idle();

  sendSingleMessages(String content, String chatID) async {
    final newMessage = Message(
      sender: myUserID,
      content: content,
    );

    messages.add(newMessage);
    notifyListeners();

    sendMessageBody.content = content;
    sendMessageBody.chatId = chatID;

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

  ApiResponse<CreateGameResponse> createGameResponse = ApiResponse.idle();
  CreateGameBody createGameBody = CreateGameBody();

  createGame(
    BuildContext context,
    DateTime selectedDate,
    TimeOfDay selectedTime,
    int selectedSport,
    String? venueID,
  ) async {
    createGameResponse = ApiResponse.loading();
    notifyListeners();
    selectedDate = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, selectedTime.hour, selectedTime.minute);
    print(selectedDate);
    createGameBody.matchDate = selectedDate.millisecondsSinceEpoch;
    createGameBody.venue = venueID;
    createGameBody.sport = getSportID(selectedSport);
    createGameBody.player2 = '6553184790ef89ef840a6359';
    _repo
        .createGame(createGameBody)
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {createGameResponse = ApiResponse.completed(value), context.pop()}
            else
              {
                createGameResponse = ApiResponse.error(""),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            createGameResponse = ApiResponse.error(""),
            notifyListeners(),
          },
        );
  }

  updateGame(
    BuildContext context,
    String? gameID, {
    String? gameStatus,
    String? cancelledBy,
    String? cancelMessage,
    DateTime? matchDate,
    String? sportID,
    String? venueID,
  }) async {
    print("update method called");
    print("gameid: $gameID");
    if (gameID == null) {
      return;
    }
    Map<String, dynamic> updateRequestBody = {
      'gameStatus': gameStatus,
      "cancelledBy": cancelledBy,
      "cancelMessage": cancelMessage,
      "matchDate": matchDate?.millisecondsSinceEpoch,
      "sport": sportID,
      "venue": venueID
    };
    print("update request body: $updateRequestBody");
    _repo
        .updateGame(updateRequestBody, gameID)
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                customSnackBar(context, "Game is updated, kindly refresh"),
                // what to do after updation is done
                print("game is updated, kindly refresh")
              }
            else
              {
                print("couldn't update game"),
                // show a custom message
                customSnackBar(context, "Couldn't update the game")
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            // show a custom message
            customSnackBar(context, "Couldn't update the game"),

            print("couldn't update game due to some error: $error"),
            notifyListeners(),
          },
        );
  }

  cancelGame(
    BuildContext context,
    String? gameID, {
    String? cancelMessage,
  }) {
    updateGame(
      context,
      gameID,
      gameStatus: "Cancelled",
      cancelledBy: myUserID,
      cancelMessage: cancelMessage,
    );
  }

  declineGame(
    BuildContext context,
    String? gameID,
  ) {
    updateGame(
      context,
      gameID,
      gameStatus: "Declined",
    );
  }

  acceptGame(
    BuildContext context,
    String? gameID,
  ) {
    updateGame(
      context,
      gameID,
      gameStatus: "Accepted",
    );
  }

  rescheduleGame(
    BuildContext context,
    String? gameID,
    DateTime selectedDate,
    TimeOfDay selectedTime,
    int selectedSport,
    String? venueID,
  ) {
    print("reschedule method called");
    selectedDate = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, selectedTime.hour, selectedTime.minute);
    updateGame(
      context,
      gameID,
      matchDate: selectedDate,
      sportID: getSportID(selectedSport),
      venueID: venueID,
    );
  }

  void clearData() {
    print("clear Data called");
    chatFetched = false;
    messages = [];
    receiverId = "";
    myChatData = ApiResponse.idle();
    sendMessageBody = SendMessageBody();
    sendSingleMessagesResponse = ApiResponse.idle();
    createGameResponse = ApiResponse.idle();
    createGameBody = CreateGameBody();
  }
}
