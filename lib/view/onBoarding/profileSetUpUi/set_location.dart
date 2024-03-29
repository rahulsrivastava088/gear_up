import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gear_up/data/response/status.dart';
import 'package:gear_up/project/routes/custom_navigator.dart';
import 'package:gear_up/utils/uiUtils/big_button.dart';
import 'package:gear_up/utils/utilities.dart';
import 'package:gear_up/view/onBoarding/loginUi/commonUI/app_bar.dart';
import 'package:provider/provider.dart';
import '../viewModel/profile_set_up_view_model.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreen();
}

class _SetLocationScreen extends State<SetLocationScreen> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfileSetUpViewModel>(context);

    if (model.registerUserResponse.status == Status.LOADING) {
      return const Center(child: CircularProgressIndicator());
    } else if (model.registerUserResponse.status == Status.ERROR) {
      return uI(context, model);
    } else if (model.registerUserResponse.status == Status.COMPLETED) {
      return uI(context, model);
    } else {
      return uI(context, model);
    }
  }

  Scaffold uI(BuildContext context, ProfileSetUpViewModel model) {
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
        const SizedBox(height: 36),
        Center(
          child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.transparent),
            child: SvgPicture.asset(
              'assets/images/ic_location.svg',
              height: 260,
            ),
          ),
        ),
        const SizedBox(height: 60),
        const Center(
          child: Text(
            'Where are you?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontFamily: 'General Sans',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Opacity(
            opacity: 0.88,
            child: Text(
              'Set your location & start finding\npartners to play with',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        const Spacer(),
        CustomBigButtonLight(
            onTap: () {
              getCurrentLocation(context).then((value) {
                print(value.latitude.toString());
                print(value.longitude.toString());
                showSnackBar(context,
                    "Creating profile for ${model.firstName} ${model.lastName}");
                model.lat = value.latitude.toString();
                model.long = value.longitude.toString();
                model.updateUser(context);
              }).onError((error, stackTrace) {
                showSnackBar(context, error.toString());
              });
            },
            text: 'Enable Device Location'),
        const SizedBox(height: 16),
        CustomBigButtonDark(
            onTap: () {
              CustomNavigationHelper.router
                  .push(CustomNavigationHelper.locationPath);
            },
            text: 'Enter Your Location Manually'),
        const SizedBox(height: 24)
      ],
    );
  }
}
