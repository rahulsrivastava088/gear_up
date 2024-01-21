import 'package:flutter/material.dart';
import 'package:gear_up/view/userProfile/ui/edit_user_profile/app_bar.dart';

class EditUserProfileScreen extends StatefulWidget {
  const EditUserProfileScreen({super.key});

  @override
  State<EditUserProfileScreen> createState() => _EditUserProfileScreen();
}

class _EditUserProfileScreen extends State<EditUserProfileScreen> {
  String userImage =
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww';
  String userName = 'Amélie';
  String userDOB = '18/09/2001';
  String userGender = 'Female';
  String userPlayingObjective = 'Fun';
  String userPlayTime = 'Daily';

  List<String> gendersList = [
    'Male',
    'Female',
    'Others',
  ];

  List<String> playObjectiveList = [
    'Fun',
    'Practice',
    'Improve Game',
  ];

  List<String> playTimeList = [
    'Weekends',
    'Daily',
    'Anytime',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: editUserProfileAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
            Center(
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(48), // Image radius
                  child: Image.network(userImage, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () {},
              child: const Center(
                child: Text(
                  'Edit picture',
                  style: TextStyle(
                    color: Color(0xFF0095F6),
                    fontSize: 14,
                    fontFamily: 'Space Grotesk',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Name',
              style: TextStyle(
                color: Color(0xFFAFAFAF),
                fontSize: 12,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xFF333333)),
                ),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                    isDense: true,
                    border: InputBorder.none),
                initialValue: userName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Space Grotesk',
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Date of Birth',
              style: TextStyle(
                color: Color(0xFFAFAFAF),
                fontSize: 12,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xFF333333)),
                ),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                    isDense: true,
                    border: InputBorder.none),
                initialValue: userDOB,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Space Grotesk',
                    decorationThickness: 0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Gender',
              style: TextStyle(
                color: Color(0xFFAFAFAF),
                fontSize: 12,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xFF333333)),
                ),
              ),
              child: DropdownButtonFormField<String>(
                // dropdownColor: Colors.white,
                // selectedItemBuilder: (BuildContext ctxt) {
                //   return items.map<Widget>((item) {
                //     return DropdownMenuItem(
                //       value: item,
                //       child: Text(item,
                //           style: const TextStyle(color: Colors.white)),
                //     );
                //   }).toList();
                // },
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                    isDense: true,
                    border: InputBorder.none),
                value: userGender,
                items: gendersList
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            // style: const TextStyle(color: Colors.black),
                          ),
                        ))
                    .toList(),
                onChanged: (item) {
                  setState(
                    () {
                      userGender = item!;
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Objective of playing sports',
              style: TextStyle(
                color: Color(0xFFAFAFAF),
                fontSize: 12,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xFF333333)),
                ),
              ),
              child: DropdownButtonFormField<String>(
                // dropdownColor: Colors.white,
                // selectedItemBuilder: (BuildContext ctxt) {
                //   return items.map<Widget>((item) {
                //     return DropdownMenuItem(
                //       value: item,
                //       child: Text(item,
                //           style: const TextStyle(color: Colors.white)),
                //     );
                //   }).toList();
                // },
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                    isDense: true,
                    border: InputBorder.none),
                value: userPlayingObjective,
                items: playObjectiveList
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            // style: const TextStyle(color: Colors.black),
                          ),
                        ))
                    .toList(),
                onChanged: (item) {
                  setState(
                    () {
                      userPlayingObjective = item!;
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'When do you usually play',
              style: TextStyle(
                color: Color(0xFFAFAFAF),
                fontSize: 12,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xFF333333)),
                ),
              ),
              child: DropdownButtonFormField<String>(
                // dropdownColor: Colors.white,
                // selectedItemBuilder: (BuildContext ctxt) {
                //   return items.map<Widget>((item) {
                //     return DropdownMenuItem(
                //       value: item,
                //       child: Text(item,
                //           style: const TextStyle(color: Colors.white)),
                //     );
                //   }).toList();
                // },
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                    isDense: true,
                    border: InputBorder.none),
                value: userPlayTime,
                items: playTimeList
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            // style: const TextStyle(color: Colors.black),
                          ),
                        ))
                    .toList(),
                onChanged: (item) {
                  setState(
                    () {
                      userPlayTime = item!;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
