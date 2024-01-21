import 'package:flutter/material.dart';
import 'package:gear_up/view/home/model/response/players_list_response.dart';
import 'package:gear_up/view/home/ui/home_page_main.dart';
import 'package:gear_up/view/myGames/my_games_page_main.dart';
import 'package:gear_up/view/partners/ui/partners_page_main.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/own_user_page_main.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({super.key, required this.initialIndex});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const PartnersScreen(),
    const MyGamesScreen(),
    UserProfileScreen(player: PlayersWithConnection())
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
