import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gear_up/data/network/network_util.dart';
import 'package:gear_up/project/routes/custom_navigator.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/view/location/response/location_fetch_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import '../../../utils/utilities.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreen();
}

class _LocationScreen extends State<LocationScreen> {
  List<Prediction> placePredictions = [];
  late TextEditingController _locationSearchController;
  late FocusNode _focusNode;
  bool isSelectLocationOnMapWidgetVisible = false;
  LatLng selectedPosition = defaultLocation;

  @override
  void initState() {
    super.initState();
    _locationSearchController = TextEditingController();
    _focusNode = FocusNode();
    _locationSearchController.addListener(_updateVisibility);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _locationSearchController.dispose();
  }

  void _updateVisibility() {
    setState(() {
      isSelectLocationOnMapWidgetVisible =
          _locationSearchController.text.isNotEmpty;
    });
  }

  Future<void> placeAutoComplete(String query) async {
    Uri uri = Uri.https(
      'maps.googleapis.com',
      'maps/api/place/autocomplete/json',
      {
        "input": query,
        "key": mapsApiKey,
      },
    );
    String? response = await NetworkUtility.fetchUrl(uri);
    if (response != null) {
      PlaceAutoCompleteResponse result =
          PlaceAutoCompleteResponse.parseAutoCompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 48),
            const Row(
              children: [
                Icon(Icons.expand_more, size: 32, color: Colors.black),
                SizedBox(width: 12),
                Text(
                  'Select a location',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              decoration: ShapeDecoration(
                color: const Color(0xFFF6F6F6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 20, color: Colors.black),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        placeAutoComplete(value);
                      },
                      autofocus: true,
                      maxLines: 1,
                      focusNode: _focusNode,
                      controller: _locationSearchController,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Space Grotesk',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Search for an area',
                        hintStyle: TextStyle(
                          color: Color(0xFF6B6B6B),
                          fontSize: 14,
                          fontFamily: 'Space Grotesk',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: !isSelectLocationOnMapWidgetVisible,
              child: Column(
                children: [
                  const SizedBox(height: 28),
                  useCurrentLocationWidget(context),
                ],
              ),
            ),
            Visibility(
              visible: isSelectLocationOnMapWidgetVisible,
              child: Column(
                children: [
                  const SizedBox(height: 22),
                  ListView.builder(
                    padding: const EdgeInsets.all(0.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: placePredictions.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            _fetchPlaceDetailsById(
                                    placePredictions[index].placeId)
                                .then((value) {
                              selectedPosition = value;
                              proceedToConfirmLocationScreen();
                            }).onError((error, stackTrace) {
                              showSnackBar(context, error.toString());
                            });
                          },
                          child: locationCardWidget(index));
                    },
                  ),
                  const SizedBox(height: 22),
                  selectLocationOnMapWidget(),
                ],
              ),
            ),
            // Visibility(
            //   visible: isSelectLocationOnMapWidgetVisible,
            //   child: Column(
            //     children: [

            //     ],
            //   ),
            // ),
            // const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget locationCardWidget(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.location_on_outlined,
                size: 20, color: Color(0xFF141414)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    getFirstString(placePredictions[index].description),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    getSecondString(placePredictions[index].description),
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 14,
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right,
              size: 24,
              color: Color(0xFF141414),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.only(left: 32),
          child: Divider(
            height: 0.5,
            color: Color(0xFFE2E2E2),
          ),
        ),
      ],
    );
  }

  Widget selectLocationOnMapWidget() {
    return InkWell(
      onTap: () {
        print("location on map widget tapped");
        proceedToConfirmLocationScreen();
      },
      child: const Row(
        children: [
          Icon(Icons.location_on, size: 20, color: Color(0xFF141414)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  "Select location on map",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget useCurrentLocationWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        getCurrentLocation(context).then(
          (value) {
            selectedPosition = LatLng(value.latitude, value.longitude);
            proceedToConfirmLocationScreen();
          },
        ).onError(
          (error, stackTrace) {
            showSnackBar(context, error.toString());
          },
        );
      },
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            padding: const EdgeInsets.all(6),
            decoration: ShapeDecoration(
              color: const Color(0xFFEEEEEE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Icon(
              Icons.my_location,
              size: 20,
              color: Color(0xFF141414),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            "Use current location",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'General Sans',
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.chevron_right,
            size: 24,
            color: Color(0xFF141414),
          ),
        ],
      ),
    );
  }

  proceedToConfirmLocationScreen() {
    print("proceed to Confirm Location widget method inside");
    var lat, lng;
    CustomNavigationHelper.router
        .push(
      CustomNavigationHelper.confirmLocationPath,
      extra: selectedPosition,
    )
        .then((value) {
      lat = (value as Map)['lat'];
      lng = (value as Map)['long'];
      print("returned position : $lat $lng");
    });
  }
}

String getFirstString(dynamic input) {
  List<String> parts = input.split(',');
  String firstPart = parts.first;
  return firstPart.trim();
}

String getSecondString(dynamic input) {
  List<String> parts = input.split(',');
  if (parts.length <= 1) {
    return input.trim();
  }
  String firstPart = parts.first;
  if (firstPart.isNotEmpty) {
    String restOfString = input.substring(firstPart.length + 1);
    return restOfString.trim();
  } else {
    return input.trim();
  }
}

Future<LatLng> _fetchPlaceDetailsById(String? placeId) async {
  Uri uri = Uri.https(
    'maps.googleapis.com',
    'maps/api/place/details/json',
    {
      "placeid": placeId,
      "key": mapsApiKey,
    },
  );
  final response = await NetworkUtility.fetchUrl(uri).then((response) {
    if (response != null) {
      final decodedData = json.decode(response);
      final location = decodedData['result']['geometry']['location'];
      return Future.value(
        LatLng(
          location['lat'],
          location['lng'],
        ),
      );
    } else {
      return Future.error("Network error");
    }
  }).onError((error, stackTrace) {
    return Future.error("Network error");
  });
  return response;
}
