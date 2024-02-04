import 'package:gear_up/utils/extension_functions.dart';
import 'package:stacked/stacked.dart';
import '../../../data/response/api_response.dart';
import '../model/response/venues_list_response.dart';
import '../repo/chat_repository.dart';

class VenuesViewModel extends BaseViewModel {
  ApiResponse<List<Venue>> venuesListResponse = ApiResponse.idle();

  final _repo = ChatRepository();

  fetchVenues() async {
    venuesListResponse = ApiResponse.loading();
    _repo
        .fetchVenues()
        .then(
          (value) => {
            if (value.status.toString().isSuccess())
              {
                venuesListResponse = ApiResponse.completed(value.venues),
                print(venuesListResponse.data)
              }
            else
              {
                venuesListResponse = ApiResponse.error("Couldn't fetch Venues"),
              },
            notifyListeners()
          },
        )
        .onError(
          (error, stackTrace) => {
            venuesListResponse = ApiResponse.error("Couldn't fetch Venues"),
            notifyListeners()
          },
        );
  }
}
