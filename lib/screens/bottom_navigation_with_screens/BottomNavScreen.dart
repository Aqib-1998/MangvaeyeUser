import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangvaeye_user/screens/bottom_navigation_with_screens/HomeScreen.dart';
import 'package:mangvaeye_user/screens/cart.dart';
import 'package:mangvaeye_user/utils/MyColors.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../Login.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key key}) : super(key: key);

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex=0;
  List _screens=[HomeScreen(),LoginPage()];
  PersistentTabController _controller= PersistentTabController(initialIndex: 0);


  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }


  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      LoginPage(),
      Cart(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: MyColors.APP_COLOR,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.search),
        title: ("Search"),
        activeColorPrimary: MyColors.APP_COLOR,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.cart),
        title: ("Cart"),
        activeColorPrimary: MyColors.APP_COLOR,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}

// Scaffold(
// body: _screens[_currentIndex],
// bottomNavigationBar: BottomNavigationBar(
// type: BottomNavigationBarType.fixed,
// currentIndex: _currentIndex,
// onTap: _updateIndex,
// selectedItemColor: Colors.blue[700],
// selectedFontSize: 13,
// unselectedFontSize: 13,
// iconSize: 30,
// items: [
// BottomNavigationBarItem(
// label: "Home",
// icon: Icon(Icons.home),
//
// ),
// BottomNavigationBarItem(
// label: "Search",
// icon: Icon(Icons.search),
// ),
// BottomNavigationBarItem(
// label: "Categories",
// icon: Icon(Icons.grid_view),
// ),
// BottomNavigationBarItem(
// label: "My Account",
// icon: Icon(Icons.account_circle_outlined),
// ),
// ],
// ),
//
// );
