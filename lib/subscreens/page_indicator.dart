import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travelui/models/provider.dart';

class Page_Indicator extends StatefulWidget {
  const Page_Indicator({super.key});

  @override
  State<Page_Indicator> createState() => _Page_IndicatorState();
}

final controller = PageController(viewportFraction: 0.8, keepPage: true);
final colors = const [
  Colors.red,
  Colors.green,
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.blue,
  Colors.amber,
];
late Size size;
Timer? _timer;

class _Page_IndicatorState extends State<Page_Indicator> {
  var myState;
  @override
  void initState() {
    Provider.of<provider>(context, listen: false).fetchTrending();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
    setState(() {});
  }

  int _currentPage = 0;
  void startAutomaticScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < 5) {
        // If not on the last page, animate to the next page
        controller.animateToPage(
          _currentPage + 1,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        // If on the last page, animate back to the first page
        controller.animateToPage(
          0,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final pages = List.generate(
    //     6,
    //     (index) => Container(
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(10),
    //             color: Colors.grey.shade300,
    //           ),
    //           //margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
    //           child: Container(
    //             //height: size.height * 0.2,
    //             child: Center(
    //                 child: Text(
    //               "Page $index",
    //               style: TextStyle(color: Colors.indigo),
    //             )),
    //           ),
    //         ));
    return SafeArea(
        // ignore: avoid_types_as_parameter_names
        child: Consumer<provider>(builder: (context, pro, child) {
      if (pro.getdata == null) {
        return Center(child: CircularProgressIndicator());
      } else if (pro.getdata.isEmpty) {
        // Data is still being fetched
        return Text('No movie results found');
      } else {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16),
              Container(
                // alignment: Alignment.centerLeft,
                // margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                // width: size.width * .9,
                height: size.height * 0.17,
                //width: double.infinity,
                child: PageView.builder(
                  controller: controller,
                  itemCount: 6,
                  itemBuilder: (_, index) {
                    final tvShowBackdropPath =
                        pro.getdata[index]['backdrop_path'];
                    final tvShowBackdropUrl =
                        'https://image.tmdb.org/t/p/original$tvShowBackdropPath';
                    print("success ${pro.getdata}");
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                tvShowBackdropUrl,
                                fit: BoxFit.cover,
                                width: size.width * 0.9,
                              )),
                        ),
                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              pro.getdata[index]['title'] ??
                                  pro.getdata[index]['name'],
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: size.height * .015),
              SmoothPageIndicator(
                controller: controller,
                count: 6,
                effect: const WormEffect(
                  activeDotColor: Colors.green,
                  dotHeight: 16,
                  dotWidth: 16,
                  type: WormType.normal,
                ),
              ),
            ]);
      }
    }));
  }
}
