import 'package:flutter/material.dart';
import 'package:gear_up/data/response/status.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/utils/utilities.dart';
import 'package:gear_up/view/myChats/model/response/venues_list_response.dart';
import 'package:gear_up/view/myChats/viewmodel/chat_view_model.dart';
import 'package:gear_up/view/myChats/viewmodel/venues_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../userProfile/ui/user_profile/plays_card.dart';
import 'all_venues_bottom_sheet.dart';

class ScheduleMatchBottomSheet extends StatefulWidget {
  final bool isReschedule;
  final DateTime? date;
  final TimeOfDay? time;
  final int? sportIndex;
  final String? gameId;
  const ScheduleMatchBottomSheet({
    super.key,
    required this.isReschedule,
    this.date,
    this.time,
    this.sportIndex,
    this.gameId,
  });

  @override
  State<ScheduleMatchBottomSheet> createState() => _ScheduleMatchBottomSheet();
}

class _ScheduleMatchBottomSheet extends State<ScheduleMatchBottomSheet> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _selectedDate = DateTime.now();
  int? _selectedVenue;
  int? _selectedSport;
  @override
  void initState() {
    super.initState();
    if (widget.date != null) {
      _selectedDate = widget.date!;
    }
    if (widget.time != null) {
      _selectedTime = widget.time!;
    }
    if (widget.sportIndex != null) {
      _selectedSport = widget.sportIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    final venuesViewModel = Provider.of<VenuesViewModel>(context);
    final chatViewModel = Provider.of<ChatViewModel>(context);

    if (venuesViewModel.venuesListResponse.status == Status.IDLE) {
      print("fetch Venues api calling");
      venuesViewModel.fetchVenues();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 24, bottom: 16, left: 24, right: 24),
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
                    Text(
                      widget.isReschedule == true
                          ? 'Re-Schedule'
                          : 'Schedule a Match',
                      style: const TextStyle(
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
              _headerText("Date"),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                height: 36,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF6F6F6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        _formatDate(_selectedDate),
                        style: const TextStyle(
                          color: Color(0xFF6B6B6B),
                          fontSize: 14,
                          fontFamily: 'Space Grotesk',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.calendar_month, color: Color(0xFF141414))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _headerText("Time"),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                height: 36,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF6F6F6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        _formatTime(_selectedTime),
                        style: const TextStyle(
                          color: Color(0xFF6B6B6B),
                          fontSize: 14,
                          fontFamily: 'Space Grotesk',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.schedule, color: Color(0xFF141414))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _headerText("Game"),
              const SizedBox(height: 6),
              SizedBox(
                height: 32,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: Strings.sportsList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSport = index;
                            });
                          },
                          child: Container(
                            height: 32,
                            padding: const EdgeInsets.only(
                                top: 8, left: 0, right: 16, bottom: 8),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF6F6F6),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.white,
                                radioTheme: RadioThemeData(
                                  fillColor: MaterialStateProperty.all(
                                    Colors.grey,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Radio(
                                    value: index,
                                    groupValue: _selectedSport,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          _selectedSport = value;
                                        },
                                      );
                                    },
                                  ),
                                  Text(
                                    Strings.sportsList[index],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Space Grotesk',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.white,
                      width: 8,
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Divider(height: .5, color: Color(0xFFAFAFAF)),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Text(
                    'Suggested Venues',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        useRootNavigator: true,
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        builder: (BuildContext context) {
                          return const Wrap(children: [AllVenuesBottomSheet()]);
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFFE2E2E2)),
                          borderRadius: BorderRadius.circular(80),
                        ),
                      ),
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          color: Color(0xFF0095F6),
                          fontSize: 14,
                          fontFamily: 'Space Grotesk',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 26),
              SizedBox(
                height: 230,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      venuesViewModel.venuesListResponse.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return venueCardWidget(
                        venuesViewModel.venuesListResponse.data?[index] ??
                            Venue(),
                        index);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 12);
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Divider(height: .5, color: Color(0xFFAFAFAF)),
              const SizedBox(height: 16),
              buttons(context, chatViewModel, venuesViewModel),
            ],
          ),
        )
      ],
    );
  }

  Widget buttons(BuildContext context, ChatViewModel chatViewModel,
      VenuesViewModel venuesViewModel) {
    if (widget.isReschedule == false) {
      return createGameButtonWidget(context, chatViewModel, venuesViewModel);
    } else {
      return Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Container(
                height: 48,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            child: saveChangesButtonWidget(
                context, chatViewModel, venuesViewModel),
          ),
        ],
      );
    }
  }

  Container createGameButtonWidget(BuildContext context,
      ChatViewModel chatViewModel, VenuesViewModel venuesViewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: InkWell(
        onTap: () {
          if (_selectedSport == null) {
            showSnackBar(context, "Please select Sport");
          } else if (_selectedVenue == null) {
            showSnackBar(context, "Please select Venue");
          } else {
            chatViewModel.createGame(
              context,
              _selectedDate,
              _selectedTime,
              _selectedSport!,
              venuesViewModel.venuesListResponse.data?[_selectedVenue!].id,
            );
          }
        },
        child: Ink(
          width: double.infinity,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: chatViewModel.createGameResponse.status != Status.LOADING
              ? const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Send',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : JumpingDots(
                  color: Colors.grey,
                  radius: 10,
                  numberOfDots: 5,
                ),
        ),
      ),
    );
  }

  Container saveChangesButtonWidget(BuildContext context,
      ChatViewModel chatViewModel, VenuesViewModel venuesViewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: InkWell(
        onTap: () {
          if (_selectedSport == null) {
            showSnackBar(context, "Please select Sport");
          } else if (_selectedVenue == null) {
            showSnackBar(context, "Please select Venue");
          } else {
            chatViewModel.rescheduleGame(
              context,
              widget.gameId,
              _selectedDate,
              _selectedTime,
              _selectedSport!,
              venuesViewModel.venuesListResponse.data?[_selectedVenue!].id,
            );
          }
        },
        child: Ink(
            width: double.infinity,
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child:
                // chatViewModel.createGameResponse.status != Status.LOADING?
                const Align(
              alignment: Alignment.center,
              child: Text(
                'Save Changes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
            // : JumpingDots(
            //     color: Colors.grey,
            //     radius: 10,
            //     numberOfDots: 5,
            //   ),
            ),
      ),
    );
  }

  Widget venueCardWidget(Venue venue, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedVenue = index;
        });
      },
      child: Container(
        height: 230,
        width: 200,
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 16),
          decoration: ShapeDecoration(
            color: const Color(0xFFF6F6F6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/person_image.png',
                        image: venue.img ?? '',
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Container(color: Colors.grey);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Radio(
                      fillColor: MaterialStateProperty.all(
                        Colors.white,
                      ),
                      value: index,
                      groupValue: _selectedVenue,
                      onChanged: (value) {
                        setState(
                          () {
                            _selectedVenue = value;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      venue.name ?? '-',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Space Grotesk',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 2),
                    FutureBuilder<String>(
                      future: getAddressFromLatLng(
                        context,
                        venue.location?.lat.toDouble(),
                        venue.location?.lng.toDouble(),
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: const SizedBox(
                              height: 20,
                              width: double.infinity,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Text(
                            '-',
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 12,
                              fontFamily: 'Space Grotesk',
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        } else {
                          return Text(
                            (snapshot.data ?? "-").trim(),
                            style: const TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 12,
                              fontFamily: 'Space Grotesk',
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          );
                        }
                      },
                    ),
                    // const Spacer(),
                    const SizedBox(height: 12),
                    Text(
                      getStringFromSportsList(venue.sportsList),
                      // 'Swimming, Badminton & +2',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Space Grotesk',
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Text _headerText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF3D3D3D),
        fontSize: 12,
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate.isBefore(DateTime.now())
          ? DateTime.now()
          : _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM, yyyy').format(date);
  }

  String _formatTime(TimeOfDay time) {
    return time.format(context);
  }
}
