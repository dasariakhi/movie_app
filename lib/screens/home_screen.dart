import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:travelui/models/provider.dart';
import 'package:travelui/subscreens/movie_video.dart';
import 'package:travelui/subscreens/tab_bar.dart';
import 'package:travelui/widgets/custume_drawer.dart';

import '../widgets/appbar.dart';
import '../services_rates.dart';
import '../subscreens/page_indicator.dart';
import '../trending/tabview1.dart';
import '../trending/tabview2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var _getShows;

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Size size;
  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print(_getShows[0]['name']);
    TabController _controller = TabController(length: 3, vsync: this);
    return Scaffold(
        //drawer: CustumeDrawer(),
        backgroundColor: Colors.black87,
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            MyAppBar(),
            Container(
              height: .45,
              width: double.infinity,
              color: Colors.white,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Page_Indicator(),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    "Trending Videos",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * .05,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                MovieVideo(),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    "Trending Tv shows",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * .05,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: size.height * 0.23,
                    child: Tabview1(
                      urls:
                          "https://api.themoviedb.org/3/trending/tv/day?api_key=3d2f52cdd71d68e2cd7b36e2de3d353c",
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    "Trending Movies",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * .05,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  height: size.height * 0.23,
                  child: Tabview1(
                      urls:
                          "https://api.themoviedb.org/3/trending/movie/day?api_key=3d2f52cdd71d68e2cd7b36e2de3d353c"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    "Popular People",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * .05,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  height: size.height * 0.23,
                  child: Tabview2(
                      urls:
                          "https://api.themoviedb.org/3/trending/person/day?api_key=3d2f52cdd71d68e2cd7b36e2de3d353c"),
                ),
              ],
            ),
          ]),
        ));
  }
}
