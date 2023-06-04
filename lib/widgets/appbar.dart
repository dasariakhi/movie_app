import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:travelui/models/provider.dart';
import 'package:travelui/subscreens/zoom_drawer.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

late Size size;

class _MyAppBarState extends State<MyAppBar> {
  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
    setState(() {});
  }

  ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  final _advancedDrawerController = AdvancedDrawerController();
  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  var pic;
  bool _iconChnage = true;
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<provider>(context);
    var pic = _provider.photoURL;
    final _drawerController = ZoomDrawerController();
    return SafeArea(
        child: Container(
      height: 60,
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              final zoomDrawer = ZoomDrawer.of(context);
              if (zoomDrawer != null) {
                if (zoomDrawer.isOpen()) {
                  zoomDrawer.close();
                } else {
                  zoomDrawer.open();
                }
              }
            },
            child: Container(
                height: 60,
                width: 60,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black54),
                child: Icon(
                  Icons.list,
                  color: Colors.white,
                )),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Watch IT",
                style: TextStyle(
                    fontFamily: "BraahOne",
                    color: Colors.white,
                    fontSize: size.width * .07,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                //  _provider.sigInWithGoogle();
              },
              child: Container(
                height: 60,
                width: 60,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black54),
                child: _provider.photoURL != null && _provider.photoURL != ""
                    ? ClipOval(
                        child: Image.network(
                        _provider.photoURL,
                        fit: BoxFit.cover,
                      ))
                    : ClipOval(
                        child: Icon(
                        Icons.person,
                        color: Colors.white,
                      )),
              ))
        ],
      ),
    ));
  }
}
