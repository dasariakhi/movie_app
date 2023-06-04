import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CategoryInfo extends StatefulWidget {
  static const routename = "/categories";
  // final String _catergoryname;
  // final String _image;
  //CategoryInfo(this._catergoryname, this._image);

  @override
  State<CategoryInfo> createState() => _CategoryInfoState();
}

class _CategoryInfoState extends State<CategoryInfo> {
  late Size size;
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          margin: EdgeInsets.only(
              left: size.width * .05,
              top: size.width * .15,
              right: size.width * .05,
              bottom: size.width * .05),
          height: size.height * .9,
          width: size.width * .9,
          child: Column(
            children: [
              Container(
                height: size.height * .4,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  //  child: Image.asset(_image),
                ),
              )
            ],
          )),
    );
  }
}
