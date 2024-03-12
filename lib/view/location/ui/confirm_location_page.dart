import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gear_up/utils/shared_preferences.dart';
import 'package:gear_up/utils/uiUtils/big_button.dart';
import 'package:gear_up/utils/utilities.dart';
import 'package:gear_up/view/onBoarding/viewModel/on_boarding_view_model.dart';
import 'package:gear_up/view/onBoarding/viewModel/profile_set_up_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'location_main_page.dart';

class ConfirmLocationScreen extends StatefulWidget {
  final LatLng position;
  const ConfirmLocationScreen({super.key, required this.position});

  @override
  State<ConfirmLocationScreen> createState() => _ConfirmLocationScreen();
}

class _ConfirmLocationScreen extends State<ConfirmLocationScreen> {
  final _controller = Completer();
  LatLng _selectedPosition = const LatLng(0, 0);
  String _selectedLocation = '';

  @override
  void initState() {
    super.initState();
    _selectedPosition = widget.position;
    print("init $_selectedPosition");
    updateLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfileSetUpViewModel>(context);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: const Icon(
                          Icons.chevron_left,
                          size: 32,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Confirm Location',
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
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
                          child: GestureDetector(
                            onTap: () {
                              context.pop();
                            },
                            child: const Text(
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              'Search for an area',
                              style: TextStyle(
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
                  const SizedBox(height: 22),
                ],
              ),
            ),
            SizedBox(
                width: double.infinity,
                height: 600,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _selectedPosition,
                    zoom: 20,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId("selected_location"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: _selectedPosition,
                      draggable: true,
                      onDragEnd: (newPosition) {
                        _selectedPosition = newPosition;
                        updateLocation();
                      },
                    ),
                  },
                )),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const SizedBox(width: 6),
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
                              getFirstString(_selectedLocation),
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
                              getSecondString(_selectedLocation),
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
                      const SizedBox(width: 6),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomBigButtonDark(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      if (prefs.getBool(SharedPreferenceConstants.isNewUser) ==
                          true) {
                        print(widget.position.latitude.toString());
                        print(widget.position.longitude.toString());
                        showSnackBar(context,
                            "Creating profile for ${model.firstName} ${model.lastName}");
                        model.lat = widget.position.latitude.toString();
                        model.long = widget.position.longitude.toString();
                        model.updateUser(context);
                      } else {
                        model.updateLocation();
                      }
                    },
                    text: 'Confirm Location',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  updateLocation() {
    getAddressFromLatLng(
            context, _selectedPosition.latitude, _selectedPosition.longitude)
        .then(
      (value) {
        setState(
          () {
            _selectedLocation = value;
          },
        );
      },
    );
  }
}
