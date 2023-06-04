import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelui/screens/categories_info.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  late Size size;
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  List _images = [
    "assets/images/thai.jpg",
    "assets/images/air.jpg",
    "assets/images/thai1.jpg",
    "assets/images/sunny.jpg",
  ];
  List price = ["50", " 80", "120", "150"];

  List _serviceNames = [
    "Massage chi",
    "Only In Air",
    " Thai Babai Massage",
    "Manaku Baga Kavalsina Massage"
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          "Services & Rates",
          style: TextStyle(
              decorationThickness: 2,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed,
              fontSize: size.width * .06,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),
        ),
      ),
      ListView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: _serviceNames.length,
          itemBuilder: (context, i) => Column(
                children: [
                  Center(
                    child: Text(
                      _serviceNames[i],
                      style: TextStyle(
                          fontSize: size.width * .04,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Stack(children: [
                    Container(
                      height: size.width * 0.5,
                      width: size.width * .7,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(CategoryInfo.routename);
                            },
                            child: Image.asset(
                              _images[i],
                              fit: BoxFit.fill,
                            )),
                      ),
                    ),
                    Positioned(
                      // bottom: size.width * .03,
                      //left: size.width * .1,
                      top: 5,
                      right: 15,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 19.2,
                            sigmaY: 19.2,
                          ),
                          child: Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            height: size.width * .07,
                            width: size.width * .1,
                            child: Center(
                              child: Text(
                                "\$${price[i]}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.width * .03),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                  SizedBox(
                    height: 30,
                  )
                ],
              ))
    ]));
  }
}
