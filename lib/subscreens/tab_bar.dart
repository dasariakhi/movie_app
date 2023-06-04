import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:travelui/trending/tabview1.dart';

class Tab_Bar extends StatefulWidget {
  const Tab_Bar({super.key});

  @override
  State<Tab_Bar> createState() => _Tab_BarState();
}

late Size size;

class _Tab_BarState extends State<Tab_Bar> {
  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: size.height * 0.3,
        child: DefaultTabController(
          length: 7,
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                height: size.width * 0.127,
                //contentPadding: EdgeInsets.all(10),
                // buttonMargin: EdgeInsets.all(6),

                //  labelSpacing: 10,
                backgroundColor: Colors.white,
                unselectedBackgroundColor: Colors.black,
                unselectedLabelStyle: TextStyle(color: Colors.white),
                labelStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    //icon: Icon(Icons.directions_car),
                    text: "Adventures",
                  ),
                  Tab(
                    //  icon: Icon(Icons.directions_transit),
                    text: "Action",
                  ),
                  Tab(
                    //  icon: Icon(Icons.directions_transit),
                    text: "Animation",
                  ),
                  Tab(
                    //  icon: Icon(Icons.directions_transit),
                    text: "Comedy",
                  ),
                  Tab(
                    //  icon: Icon(Icons.directions_transit),
                    text: "Thriller",
                  ),
                  Tab(
                    //  icon: Icon(Icons.directions_transit),
                    text: "Crime",
                  ),
                  Tab(
                    //  icon: Icon(Icons.directions_transit),
                    text: "Romance",
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    // Tabview1(),
                    Center(
                      child: Icon(Icons.directions_transit),
                    ),
                    Center(
                      child: Icon(Icons.directions_transit),
                    ),
                    Center(
                      child: Icon(Icons.directions_bike),
                    ),
                    Center(
                      child: Icon(Icons.directions_car),
                    ),
                    Center(
                      child: Icon(Icons.directions_transit),
                    ),
                    Center(
                      child: Icon(Icons.directions_bike),
                    ),
                    Center(
                      child: Icon(Icons.directions_bike),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
