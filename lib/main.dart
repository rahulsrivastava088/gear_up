import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_config.dart';
import 'package:gear_up/view/bottomNavigation/custom.dart';
import 'package:gear_up/view/bottomNavigation/custom_navigation_helper.dart';
import 'package:gear_up/view/home/viewModel/home_page_view_model.dart';
import 'package:gear_up/view/myGames/gameCard/viewmodel/game_card_viewmodel.dart';
import 'package:gear_up/view/onBoarding/viewModel/on_boarding_view_model.dart';
import 'package:gear_up/view/onBoarding/viewModel/profile_set_up_view_model.dart';
import 'package:gear_up/view/partners/viewModel/partners_page_viewmodel.dart';
import 'package:gear_up/view/posh/viewmodel/posh_viewmodel.dart';
import 'package:gear_up/view/userProfile/viewmodel/profile_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  CustomNavigationHelper.instance;
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
        ChangeNotifierProvider(create: (context) => PoshViewModel()),
        ChangeNotifierProvider(create: (context) => HomePageViewModel()),
        ChangeNotifierProvider(create: (context) => PartnersPageViewModel()),
        ChangeNotifierProvider(create: (context) => GameCardViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
      ],
      child: MaterialApp.router(
        theme: ThemeData.dark(useMaterial3: true)
            .copyWith(scaffoldBackgroundColor: Colors.black),
        debugShowCheckedModeBanner: false,
        routerConfig: CustomNavigationHelper.router,
      ),
    );
  }
}
