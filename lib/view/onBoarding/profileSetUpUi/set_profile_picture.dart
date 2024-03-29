import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gear_up/utils/uiUtils/big_button.dart';
import 'package:gear_up/utils/utilities.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_header_text.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/login_sub_header_text.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/shared_preferences.dart';
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
      appBar: AppBar(
        titleSpacing: 24.0,
        backgroundColor: Colors.transparent,
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
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                model.userImage = '';
                CustomNavigationHelper.router
                    .push(CustomNavigationHelper.setLocationPath);
              });
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 32)
        ],
      ),
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
          child: model.userImage == ''
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
        bottomWidgets(model)
      ],
    );
  }

  Widget bottomWidgets(ProfileSetUpViewModel model) {
    return model.userImage == ''
        ? selectImageWidgets(model)
        : progressFlowWidgets(model);
  }

  Column selectImageWidgets(ProfileSetUpViewModel model) {
    return Column(
      children: [
        CustomBigButtonLight(
            onTap: () async {
              getImage(ImageSource.camera, model);
            },
            text: 'Click a Selfie'),
        const SizedBox(height: 16),
        CustomBigButtonDark(
            onTap: () {
              getImage(ImageSource.gallery, model);
            },
            text: 'Upload'),
        const SizedBox(height: 24),
      ],
    );
  }

  Column progressFlowWidgets(ProfileSetUpViewModel model) {
    return Column(
      children: [
        CustomBigButtonLight(
            onTap: () async {
              CustomNavigationHelper.router
                  .push(CustomNavigationHelper.setLocationPath);
            },
            text: 'Save'),
        const SizedBox(height: 16),
        CustomBigButtonDark(
            onTap: () {
              setState(() {
                model.userImage = '';
              });
            },
            text: 'Back'),
        const SizedBox(height: 24),
      ],
    );
  }

  ImagePicker _imagePicker = ImagePicker();
  File? _pickedImage;

  Future getImage(ImageSource source, ProfileSetUpViewModel model) async {
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
            model.userImage = _pickedImage.toString();
          },
        );
      }
    } catch (e) {
      if (source == ImageSource.camera) {
        final status = await Permission.camera.status;
        if (status == PermissionStatus.denied) {
          showSnackBar(context, "Camera permission is denied");
        } else {
          showSnackBar(context, "Error picking image");
        }
      } else if (source == ImageSource.gallery) {
        final status = await Permission.photos.status;
        if (status == PermissionStatus.denied) {
          showSnackBar(context, "Photos permission is denied");
        } else {
          showSnackBar(context, "Error picking image");
        }
      }
      print('Error picking image: $e');
    }
  }
}
