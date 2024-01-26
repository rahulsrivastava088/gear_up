// chat_screen.dart
import 'package:flutter/material.dart';
import 'package:gear_up/view/myChats/model/getAllMessages_response.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            child: StreamBuilder<List<Message>>(
              stream: model.messages,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No messages'),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final message = snapshot.data![index];
                    final isCurrentUser = message.sender == model.senderId;

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color:
                            isCurrentUser ? Colors.green : Colors.amberAccent,
                        borderRadius: BorderRadius.only(
                          topLeft: isCurrentUser
                              ? Radius.circular(15.0)
                              : Radius.circular(0.0),
                          topRight: isCurrentUser
                              ? Radius.circular(0.0)
                              : Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                      ),
                      child: Align(
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Text(
                          message.content ?? '',
                          style: TextStyle(
                              color:
                                  isCurrentUser ? Colors.white : Colors.black),
                        ),
                      ),
                    );
                  },
                );
              },
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
                      model.sendMessage(
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
