import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/provider.dart';

class PopularPeople extends StatefulWidget {
  var img;
  var known;
  var name;
  PopularPeople(
      {super.key, required this.name, required this.known, required this.img});

  @override
  State<PopularPeople> createState() => _PopularPeopleState();
}

late Size size;

class _PopularPeopleState extends State<PopularPeople> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    var _getdata = Provider.of<provider>(context).listOfPeople;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
          child: Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                    alignment: Alignment.topLeft,
                    // height: 60,
                    margin: EdgeInsets.only(top: 20, left: 20, right: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: size.width * 0.13,
                        width: size.width * 0.13,
                        //padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ))),
            SizedBox(
              height: size.width * 0.15,
            ),
            Container(
              height: size.height * .2,
              width: size.width * .35,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.img,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            Text(
              // textAlign: TextAlign.justify,
              widget.name,
              style: TextStyle(
                fontFamily: "BraahOne",
                fontSize: size.width * .1,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "known For  :  ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                Center(
                    child: Text(
                  widget.known,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.amber),
                )),
              ],
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            Container(
              margin: EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Movies",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25),
              ),
            ),
            Container(
              height: size.height * .23,
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _getdata.length,
                itemBuilder: (context, index) {
                  final tvShowBackdropPath = _getdata[index]['backdrop_path'] ??
                      _getdata[index]['profile_path'];
                  final tvShowBackdropUrl =
                      'https://image.tmdb.org/t/p/original$tvShowBackdropPath';
                  bool _noImgae = false;
                  if (tvShowBackdropUrl ==
                      "https://image.tmdb.org/t/p/originalnull") {
                    setState(() {
                      _noImgae = true;
                    });
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            color: Colors.black,
                          ),
                          height: size.height * .165,
                          width: size.width * .3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: _noImgae
                                ? Text("sa")
                                : Image.network(
                                    tvShowBackdropUrl,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: size.width * .3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 100,
                                sigmaY: 100,
                              ),
                              child: Container(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                height: size.width * .07,
                                width: size.width * .33,
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      _getdata[index]['title'],
                                      // _gettvshows[i]['title'] ??
                                      //     _gettvshows[i]['name'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size.width * .03),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ])),
    );
  }
}
