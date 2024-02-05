import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({
    super.key,
    required this.child,
  });

  final StatefulNavigationShell child;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.child.currentIndex,
        onTap: (index) {
          // if (index == 2) {
          //   print("index is 2");
          //   // Navigator.of(context).pop();

          //   // widget.child.go
          //   widget.child.goBranch(index, initialLocation: false);

          //   // widget.child.goBranch(
          //   //   index,
          //   //   initialLocation: index == widget.child.currentIndex,
          //   // );
          // } else {
          widget.child.goBranch(
            index,
            initialLocation: index == widget.child.currentIndex,
          );
          setState(() {});
          // }
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFFADADAD),
        selectedIconTheme: const IconThemeData(color: Colors.white),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        iconSize: 24,
        items: const [
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
      ),
    );
  }
}
