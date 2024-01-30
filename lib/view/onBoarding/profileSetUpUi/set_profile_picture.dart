import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gear_up/data/response/status.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/utils/uiUtils/big_button.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/app_bar.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_sub_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/profile_set_up_sub_heading_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/intro_page_get_started_button.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/select_gender_check_box_list_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/shared_preferences.dart';
import '../../../utils/utilities.dart';
import '../../../project/routes/custom_navigator.dart';
import '../viewModel/profile_set_up_view_model.dart';

class SetProfilePictureScreen extends StatefulWidget {
  const SetProfilePictureScreen({super.key});

  @override
  State<SetProfilePictureScreen> createState() => _SetProfilePictureScreen();
}

class _SetProfilePictureScreen extends State<SetProfilePictureScreen> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfileSetUpViewModel>(context);

    return Scaffold(
      appBar: onBoardingAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: ui(model, context),
      ),
    );
  }

  Column ui(ProfileSetUpViewModel model, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LoginHeaderText(text: 'Profile Picture'),
        const SizedBox(height: 6),
        const LoginSubHeaderText(text: 'Click/Upload your profile picture'),
        const SizedBox(height: 100),
        Center(
          child: _pickedImage == null
              ? Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.transparent),
                  child: SvgPicture.asset(
                    'assets/images/ic_set_profile_picture.svg',
                    height: 260,
                  ),
                )
              : ClipOval(
                  child: Image.file(
                    _pickedImage!,
                    width: 260,
                    height: 260,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        const Spacer(),
        CustomBigButtonDark(
            onTap: () async {
              CustomNavigationHelper.router
                  .push(CustomNavigationHelper.setLocationPath);
            },
            text: 'Skip'),
        const SizedBox(height: 16),
        CustomBigButtonLight(
            onTap: () async {
              print("tapped");
              getImage(ImageSource.camera);
            },
            text: 'Click a Selfie'),
        const SizedBox(height: 16),
        CustomBigButtonDark(
            onTap: () {
              getImage(ImageSource.gallery);
            },
            text: 'Upload'),
        const SizedBox(height: 24)
      ],
    );
  }

  ImagePicker _imagePicker = ImagePicker();
  File? _pickedImage;

  Future getImage(ImageSource source) async {
    // var status = await Permission.camera.status;

    // if (status != PermissionStatus.granted) {
    //   print("Permission not there");
    // } else {
    //   print("Permission present");
    // }
    // try {
    //   print("try");
    //   // final image = _imagePicker.pickImage(source: source);
    //   print("success");
    //   // print("image: ${image}");
    // } catch (e) {
    //   print("some error");
    // }

    try {
      // Pick an image from the image library
      final returnedImage = await _imagePicker.pickImage(source: source);

      if (returnedImage != null) {
        // Process the picked image
        print('Image path: ${returnedImage.path}');
        setState(
          () {
            _pickedImage = File(returnedImage.path);
          },
        );
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}

Future<void> setSharedPrefData(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(SharedPreferenceConstants.isNewUser, false);
}
