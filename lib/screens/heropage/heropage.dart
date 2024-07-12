import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:unicons/unicons.dart';
import 'package:buildspace_s5/screens/heropage/screens/dashboard_screen.dart';
import 'package:buildspace_s5/screens/heropage/screens/money_screen.dart';
import 'package:buildspace_s5/screens/heropage/screens/dining_screen.dart';

class HeroPage extends StatefulWidget{
  const HeroPage({super.key});

  @override
  State<StatefulWidget> createState()=>HeroPageState();

}

class HeroPageState extends State<HeroPage> {
  late PersistentTabController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

      _controller = PersistentTabController(initialIndex: 0);

    });
  }
  List<Widget> _buildScreens() {
    return [
      const DashBoardScreen(),
      const DiningScreen(),
      const MoneyScreen(),
    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon:  const Icon(Icons.electric_moped),
        title: ("Delivery"),
        activeColorPrimary: Colors.pink,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon:  const Icon(Icons.dining_outlined),
        title: ("Dining"),
        activeColorPrimary: Colors.pink,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ), PersistentBottomNavBarItem(
        icon:  const Icon(UniconsLine.wallet),
        title: ("Money"),
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
        // hideNavigationBarWhenKeyboardShows: true,
        navBarHeight: kBottomNavigationBarHeight, // Use kBottomNavigationBarHeight to manage nav bar height
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        // popAllScreensOnTapOfSelectedTab: true,
        // popActionScreens: PopActionScreensType.all,
        // itemAnimationProperties: const ItemAnimationProperties(
        //   duration: Duration(milliseconds: 200),
        //   curve: Curves.ease,
        // ),
        // screenTransitionAnimation: const ScreenTransitionAnimation(
        //   animateTabTransition: true,
        //   curve: Curves.ease,
        //   duration: Duration(milliseconds: 200),
        // ),
        navBarStyle: NavBarStyle.style3,
      ),
    );
  }
}