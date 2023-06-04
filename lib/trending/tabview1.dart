import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import 'package:travelui/screens/displayInfo.dart';

import '../models/provider.dart';

class Tabview1 extends StatefulWidget {
  var urls;
  Tabview1({super.key, @required this.urls});

  @override
  State<Tabview1> createState() => _Tabview1State();
}

class _Tabview1State extends State<Tabview1> {
  late Size size;
  bool _isLoading = true;

  @override
  void initState() {
    getFirstTrendingTVShowName(widget.urls);
    super.initState();
  }

  Future<List<dynamic>> getFirstTrendingTVShowName(urls) async {
    //final url = Uri.parse(widget.urls);
    final response = await http.get(Uri.parse(widget.urls));
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final tvShows = decoded['results'];

      setState(() {
        _gettvshows = tvShows;
        _isLoading = false;
      });
      //listOfMovies=tvShows;
      //print(tvShows[0]['id']);
      return tvShows;
    } else {
      throw Exception('Failed to load trending TV shows');
    }
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  var _gettvshows;
  @override
  Widget build(BuildContext context) {
    var _data = Provider.of<provider>(context);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Visibility(
          visible: _isLoading || _gettvshows.isNotEmpty,
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _gettvshows.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      dragStartBehavior: DragStartBehavior.start,
                      scrollDirection: Axis.horizontal,
                      itemCount: _gettvshows.length,
                      itemBuilder: (context, i) {
                        final tvShowBackdropPath =
                            _gettvshows[i]['backdrop_path'];
                        final tvShowBackdropUrl =
                            'https://image.tmdb.org/t/p/original$tvShowBackdropPath';
                        print(" get id ${_gettvshows[1]['id']}");

                        _data.movieIdForVideos = _gettvshows[1]['id'];

                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) => DisplayInfo(
                                                _gettvshows[i]['title'] ??
                                                    _gettvshows[i]['name'],
                                                tvShowBackdropUrl,
                                                _gettvshows[i]['overview'],
                                                _gettvshows[i]["vote_average"],
                                                _gettvshows[i]['id'])));
                                    print("id plz${_gettvshows[i]['id']}");
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
                                                    _gettvshows[i]['title'] ??
                                                        _gettvshows[i]['name'],
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
                      })
                  : Container(
                      //height: size!.width * 0.6,
                      child: Center(
                          child: Text(
                        'No Data Found',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                    ),
        ));
  }
}
