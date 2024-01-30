import 'package:flutter/material.dart';
import 'package:gear_up/view/chat/schedule_match_bottom_sheet.dart';
import 'package:gear_up/view/myChats/model/response/getAllMessages_response.dart';
import 'package:gear_up/view/myChats/ui/receivingChatComp.dart';
import 'package:gear_up/view/myChats/ui/sendingChatComp.dart';
import 'package:gear_up/view/myChats/viewmodel/chatScreen_viewModel.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/details_card.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../colors/Colors.dart';
import '../../../utils/utilities.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ChatViewModel>(context);
    return Scaffold(
      appBar: _chatAppBar(context),
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
                    const UserDetailsCard(
                      userImage:
                          "https://assets.vogue.in/photos/5f23c04f1d33754d11eaf778/2:3/w_2560%2Cc_limit/harry-potter-philosophers-stone-portrait-8.jpg",
                      userName: "Harry Potter",
                      userAge: 22,
                      userGender: "Male",
                      userLocation: "2.5km away",
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
            return const Wrap(children: [ScheduleMatchBottomSheet()]);
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
            future: model.fetchAllMessages(),
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
                  final message = snapshot.data![index];
                  final isCurrentUser = message.sender == model.senderId;

                  return isCurrentUser
                      ? SendingChatComp(message: message.content ?? '')
                      : ReceivingChatComp(message: message.content ?? '');
                },
              );
            },
          )
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: model.messages.length,
            itemBuilder: (context, index) {
              final message = model.messages[index];
              final isCurrentUser = message.sender == model.senderId;

              return isCurrentUser
                  ? SendingChatComp(message: message.content ?? '')
                  : ReceivingChatComp(message: message.content ?? '');
            },
          );
  }
}

AppBar _chatAppBar(BuildContext context) {
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
          // model.clearData();
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
                image:
                    "https://assets.vogue.in/photos/5f23c04f1d33754d11eaf778/2:3/w_2560%2Cc_limit/harry-potter-philosophers-stone-portrait-8.jpg",
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
          const Text(
            'Harry Potter',
            textAlign: TextAlign.center,
            style: TextStyle(
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
