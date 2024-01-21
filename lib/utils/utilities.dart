import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../view/onBoarding/loginUi/commonUI/custom_snackbar.dart';

showSnackBar(BuildContext context, String text) {
  customSnackBar(context, text);
}

Future<void> hitSocialMediaLink(String url) async {
  try {
    await canLaunch(url) ? await launch(url) : '';
    // ignore: empty_catches
  } catch (e) {}
}

Center circularImage(String? userImage) {
  return Center(
    child: ClipOval(
      child: SizedBox.fromSize(
        size: const Size.fromRadius(80), // Image radius
        // child: Container(
        // color: Colors.grey,
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/person_image.png',
          image: userImage ?? '',
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              "assets/images/person_image.png",
              width: 100,
              height: 100,
            );
          },
        ),
      ),
    ),
    // ),
  );
}

uiText(String? text) {
  if (text == null || text.isEmpty) {
    return "NA";
  } else {
    return text;
  }
}
