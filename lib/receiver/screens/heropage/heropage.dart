import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:unicons/unicons.dart';
import 'package:buildspace_s5/receiver/screens/heropage/dashboard_screen.dart';
import 'profile_screen.dart'; // Import the profile screen
import 'package';

class HeroPage extends StatefulWidget {
  const HeroPage({super.key});

  @override
  State<StatefulWidget> createState() => HeroPageState();
}

class HeroPageState extends State<HeroPage> {
  late PersistentTabController? _controller;
  final String userId = 'current_user_uid'; // Replace with actual UID logic

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const DashBoardScreen(),
      ProfileScreen(uid: userId), // Profile screen with user ID
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.dashboard),
        title: ("Dashboard"),
        activeColorPrimary: Colors.pink,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: Colors.pink,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineToSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: kBottomNavigationBarHeight,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        navBarStyle: NavBarStyle.style3,
      ),
    );
  }
}
