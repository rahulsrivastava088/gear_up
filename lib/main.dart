import 'package:flutter/material.dart';
import 'package:gear_up/view/bottomNavigation/custom.dart';
import 'package:gear_up/view/filter/filter_view_model.dart';
import 'package:gear_up/view/home/viewModel/home_page_view_model.dart';
import 'package:gear_up/view/myChats/viewmodel/chatScreen_viewModel.dart';
import 'package:gear_up/view/myGames/gameCard/viewmodel/game_card_viewmodel.dart';
import 'package:gear_up/view/onBoarding/viewModel/on_boarding_view_model.dart';
import 'package:gear_up/view/onBoarding/viewModel/profile_set_up_view_model.dart';
import 'package:gear_up/view/posh/viewmodel/posh_viewmodel.dart';
import 'package:gear_up/view/userProfile/viewmodel/my_profile_viewmodel.dart';
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
        ChangeNotifierProvider(create: (context) => PlayersViewModel()),
        ChangeNotifierProvider(create: (context) => GameCardViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ChangeNotifierProvider(create: (context) => MyProfileViewModel()),
        ChangeNotifierProvider(create: (context) => FilterViewModel()),
        ChangeNotifierProvider(create: (context) => ChatViewModel()),
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
