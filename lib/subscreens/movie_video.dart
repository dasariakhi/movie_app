import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/provider.dart';

class MovieVideo extends StatefulWidget {
  MovieVideo({
    super.key,
  });

  @override
  State<MovieVideo> createState() => _MovieVideoState();
}

class _MovieVideoState extends State<MovieVideo> {
  late Size size;
  var myState;
  @override
  @override
  void initState() {
    super.initState();

    myState = Provider.of<provider>(context, listen: false).fetchMovieVideos();
  }

  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //print("id ${widget.movie_id}");

    return Consumer<provider>(builder: (context, pro, child) {
      //  print("data ${pro.videos.length}");
      if (pro.videos == null) {
        return Center(child: CircularProgressIndicator());
      } else if (pro.videos.isEmpty) {
        return Text('No movie results found');
      } else {
        return Container(
          height: size.height * 0.19,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pro.videos.length,
                  itemBuilder: (context, index) {
                    final video = pro.videos[index];
                    final videoKey = video['key'];
                    final thumbnailUrl =
                        'https://img.youtube.com/vi/${pro.videos[index]['key']}/0.jpg';
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => YoutubePlayer(
                              // controller: _controller,

                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.red,
                              progressColors: ProgressBarColors(
                                playedColor: Colors.red,
                                handleColor: Colors.redAccent,
                              ),
                              controller: YoutubePlayerController(
                                initialVideoId: videoKey,
                                flags: YoutubePlayerFlags(
                                  mute: false,
                                  autoPlay: true,
                                  disableDragSeek: false,
                                  loop: false,
                                  isLive: false,
                                  forceHD: false,
                                  enableCaption: true,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                          width: size.width * 0.6,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                          child: Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                width: double.infinity,
                                child: Image.network(
                                  thumbnailUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.red,
                                  size: size.width * 0.1,
                                )),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(pro.videos[index]["name"],
                                    style: TextStyle(color: Colors.white)),
                              ),
                            )
                          ])),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}
