import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:travelui/models/notification_service.dart';
import 'package:travelui/subscreens/movie_video.dart';

import 'package:travelui/widgets/appbar.dart';

import '../models/movies.dart';
import '../models/provider.dart';

class DisplayInfo extends StatefulWidget {
  final String name;
  final String _images;
  final String description;
  final int movie_id;
  var rating;
  DisplayInfo(
      this.name, this._images, this.description, this.rating, this.movie_id);

  @override
  State<DisplayInfo> createState() => _DisplayInfoState();
}

class _DisplayInfoState extends State<DisplayInfo> {
  Color gradientStart = Colors.transparent;

  Color gradientEnd = Colors.black;

  late Size size;
  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void initState() {
    // openVideoApi();
    super.initState();
    favoriteData();
  }

  var box;
  Future<void> favoriteData() async {
    // Simulating an asynchronous operation
    box = await Hive.openBox('favorite');

    // Update the data
  }

  bool _isCliked = false;
  Widget build(BuildContext context) {
    //Provider.of<provider>(context).fetchMovieVideos(widget.movie_id);

    print("id ${widget.movie_id}");
    var favoriteMoviesProvider = Provider.of<provider>(context);

    // bool isFavorite = favoriteMoviesProvider.favoriteMovies
    //     .any((favoriteMovie) => favoriteMovie.id == movie.id);
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [gradientStart, gradientEnd],
              ).createShader(
                  Rect.fromLTRB(0, -140, rect.width, rect.height - 5));
            },
            blendMode: BlendMode.darken,
            child: Container(
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.9, 1],
                ),
              ),
              child: Image.network(
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  widget._images),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20, left: 3, right: 3),
            //margin: EdgeInsets.only(top: size.height * .47),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        // height: size.width * .17,
                        // color: Colors.white,
                        margin: EdgeInsets.only(top: 30, left: 20, right: 30),
                        child: Align(
                          // alignment: Alignment.topCenter,
                          child: GestureDetector(
                              onTap: () {
                                print("saf");
                                Navigator.of(context).pop();
                              },
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
                                      color: Colors.black54),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        ),
                      ),
                      Spacer(),
                      Container(
                        // height: size.width * .17,
                        // color: Colors.white,
                        margin: EdgeInsets.only(top: 30, left: 20, right: 30),
                        child: Align(
                          // alignment: Alignment.topCenter,
                          child: GestureDetector(
                            onTap: () {
                              NotificationHelper.showNotification();
                              // box.put('items', [widget.name, widget._images]);
                              // print(box.get('items'));
                              List<Movies> itemList = [
                                Movies(widget.name, widget._images)
                              ];
                              //  checkIfStringsExist();
                              setState(() {
                                _isCliked = !_isCliked;
                              });
                              _isCliked
                                  ? favoriteMoviesProvider
                                      .addItemsToList(itemList)
                                  : favoriteMoviesProvider
                                      .deleteItemFromList(itemList);
                              if (_isCliked == true) {
                                SnackBar snackbar = SnackBar(
                                    content: Text("Added to favorite list"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              } else {
                                SnackBar snackBar = SnackBar(
                                    content:
                                        Text("Removed from favorite list"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Container(
                              height: size.width * 0.13,
                              width: size.width * 0.13,
                              //padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black54),
                              child: _isCliked
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.5,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    widget.name,
                                    style: TextStyle(
                                      fontFamily: "BraahOne",
                                      fontSize: size.width * .1,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              // GestureDetector(
                              //     onTap: () {
                              //       // if (isFavorite) {
                              //       //  favoriteMoviesProvider.removeFavoriteMovie(movie);
                              //       // } else {
                              //       //favoriteMoviesProvider.addFavoriteMovie(movie);
                              //       //}
                              //     },
                              //     child: GestureDetector(
                              //       onTap: () {
                              //         Navigator.of(context).pop();
                              //       },
                              //       child: Icon(
                              //         Icons.favorite,
                              //         color: Colors.white,
                              //       ),
                              //     )),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Text("data"),
                          Text(
                            "Average Rating  :  ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(5)),
                            height: size.height * .04,
                            width: size.width * .09,
                            child: Center(
                                child: Text(
                              widget.rating.toStringAsFixed(1),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // margin: EdgeInsets.only(top: size.width * .8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        // alignment: Alignment.bottomCenter,
                        child: Text(
                          textAlign: TextAlign.justify,
                          widget.description,
                          style: TextStyle(
                            // fontFamily: "BraahOne",
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
