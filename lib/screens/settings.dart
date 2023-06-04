import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:travelui/models/provider.dart';
import 'package:travelui/subscreens/zoom_drawer.dart';

import '../home_page.dart';
import '../widgets/appbar.dart';
import '../widgets/custume_drawer.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _darkModeEnabled = false;
  bool _notificationEnabled = false;
  late bool value;
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    var _provider = Provider.of<provider>(context);
    if (_provider.displayName != "") {
      //   setState(() {
      //     choose = true;
      //   });
      // } else {
      //   setState(() {
      //     choose = true;
      //   });
    }
    var pic = _provider.photoURL;
    bool choose = _provider.successful_login;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => CustumeDrawer()),
                (Route<dynamic> route) => false);
          },
        ),
        title: Text(
          'Settings',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: size.width * .05,
              fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(top: size.height * 0.02),
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
              ),
              Center(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: _provider.displayName != null
                        ? Text(
                            _provider.displayName,
                            style: TextStyle(
                                fontFamily: "BraahOne",
                                color: Colors.white,
                                fontSize: size.width * .07,
                                fontWeight: FontWeight.normal),
                          )
                        : Text(
                            "username",
                            style: TextStyle(
                                fontFamily: "BraahOne",
                                color: Colors.white,
                                fontSize: size.width * .07,
                                fontWeight: FontWeight.normal),
                          )),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                // color: Colors.white,
                height: 330,
                child: ListView(
                  children: [
                    ListTile(
                      title: Text(
                        'Notifications',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text('Enable/disable notifications',
                          style: TextStyle(color: Colors.white)),
                      trailing: Switch(
                        value: _notificationEnabled,
                        onChanged: (bool value) {
                          setState(() {
                            _notificationEnabled = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Dark Mode',
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text('Enable/disable dark mode',
                          style: TextStyle(color: Colors.white)),
                      trailing: Switch(
                        value: _darkModeEnabled,
                        onChanged: (value) {
                          setState(() {
                            _darkModeEnabled = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Language',
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text('Select your preferred language',
                          style: TextStyle(color: Colors.white)),
                      trailing:
                          Icon(Icons.arrow_forward_ios, color: Colors.white),
                      onTap: () {
                        // Navigate to language selection page
                        // You can use Navigator.push to navigate to a new page
                      },
                    ),
                    ListTile(
                      title:
                          Text('About', style: TextStyle(color: Colors.white)),
                      subtitle: Text('Learn more about the app',
                          style: TextStyle(color: Colors.white)),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to about page
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              choose
                  ? GestureDetector(
                      onTap: () async {
                        _provider.signOutFromGoogle();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => CustumeDrawer()),
                            (Route<dynamic> route) => false);
                      },
                      child: Container(
                        //  margin: EdgeInsets.only(bottom: size.width * 0.2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          color: Colors.white,
                        ),
                        height: size.width * 0.08,
                        width: size.width * 0.22,
                        child: Center(
                          child: Text(
                            "Logout",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        _provider.sigInWithGoogle();

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => CustumeDrawer()),
                            (Route<dynamic> route) => false);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: size.width * 0.03),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          color: Colors.white,
                        ),
                        height: size.width * 0.1,
                        width: size.width * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: size.width * 0.055,
                              width: size.width * 0.055,
                              child: Image.asset(
                                'assets/images/google.png',
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Sign in with Google",
                              style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
