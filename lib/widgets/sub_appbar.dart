import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SubAppBar extends StatefulWidget {
  const SubAppBar({super.key});

  @override
  State<SubAppBar> createState() => _SubAppBarState();
}

late Size size;

class _SubAppBarState extends State<SubAppBar> {
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: Container(
                height: 60,
                margin: EdgeInsets.only(top: 30, left: 20, right: 30),
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: size.width * .13,
                      width: size.width * .13,
                      // padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black54),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: size.width * .1),
                      child: Text(
                        "Favourites",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * .07,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ]))),
      ),
    );
  }
}
