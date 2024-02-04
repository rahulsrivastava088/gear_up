import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/view/chat/schedule_match_bottom_sheet.dart';
import 'package:gear_up/view/myChats/model/response/getAllMessages_response.dart';
import 'package:gear_up/view/myChats/ui/decline_bottom_sheet.dart';
import 'package:gear_up/view/myChats/ui/edit_cancel_bottom_sheet.dart';
import 'package:gear_up/view/myChats/ui/receivingChatComp.dart';
import 'package:gear_up/view/myChats/ui/sendingChatComp.dart';
import 'package:gear_up/view/myChats/viewmodel/chat_view_model.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/details_card.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../colors/Colors.dart';
import '../../../utils/utilities.dart';
import '../model/response/fetch_all_chats_response.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;
  const ChatScreen({Key? key, required this.chat}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    print("chat: ${widget.chat}");
  }

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ChatViewModel>(context);
    return Scaffold(
      appBar: _chatAppBar(context, model),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    UserDetailsCard(
                      userImage: widget.chat.receiver?.img,
                      userName: widget.chat.receiver?.name,
                      userAge: widget.chat.receiver?.age,
                      userGender: widget.chat.receiver?.gender,
                      userLocation: null,
                    ),
                    chatMessagesWidget(model),
                  ],
                ),
              ),
            ),
            scheduleAMatchWidget(context),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 44,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF1E1E1E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                sendMessageWidget(model)
              ],
            )
          ],
        ),
      ),
    );
  }

  Container sendMessageWidget(ChatViewModel model) {
    return Container(
      width: 44,
      height: 44,
      decoration: ShapeDecoration(
        color: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: IconButton(
        icon: const Icon(Icons.north_east),
        onPressed: () {
          if (_messageController.text.isNotEmpty) {
            model.sendSingleMessages(
              _messageController.text,
              widget.chat.id ?? '',
            );
            _messageController.clear();
          }
        },
      ),
    );
  }

  GestureDetector scheduleAMatchWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          useRootNavigator: true,
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          constraints: const BoxConstraints(minWidth: double.infinity),
          builder: (BuildContext context) {
            return const SafeArea(
                child: Scaffold(
                    body: ScheduleMatchBottomSheet(
              isReschedule: false,
            )));
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFF0095F6)),
              borderRadius: BorderRadius.circular(80),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Schedule a Match',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF0095F6),
                  fontSize: 14,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget chatMessagesWidget(ChatViewModel model) {
    return !model.chatFetched
        ? FutureBuilder<List<Message>>(
            future: model.fetchAllMessages(
              widget.chat.id ?? '',
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No messages'),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  if (model.messages[index].isGame == false) {
                    final message = model.messages[index];
                    final isCurrentUser = message.sender == myUserID;
                    return isCurrentUser
                        ? SendingChatComp(message: message.content ?? '')
                        : ReceivingChatComp(message: message.content ?? '');
                  } else if (model.messages[index].isGame == true) {
                    return gameCardWidget(model, index);
                  } else {
                    return Container();
                  }
                },
              );
            },
          )
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: model.messages.length,
            itemBuilder: (context, index) {
              if (model.messages[index].isGame == false) {
                final message = model.messages[index];
                final isCurrentUser = message.sender == myUserID;
                return isCurrentUser
                    ? SendingChatComp(message: message.content ?? '')
                    : ReceivingChatComp(message: message.content ?? '');
              } else if (model.messages[index].isGame == true) {
                return gameCardWidget(model, index);
              } else {
                return Container();
              }
            },
          );
  }

  Widget gameCardWidget(ChatViewModel model, int index) {
    if (model.messages[index].game?.gameStatus == "Pending") {
      return matchPendingWidget(model, index);
    } else if (model.messages[index].game?.gameStatus == "Declined") {
      if (model.messages[index].game?.player1 == myUserID) {
        return matchDeclinedForUserWidget();
      } else if (model.messages[index].game?.player2 == myUserID) {
        return matchDeclinedForOpponentWidget();
      }
    } else if (model.messages[index].game?.gameStatus == "Cancelled") {
      if (model.messages[index].game?.cancelledBy == myUserID) {
        return matchCancelledForUserWidget(
            getSportName(model.messages[index].game?.sport));
      } else {
        return matchCancelledForUserWidget(
            getSportName(model.messages[index].game?.sport));
      }
    } else if (model.messages[index].game?.gameStatus == "Accepted") {
      return matchConfirmedWidget(model, index);
    }
    return Container();
  }

  Container matchConfirmedWidget(ChatViewModel model, int index) {
    return Container(
      width: 186,
      height: 128,
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: const Color(0xFF333333),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                padding: const EdgeInsets.all(12),
                decoration: ShapeDecoration(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Icon(
                  Icons.done,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getSportName(model.messages[index].game?.sport),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    'Confirmed',
                    style: TextStyle(
                      color: Color(0xFFAFAFAF),
                      fontSize: 14,
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                useRootNavigator: true,
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                constraints: const BoxConstraints(minWidth: double.infinity),
                builder: (BuildContext context) {
                  return Wrap(children: [
                    gameDetailsBottomSheet(model, index, context)
                  ]);
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: ShapeDecoration(
                color: const Color(0xFFF6F6F6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'View Details',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column gameDetailsBottomSheet(
      ChatViewModel model, int index, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 24, bottom: 24, left: 24, right: 24),
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getSportName(model.messages[index].game?.sport),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'General Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          'Match Details',
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 16,
                            fontFamily: 'Space Grotesk',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              gameDetailsInnerCardWidget(model, index),
              const SizedBox(height: 16),
              acceptedStateGameDetailsBottomSheetBottomButtons(model, index)
            ],
          ),
        ),
      ],
    );
  }

  final _cancelMessageTextEditingController = TextEditingController();

  Column cancelMatchByOpponentAfterConfirmationBottomSheet(
      ChatViewModel model, int index, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 24, bottom: 24, left: 24, right: 24),
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Cancel Match',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'General Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              const Text(
                'Are you sure, you want to Cancel this match request?',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Why are you canceling?',
                style: TextStyle(
                  color: Color(0xFF141414),
                  fontSize: 12,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _cancelMessageTextEditingController,
                style: const TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  hintText: 'Write here...',
                  hintStyle: TextStyle(
                    color: Color(0xFF6B6B6B),
                    fontSize: 14,
                    fontFamily: 'Space Grotesk',
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF6B6B6B), // Change the color here
                      width: 1.0, // Adjust the width as needed
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF6B6B6B), // Change the color here
                      width: 1.0, // Adjust the width as needed
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF6F6F6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          'Back',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'General Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        model.cancelGame(
                          context,
                          model.messages[index].game?.id,
                          cancelMessage: _cancelMessageTextEditingController
                              .text
                              .trim()
                              .toString(),
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: ShapeDecoration(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          'Yes, Cancel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'General Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Column cancelMatchByUserAfterConfirmationBottomSheet(
      ChatViewModel model, int index, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 24, bottom: 24, left: 24, right: 24),
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Cancel Request',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'General Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              const Text(
                'Are you sure, You want to cancel this match request? You can always edit the request if you have any change in plan.',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 36),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        Navigator.pop(context);
                        editGame(model, index);
                      },
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF6F6F6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          'Go to Edit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'General Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        // handle cancelling the match with cancel message
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: ShapeDecoration(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          'Yes, Cancel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'General Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget matchDeclinedForUserWidget() {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 20,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: ShapeDecoration(
        color: const Color(0xFF333333),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Match Request',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Declined',
            style: TextStyle(
              color: Color(0xFFAFAFAF),
              fontSize: 14,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  Widget matchDeclinedForOpponentWidget() {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 20,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: ShapeDecoration(
        color: const Color(0xFF333333),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Match Invite',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Declined by you',
            style: TextStyle(
              color: Color(0xFFAFAFAF),
              fontSize: 14,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  Widget matchCancelledForUserWidget(String sportName) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 20,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: ShapeDecoration(
        color: const Color(0xFF333333),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$sportName Match",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w700,
            ),
          ),
          const Text(
            'Cancelled',
            style: TextStyle(
              color: Color(0xFFAFAFAF),
              fontSize: 14,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  Container matchPendingWidget(ChatViewModel model, int index) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 0),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
            'Match Details',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'General Sans',
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            getSportName(model.messages[index].game?.sport),
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 12,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          gameDetailsInnerCardWidget(model, index),
          const SizedBox(height: 24),
          pendingStateGameCardBottomButtons(model, index),
        ],
      ),
    );
  }

  Container gameDetailsInnerCardWidget(ChatViewModel model, int index) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFFE2E2E2),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              children: [
                const Icon(
                  (Icons.calendar_month),
                  size: 16,
                  color: Colors.black,
                ),
                const SizedBox(width: 6),
                const SizedBox(
                  width: 60,
                  child: Text(
                    'Schedule',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 12,
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  formatEpochToTime(model.messages[index].game?.createdDate),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Space Grotesk',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  formatEpochToDate(model.messages[index].game?.createdDate),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Space Grotesk',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 6),
          const Divider(height: 1, color: Color(0xFFE2E2E2)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              children: [
                const Icon(
                  (Icons.location_on_outlined),
                  size: 16,
                  color: Colors.black,
                ),
                const SizedBox(width: 6),
                const SizedBox(
                  width: 60,
                  child: Text(
                    'Venue',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 12,
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  model.messages[index].game?.venue?.location?.lat ?? '-',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Space Grotesk',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pendingStateGameCardBottomButtons(ChatViewModel model, int index) {
    if (model.messages[index].sender == myUserID) {
      return GestureDetector(
        onTap: () {
          editCancelGamePendingStateBottomSheet().then((value) {
            if (value == 0) {
              editGame(model, index);
            } else if (value == 1) {
              model.updateGame(context, model.messages[index].game?.id,
                  gameStatus: "Cancelled", cancelledBy: myUserID);
            }
          });
        },
        child: Container(
          width: double.infinity,
          height: 48,
          padding: const EdgeInsets.only(
            top: 12,
            left: 16,
            right: 12,
            bottom: 12,
          ),
          decoration: ShapeDecoration(
            color: const Color(0xFFF6F6F6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Request Sent',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 6),
              Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 24),
            ],
          ),
        ),
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                showAcceptRejectBottomSheet().then((value) {
                  if (value == true) {
                    model.declineGame(context, model.messages[index].game?.id);
                  }
                });
              },
              child: Container(
                width: double.infinity,
                height: 48,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF6F6F6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Decline',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () {
                model.acceptGame(context, model.messages[index].game?.id);
              },
              child: Container(
                height: 48,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: ShapeDecoration(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Accept',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget acceptedStateGameDetailsBottomSheetBottomButtons(
      ChatViewModel model, int index) {
    if (model.messages[index].sender == myUserID) {
      return GestureDetector(
        onTap: () {
          editCancelGameAcceptedStateBottomSheet().then((value) {
            if (value == 0) {
              editGame(model, index);
            } else if (value == 1) {
              showModalBottomSheet(
                useRootNavigator: true,
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                constraints: const BoxConstraints(minWidth: double.infinity),
                builder: (BuildContext context) {
                  return Wrap(children: [
                    cancelMatchByUserAfterConfirmationBottomSheet(
                        model, index, context)
                  ]);
                },
              );
            }
          });
        },
        child: Container(
          width: double.infinity,
          height: 48,
          padding: const EdgeInsets.only(
            top: 12,
            left: 16,
            right: 12,
            bottom: 12,
          ),
          decoration: ShapeDecoration(
            color: const Color(0xFFF6F6F6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'More',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 6),
              Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 24),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          // cancel the match after it is accepted
          showModalBottomSheet(
            useRootNavigator: true,
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            constraints: const BoxConstraints(minWidth: double.infinity),
            builder: (BuildContext context) {
              return Wrap(children: [
                cancelMatchByOpponentAfterConfirmationBottomSheet(
                    model, index, context)
              ]);
            },
          );
        },
        child: Container(
          width: double.infinity,
          height: 48,
          padding: const EdgeInsets.only(
            top: 12,
            left: 16,
            right: 12,
            bottom: 12,
          ),
          decoration: ShapeDecoration(
            color: const Color(0xFFF6F6F6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text(
            'Cancel Match',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'General Sans',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
  }

  Future<bool> showAcceptRejectBottomSheet() async {
    Completer<bool> completer = Completer<bool>();

    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: const BoxConstraints(minWidth: double.infinity),
      builder: (BuildContext context) {
        return Wrap(
            children: [DeclineGameRequestBottomSheet(completer: completer)]);
      },
    );

    return completer.future;
  }

  Future<int> editCancelGamePendingStateBottomSheet() async {
    Completer<int> completer = Completer<int>();

    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: const BoxConstraints(minWidth: double.infinity),
      builder: (BuildContext context) {
        return Wrap(children: [
          EditCancelGameBottomSheet(
            completer: completer,
            isAccepted: false,
          )
        ]);
      },
    );

    return completer.future;
  }

  Future<int> editCancelGameAcceptedStateBottomSheet() async {
    Completer<int> completer = Completer<int>();

    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: const BoxConstraints(minWidth: double.infinity),
      builder: (BuildContext context) {
        return Wrap(children: [
          EditCancelGameBottomSheet(
            completer: completer,
            isAccepted: true,
          )
        ]);
      },
    );

    return completer.future;
  }

  AppBar _chatAppBar(BuildContext context, ChatViewModel model) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      centerTitle: false,
      toolbarHeight: 68,
      backgroundColor: cardBgColor,
      automaticallyImplyLeading: false,
      actions: [
        PopupMenuButton(
          onSelected: (value) {
            if (value == 1) {
              showSnackBar(context, "Share option coming in next release");
            }
          },
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          color: Colors.white,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 1,
              child: Row(
                children: [
                  Icon(
                    Icons.share_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Share Profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          ],
          child: Container(
            margin: const EdgeInsets.only(right: 18),
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFF333333)),
                borderRadius: BorderRadius.circular(80),
              ),
            ),
            child: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ),
      ],
      title: InkWell(
        onTap: () {
          if (context.canPop()) {
            model.clearData();
            context.pop();
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.arrow_back, color: Colors.white, size: 24),
            const SizedBox(width: 16),
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(14),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/person_image.png',
                  image: widget.chat.receiver?.img ?? '',
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/person_image.png",
                      width: 4,
                      height: 4,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.chat.receiver?.name ?? '-',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'General Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  editGame(ChatViewModel model, int index) {
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: const BoxConstraints(minWidth: double.infinity),
      builder: (BuildContext context) {
        return SafeArea(
          child: Scaffold(
            body: ScheduleMatchBottomSheet(
              isReschedule: true,
              gameId: model.messages[index].game?.id,
              sportIndex: getSportIndex(model.messages[index].game?.sport),
              date: DateTime.fromMillisecondsSinceEpoch(
                model.messages[index].game?.createdDate ??
                    DateTime.now().microsecondsSinceEpoch,
              ),
              time: TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(
                model.messages[index].game?.createdDate ??
                    DateTime.now().microsecondsSinceEpoch,
              )),
            ),
          ),
        );
      },
    );
  }
}
