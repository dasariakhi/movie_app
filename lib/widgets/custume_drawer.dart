import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:travelui/home_page.dart';
import 'package:travelui/screens/login_page.dart';

import '../subscreens/zoom_drawer.dart';

class CustumeDrawer extends StatefulWidget {
  const CustumeDrawer({super.key});

  @override
  State<CustumeDrawer> createState() => _CustumeDrawerState();
}

late Size size;

class _CustumeDrawerState extends State<CustumeDrawer> {
  @override
  Widget build(BuildContext context) {
    final _drawerController = ZoomDrawerController();
    return ZoomDrawer(
      style: DrawerStyle.defaultStyle,
      moveMenuScreen: false,
      controller: _drawerController,
      menuScreen: ZoomDrawers(),
      mainScreen: HomePage(),
      borderRadius: 17.0,
      showShadow: true,
      angle: -12.0,
      drawerShadowsBackgroundColor: Colors.grey,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }
}
// class1.dart

 