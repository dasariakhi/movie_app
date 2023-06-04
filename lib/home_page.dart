import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:travelui/widgets/appbar.dart';
import 'package:travelui/screens/displayInfo.dart';
import 'package:travelui/screens/categories_info.dart';

import 'package:travelui/screens/favoutites.dart';
import 'package:travelui/screens/home_screen.dart';
import 'package:travelui/screens/search.dart';
import 'package:travelui/screens/settings.dart';
import 'package:travelui/services_rates.dart';
import 'package:travelui/trending/tabview1.dart';

import 'dart:ui';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  static const routename = "/homepage";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Size size;
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  final iconList = <IconData>[
    Icons.home,
    Icons.search,
    Icons.favorite,
    Icons.settings,
  ];

  int _bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screens = [HomeScreen(), Search(), Favourite(), Settings()];

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: IndexedStack(
          index: _bottomNavIndex,
          children: screens,
        )),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(),
          child: BottomNavyBar(
              backgroundColor: Colors.black,
              selectedIndex: _bottomNavIndex,
              showElevation: true,
              itemCornerRadius: 24,
              curve: Curves.easeIn,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              onItemSelected: (index) =>
                  setState(() => _bottomNavIndex = index),
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  icon: Icon(Icons.apps),
                  title: Text('Home'),
                  activeColor: Colors.white,
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.search),
                  title: Text('Search'),
                  inactiveColor: Colors.grey,
                  activeColor: Colors.white,
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.favorite),
                  title: Text(
                    'Favorite',
                  ),
                  inactiveColor: Colors.grey,
                  activeColor: Colors.white,
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.settings),
                  title: Text('Settings'),
                  inactiveColor: Colors.grey,
                  activeColor: Colors.white,
                  textAlign: TextAlign.center,
                ),
              ]),
        ));
  }
}
