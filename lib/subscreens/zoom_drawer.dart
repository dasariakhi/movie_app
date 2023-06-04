import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:provider/provider.dart';
import 'package:travelui/home_page.dart';
import 'package:travelui/widgets/custume_drawer.dart';

import '../models/provider.dart';

class ZoomDrawers extends StatefulWidget {
  ZoomDrawers({
    super.key,
  });

  @override
  State<ZoomDrawers> createState() => _ZoomDrawersState();
}

late Size size;

class _ZoomDrawersState extends State<ZoomDrawers> {
  final _drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<provider>(context);
    var pic = _provider.photoURL;
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        // margin: EdgeInsets.only(top: 100),
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: size.width * 0.085,
                  top: size.height * 0.09,
                  bottom: size.height * 0.03,
                ),
                alignment: Alignment.center,
                width: size.width * 0.22,
                height: size.width * 0.22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber,
                ),
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
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CustumeDrawer(),
                    ),
                  );
                },
                leading: Icon(Icons.home),
                title: Text('Home'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.account_circle_rounded),
                title: Text('Profile'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
              GestureDetector(
                onTap: () {
                  _provider.signOutFromGoogle();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => CustumeDrawer()),
                      (Route<dynamic> route) => false);
                },
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                ),
              ),
              Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
