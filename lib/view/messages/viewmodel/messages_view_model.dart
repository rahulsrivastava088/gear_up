import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/view/messages/repo/messages_repo.dart';
import 'package:stacked/stacked.dart';
import '../../../data/response/api_response.dart';
import '../../myChats/model/response/fetch_all_chats_response.dart';

class MessagesViewModel extends BaseViewModel {
  ApiResponse<List<Chat>> fetchAllChatsResponse = ApiResponse.idle();

  final _repo = MessagesRepository();

  fetchAllChats() async {
    fetchAllChatsResponse = ApiResponse.loading();
    _repo
        .fetchAllChats()
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                if (value.chats == null || value.chats!.isEmpty)
                  {
                    fetchAllChatsResponse = ApiResponse.completed(<Chat>[]),
                  }
                else
                  {
                    fetchAllChatsResponse = ApiResponse.completed(value.chats),
                  }
              }
            else
              {
                fetchAllChatsResponse =
                    ApiResponse.error("Couldn't fetch Chats"),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            fetchAllChatsResponse = ApiResponse.error("Couldn't fetch Chats"),
          },
        );
  }
}
