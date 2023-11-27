import 'package:flutter/material.dart';
import 'package:gear_up/project/routes/app_route_config.dart';

void main() {
  runApp(const GearUpApp());
}

class GearUpApp extends StatelessWidget {
  const GearUpApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        theme: ThemeData.dark(useMaterial3: true)
            .copyWith(scaffoldBackgroundColor: Colors.black),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.returnRouter());
  }
}
