import 'dart:convert';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:travelui/subscreens/popular_people.dart';
import '../models/provider.dart';

class Tabview2 extends StatefulWidget {
  var urls;
  Tabview2({super.key, this.urls});

  @override
  State<Tabview2> createState() => _Tabview2State();
}

class _Tabview2State extends State<Tabview2> {
  int initialpage = 1;
  var _check;
  var title;
  var overview;
  @override
  void initState() {
    getPopularPeople(widget.urls);
    // TODO: implement initState
    super.initState();
  }

  late Size size;
  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  bool _isLoading = true;
  var _getPeople;
  Future<List<dynamic>> getPopularPeople(urls) async {
    //final url = Uri.parse(widget.urls);
    final response = await http.get(Uri.parse(widget.urls));
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final results = decoded['results'];
      // Iterate over each item in the "results" list
      // for (var item in results) {
      //   // Check if the item is of type "person"
      //   if (item['media_type'] == 'person') {
      //     // Access the "known_for" list for each person
      //     final List<dynamic> knownFor = item['known_for'];

      //     // Iterate over each known_for item
      //     for (var knownItem in knownFor) {
      //       // Access the desired properties from the known_for item
      //       title = knownItem['title'];
      //       overview = knownItem['overview'];

      //       // Print the details of the known_for item

      //       print('---');
      //     }
      //   }
      // }

      setState(() {
        _getPeople = results;
        _isLoading = false;
        print("get people $_getPeople");
      });
      //listOfMovies=tvShows;
      //print(tvShows[0]['id']);
      return results;
    } else {
      throw Exception('Failed to load trending TV shows');
    }
  }

  @override
  Widget build(BuildContext context) {
    var _getdata = Provider.of<provider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Visibility(
        visible: _isLoading || _getPeople.isNotEmpty,
        child: _isLoading
            ? CircularProgressIndicator()
            : _getPeople.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    dragStartBehavior: DragStartBehavior.start,
                    scrollDirection: Axis.horizontal,
                    itemCount: _getPeople.length,
                    itemBuilder: (context, i) {
                      final tvShowBackdropPath = _getPeople[i]
                              ['profile_path'] ??
                          _getPeople[i]['backdrop_path'];

                      final tvShowBackdropUrl =
                          'https://image.tmdb.org/t/p/original$tvShowBackdropPath';

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              child: GestureDetector(
                                onTap: () {
                                  print("mawa ${_getPeople[i]['known_for']}");
                                  _getdata.listOfPeople =
                                      _getPeople[i]['known_for'];

                                  print(_check);
                                  // print('Overview: $overview');
                                  //  print(_getPeople['adult']);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => PopularPeople(
                                            name: _getPeople[i]['name'],
                                            known: _getPeople[i]
                                                ['known_for_department'],
                                            img: tvShowBackdropUrl,
                                          )));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: size.height * .165,
                                      width: size.width * .3,
                                      child: Image.network(
                                        tvShowBackdropUrl,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: size.width * .3,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 100,
                                            sigmaY: 100,
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            height: size.width * .07,
                                            width: size.width * .33,
                                            child: Center(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  _getPeople[i]['name'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          size.width * .03),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            // Container(
                            //   child: Text(
                            //     _getdata[i]['name'],
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.bold, color: Colors.black),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child:
                      //   Column(
                      //     children: [
                      //       GestureDetector(
                      //         onTap: () {},
                      //         child: ClipRRect(
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(20)),
                      //           child: GestureDetector(
                      //             onTap: () {
                      // print("mawa ${_getPeople[i]['known_for']}");
                      // _getdata.listOfPeople =
                      //     _getPeople[i]['known_for'];

                      // print(_check);
                      // // print('Overview: $overview');
                      // //  print(_getPeople['adult']);
                      // Navigator.of(context)
                      //     .push(MaterialPageRoute(
                      //         builder: (ctx) => PopularPeople(
                      //               name: _getPeople[i]['name'],
                      //               known: _getPeople[i]
                      //                   ['known_for_department'],
                      //               img: tvShowBackdropUrl,
                      //             )));
                      //             },
                      //             child: Column(
                      //               children: [
                      //                 Container(
                      //                   height: size.height * .165,
                      //                   width: size.width * .3,
                      //                   child: Image.network(
                      //                     tvShowBackdropUrl,
                      //                     fit: BoxFit.fill,
                      //                   ),
                      //                 ),
                      //                 Container(
                      //                   height: 30,
                      //                   width: size.width * .3,
                      //                   child: ClipRRect(
                      //                     borderRadius: BorderRadius.all(
                      //                         Radius.circular(5)),
                      //                     child: BackdropFilter(
                      //                       filter: ImageFilter.blur(
                      //                         sigmaX: 100,
                      //                         sigmaY: 100,
                      //                       ),
                      //                       child: Container(
                      //                         padding: EdgeInsets.only(
                      //                             left: 5, right: 5),
                      //                         height: size.width * .07,
                      //                         width: size.width * .33,
                      //                         child: Center(
                      //                           child: FittedBox(
                      //                             fit: BoxFit.scaleDown,
                      //                             child:
                      // Text(
                      //                               _getPeople[i]['name'],
                      //                               style: TextStyle(
                      //                                   color: Colors.white,
                      //                                   fontSize:
                      //                                       size.width * .03),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         ),

                      //         // Container(
                      //         //   child: Text(
                      //         //     _getdata[i]['name'],
                      //         //     style: TextStyle(
                      //         //         fontWeight: FontWeight.bold, color: Colors.black),
                      //         //   ),
                      //         // ),
                      //       )
                      //     ],
                      //   ),
                      // );
                    })
                : Container(
                    //height: size!.width * 0.6,
                    child: Center(
                        child: Text(
                      'No Data Found',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                  ),
      ),
    );
  }
}
