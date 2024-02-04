import 'package:flutter/material.dart';
import 'package:gear_up/view/messages/viewmodel/messages_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../colors/Colors.dart';
import '../../../data/response/status.dart';
import '../../../project/routes/custom_navigator.dart';
import '../../../utils/utilities.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreen();
}

class _MessagesScreen extends State<MessagesScreen> {
  bool isApiCalledForFirstTime = false;

  @override
  void initState() {
    super.initState();
    isApiCalledForFirstTime = false;
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MessagesViewModel>(context);
    if (!isApiCalledForFirstTime) {
      model.fetchAllChats();
      isApiCalledForFirstTime = true;
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (model.fetchAllChatsResponse.status == Status.IDLE) {
        model.fetchAllChats();
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (model.fetchAllChatsResponse.status == Status.LOADING) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (model.fetchAllChatsResponse.status == Status.ERROR) {
        return errorUI();
      } else if (model.fetchAllChatsResponse.status == Status.COMPLETED) {
        return ui(context, model);
      }
    }
    return errorUI();
  }
}

Scaffold ui(BuildContext context, MessagesViewModel model) {
  return Scaffold(
    appBar: _messagesAppBar(context),
    body: chatListWidget(context, model),
  );
}

Widget chatListWidget(BuildContext context, MessagesViewModel model) {
  return Padding(
    padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
    child: playersListListView(model),
  );
}

Widget playersListListView(MessagesViewModel model) {
  if (model.fetchAllChatsResponse.data!.isEmpty) {
    return _emptyStateUi();
  } else {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: model.fetchAllChatsResponse.data?.length ?? 0,
        itemBuilder: (context, index) {
          return _chatCard(model, index);
        },
      ),
    );
  }
}

GestureDetector _chatCard(MessagesViewModel model, int index) {
  return GestureDetector(
    onTap: () {
      CustomNavigationHelper.router.push(CustomNavigationHelper.myChatPath,
          extra: model.fetchAllChatsResponse.data?[index]);
    },
    child: Row(
      children: [
        Center(
          child: ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(24),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/person_image.png',
                image: model.fetchAllChatsResponse.data?[index].receiver?.img ??
                    '',
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/person_image.png",
                    width: 100,
                    height: 100,
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Color(0xFF333333)),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.fetchAllChatsResponse.data?[index].receiver?.name ??
                      "-",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        model.fetchAllChatsResponse.data?[index].latestMessage
                                ?.content ??
                            '-',
                        style: const TextStyle(
                          color: Color(0xFFCBCBCB),
                          fontSize: 12,
                          fontFamily: 'Space Grotesk',
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      formatEpochToDate(model.fetchAllChatsResponse.data?[index]
                          .latestMessage?.createdAt),
                      style: const TextStyle(
                        color: Color(0xFF6B6B6B),
                        fontSize: 10,
                        fontFamily: 'Space Grotesk',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget _emptyStateUi() {
  return const Expanded(
    child: Center(
      child: Text(
        'No chats available',
        style: TextStyle(
          color: Color(0xFFAFAFAF),
          fontSize: 16,
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}

Widget errorUI() {
  return const Center(
    child: Text(
      "Couldn't fetch chats, Please try after some time",
      style: TextStyle(
        color: Color(0xFFAFAFAF),
        fontSize: 16,
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

AppBar _messagesAppBar(BuildContext context) {
  return AppBar(
    titleSpacing: 0,
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: IconButton(
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          }
        },
        icon: const Icon(
          Icons.arrow_back,
          size: 32,
        ),
      ),
    ),
    scrolledUnderElevation: 0.0,
    centerTitle: false,
    toolbarHeight: 68,
    backgroundColor: cardBgColor,
    automaticallyImplyLeading: false,
    title: const Row(
      children: [
        SizedBox(width: 8),
        Text(
          'Messages',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'General Sans',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
