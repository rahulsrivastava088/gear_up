import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_config.dart';
import 'package:gear_up/view/onBoarding/viewModel/on_boarding_view_model.dart';
import 'package:gear_up/view/onBoarding/viewModel/profile_set_up_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const GearUpApp());
}

class GearUpApp extends StatelessWidget {
  const GearUpApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnBoardingViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileSetUpViewModel()),
      ],
      child: MaterialApp.router(
        theme: ThemeData.dark(useMaterial3: true)
            .copyWith(scaffoldBackgroundColor: Colors.black),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.returnRouter(),
      ),
    );
  }
}
