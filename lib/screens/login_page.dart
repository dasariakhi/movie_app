import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:travelui/subscreens/zoom_drawer.dart';
import 'package:travelui/widgets/custume_drawer.dart';

import '../home_page.dart';
import '../models/provider.dart';

class NewLoginPage extends StatelessWidget {
  NewLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<provider>(context);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: Column(
          children: [
            Center(
              child: Container(
                // margin: EdgeInsets.only(top: size.height * 0.27),
                height: size.width * 0.1,
                width: size.width * 0.1,
                color: Colors.red,
                child: Image.asset(
                  'assets/images/newlogo.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Center(
              child: Text(
                "Watch IT",
                style: TextStyle(
                    fontFamily: "BraahOne",
                    color: Colors.white,
                    fontSize: size.width * .08,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () async {
                _provider.sigInWithGoogle();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: size.width * 0.2),
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
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
