// chat_screen.dart
import 'package:flutter/material.dart';
import 'package:gear_up/view/myChats/model/response/getAllMessages_response.dart';
import 'package:gear_up/view/myChats/ui/receivingChatComp.dart';
import 'package:gear_up/view/myChats/ui/sendingChatComp.dart';
import 'package:gear_up/view/myChats/viewmodel/chatScreen_viewModel.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ChatViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: !model.chatFetched
                ? FutureBuilder<List<Message>>(
                    future: model.fetchAllMessages(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No messages'),
                        );
                      }

                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final message = snapshot.data![index];
                          final isCurrentUser =
                              message.sender == model.senderId;

                          return isCurrentUser
                              ? SendingChatComp(message: message.content ?? '')
                              : ReceivingChatComp(
                                  message: message.content ?? '');
                        },
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: model.messages.length,
                    itemBuilder: (context, index) {
                      final message = model.messages[index];
                      final isCurrentUser = message.sender == model.senderId;

                      return isCurrentUser
                          ? SendingChatComp(message: message.content ?? '')
                          : ReceivingChatComp(message: message.content ?? '');
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF0095F6)),
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
                      height: 0.10,
                      letterSpacing: 0.16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      model.sendSingleMessages(
                        _messageController.text,
                      );
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
