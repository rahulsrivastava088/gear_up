import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewModel/on_boarding_view_model.dart';

class LoginCheckBox extends StatefulWidget {
  const LoginCheckBox({super.key});

  @override
  State<LoginCheckBox> createState() => _LoginCheckBox();
}

class _LoginCheckBox extends State<LoginCheckBox> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<OnBoardingViewModel>(context);

    return Checkbox(
      value: model.tncAccepted,
      checkColor: Colors.black,
      activeColor: Colors.white,
      onChanged: (value) {
        setState(() {
          model.tncAccepted = !model.tncAccepted;
          // this.value = value!;
        });
      },
    );
  }
}
