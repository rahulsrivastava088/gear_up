import 'package:flutter/material.dart';
import 'package:gear_up/data/network/network_util.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/utils/uiUtils/big_button.dart';
import 'package:gear_up/view/location/response/location_fetch_response.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreen();
}

class _LocationScreen extends State<LocationScreen> {
  List<Prediction> placePredictions = [];
  Future<void> placeAutoComplete(String query) async {
    Uri uri = Uri.https(
        'maps.googleapis.com',
        'maps/api/place/autocomplete/json',
        {"input": query, "key": mapsApiKey});
    String? response = await NetworkUtility.fetchUrl(uri);
    if (response != null) {
      print(response);
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                      maxLines: 1,
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
            Expanded(
              child: ListView.builder(
                itemCount: placePredictions.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined,
                              size: 20, color: Color(0xFF141414)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              placePredictions[index].description ?? '',
                              style: const TextStyle(
                                // color: Colors.black,
                                // fontSize: 16,
                                // fontFamily: 'General Sans',
                                // fontWeight: FontWeight.w600,
                                color: Color(0xFF333333),
                                fontSize: 14,
                                fontFamily: 'Space Grotesk',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.chevron_right,
                              size: 24, color: Color(0xFF141414))
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Padding(
                        padding: EdgeInsets.only(left: 32),
                        child: Divider(height: 0.5, color: Color(0xFFE2E2E2)),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
