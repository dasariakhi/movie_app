import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pagination_flutter/pagination.dart';

import 'package:provider/provider.dart';
import 'package:travelui/widgets/appbar.dart';
import 'package:travelui/widgets/sub_appbar.dart';

import '../home_page.dart';
import '../models/provider.dart';
import '../subscreens/zoom_drawer.dart';
import '../widgets/custume_drawer.dart';
import 'displayInfo.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

late Size size;

class _SearchState extends State<Search> {
  late List<dynamic> _movies = [];
  var SearchUrlString;
  bool _searchActive = false;
  int currentPage = 0;
  var pagenumber = 1;
  bool _isLoading = true;

  var UrlString =
      "https://api.themoviedb.org/3/movie/popular?api_key=3d2f52cdd71d68e2cd7b36e2de3d353c&language=en-US&page=1";
  @override
  void initState() {
    super.initState();
    fetchMovies(1, UrlString);
  }

  Future<void> fetchMovies(pagenumber, UrlString) async {
    final response = await http.get(Uri.parse(UrlString));
    if (response.statusCode == 200) {
      setState(() {
        _movies = jsonDecode(response.body)['results'];
        print(_movies);
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  var _getdata;
  String searchText = "";
  void getMovieSearchResults() async {
    try {
      final originalLanguage =
          await _getdata.fetchMovieSearchResults(searchText);
      // Process the original language here
      print(originalLanguage);
    } catch (e) {
      // Handle the error
      print(e);
    }
  }

  var selectedPage = 1;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    TextEditingController _controller = TextEditingController();
    _getdata = Provider.of<provider>(context, listen: false);

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
          'Search',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: size.width * .05,
              fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(children: [
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: TextField(
              onSubmitted: (String value) {
                setState(() {
                  if (value == "") {
                    fetchMovies(1, UrlString);
                  } else {
                    _searchActive = true;
                    searchText = value;
                    SearchUrlString =
                        "https://api.themoviedb.org/3/search/movie?api_key=3d2f52cdd71d68e2cd7b36e2de3d353c&language=en-US&page=$selectedPage&include_adult=false&query=$searchText";
                    fetchMovies(selectedPage, SearchUrlString);
                  }
                });

                // var search = _getdata.fetchMovieSearchResults(searchText);
                //  print(_getdata.fetchMovieSearchResults(searchText));

                // Perform search or any other action
                print('Search text: $searchText');
              },
              style: TextStyle(color: Colors.white),
              controller: _controller,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // Handle suffix icon click event here
                      setState(() {
                        if (_controller.text == "") {
                          fetchMovies(1, UrlString);
                        } else {
                          _searchActive = true;
                          searchText = _controller.text;
                          SearchUrlString =
                              "https://api.themoviedb.org/3/search/movie?api_key=3d2f52cdd71d68e2cd7b36e2de3d353c&language=en-US&page=$selectedPage&include_adult=false&query=$searchText";
                          fetchMovies(selectedPage, SearchUrlString);
                        }
                      });

                      // var search = _getdata.fetchMovieSearchResults(searchText);
                      //  print(_getdata.fetchMovieSearchResults(searchText));

                      // Perform search or any other action
                      print('Search text: $searchText');
                    },
                  ),
                  fillColor: Color(0xFFF2F2F2),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.green),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  hintText: 'Search here',
                  hintStyle: TextStyle(color: Colors.white)),
            ),
          ),
          _searchActive && searchText != ""
              ? SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            height: size!.width * 0.06,
                            // width: size!.width * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Color.fromARGB(255, 218, 224, 228),
                            ),
                            padding: EdgeInsets.all(2),
                            // Background color of the container
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                // textAlign: TextAlign.justify,
                                searchText,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _searchActive = false;
                              selectedPage = 1;
                              fetchMovies(1, UrlString);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Color.fromARGB(255, 219, 13, 13),
                            ),
                            padding: EdgeInsets.all(2),
                            // Background color of the container
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'clear all',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          Pagination(
            numOfPages: 100,
            selectedPage: selectedPage,
            pagesVisible: 3,
            onPageChanged: (page) {
              setState(() {
                selectedPage = page;
                print(selectedPage);
                setState(() {
                  if (_searchActive == false) {
                    var DifferentPagesUrlString =
                        "https://api.themoviedb.org/3/movie/popular?api_key=3d2f52cdd71d68e2cd7b36e2de3d353c&language=en-US&page=$selectedPage";
                    fetchMovies(selectedPage, DifferentPagesUrlString);
                  } else {
                    SearchUrlString =
                        "https://api.themoviedb.org/3/search/movie?api_key=3d2f52cdd71d68e2cd7b36e2de3d353c&language=en-US&page=$selectedPage&include_adult=false&query=$searchText";
                    fetchMovies(selectedPage, SearchUrlString);
                  }
                });
              });
            },
            nextIcon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 14,
            ),
            previousIcon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 14,
            ),
            activeTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            activeBtnStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(38),
                ),
              ),
            ),
            inactiveBtnStyle: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(38),
              )),
            ),
            inactiveTextStyle: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          _isLoading
              ? CircularProgressIndicator()
              : _movies.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: _movies.length,
                        itemBuilder: (context, index) {
                          final movie = _movies[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => DisplayInfo(
                                      movie['title'] ?? movie['name'],
                                      'https://image.tmdb.org/t/p/w92${movie['poster_path']}',
                                      movie['overview'],
                                      movie["vote_average"],
                                      movie['id'])));
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(6),
                                  height: size!.width * 0.36,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 0.2,
                                      )),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: size!.width * 0.3,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(55)),
                                          child: Image.network(
                                            'https://image.tmdb.org/t/p/w92${movie['poster_path']}',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                movie['title'] ?? movie['name'],
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "BraahOne",
                                                    fontSize: 15),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Average Ratingsmovie  :  ${movie['vote_average'].toStringAsFixed(1)} ***",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    // fontFamily: "BraahOne",
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                "Overview  :  ${movie['overview']}",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    // fontFamily: "BraahOne",
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // ListTile(
                                //   leading: Image.network(
                                //     'https://image.tmdb.org/t/p/w92${movie['poster_path']}',
                                //   ),
                                //   title: Text(movie['title'] ?? movie['name']),
                                //   subtitle: Text(movie['overview']),
                                // ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      height: size!.width * 0.6,
                      child: Center(
                          child: Text(
                        'No Data Found',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                    ),
        ]),
      ),
    );
  }
}
