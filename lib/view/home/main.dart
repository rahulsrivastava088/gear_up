import 'package:flutter/material.dart';
import 'package:gear_up/view/myGames/main.dart';
import 'package:gear_up/view/partners/main.dart';
import 'package:gear_up/view/userProfile/userDetails/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home Page',
      style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w500),
    ),
    PartnersScreen(),
    MyGamesScreen(),
    UserProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            label: 'Partners',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_baseball_outlined),
            label: 'My Games',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFFADADAD),
        selectedIconTheme: const IconThemeData(color: Colors.white),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        iconSize: 24,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        // elevation: 5,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
