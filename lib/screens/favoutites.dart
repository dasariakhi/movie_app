import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:travelui/home_page.dart';
import 'package:travelui/models/provider.dart';
import 'package:travelui/screens/home_screen.dart';

import '../models/movies.dart';
import '../subscreens/zoom_drawer.dart';
import '../widgets/custume_drawer.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

late Size size;

class _FavouriteState extends State<Favourite> {
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    Provider.of<provider>(context, listen: false).getUpdatedItemList();
    super.initState();
  }

  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    var _getdata = Provider.of<provider>(context);
    // _getdata.getItemsFromHive();
    // print(_getdata.favouriteItems);

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
            'Favorites',
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
          Consumer<provider>(builder: (context, pro, child) {
            if (pro.favouriteItems == null) {
              return Center(child: CircularProgressIndicator());
            } else if (pro.favouriteItems.isEmpty) {
              // Data is still being fetched
              return Text('No movie results found');
            } else {
              print("${pro.favouriteItems[0].description}");
              return Expanded(
                child: ListView.builder(
                  itemCount: pro.favouriteItems.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: ValueKey(index.toString()),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              backgroundColor: Colors.black87,
                              title: Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
                              content: Text(
                                'Are you sure you want to delete ${pro.favouriteItems[index].name}?',
                                style: TextStyle(color: Colors.white),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    List<Movies> itemList = [
                                      Movies(
                                          pro.favouriteItems[index].name,
                                          pro.favouriteItems[index]
                                              .description),
                                    ];
                                    _getdata.deleteItemFromList(itemList);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Deleted ${pro.favouriteItems[index].name}')),
                                    );
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 26.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Deleted ${pro.favouriteItems[index].name}')),
                        );
                      },
                      // Dismissible(
                      //   key: ValueKey(index.toString()),
                      //   background: Container(
                      //     color: Colors.red,
                      //   ),
                      //   onDismissed: (direction) {
                      // List<Movies> itemList = [
                      //   Movies(pro.favouriteItems[index].name,
                      //       pro.favouriteItems[index].description),
                      // ];

                      //  _getdata.deleteItemFromList(itemList);
                      //   },
                      child: Container(
                        // alignment: Alignment.center,
                        // height: size.height * 0.1,
                        // width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: Stack(children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              height: size.height * 0.25,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  pro.favouriteItems[index].description
                                      .toString(),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  right: size.width * 0.09, top: 20),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, bottom: 0),
                                child: Text(
                                  pro.favouriteItems[index].name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "BraahOne",
                                    fontSize: size.width * .05,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          })
        ])));
  }
}
