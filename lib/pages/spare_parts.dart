import 'dart:ui';

import 'package:esperk/pages/spara/add_spare.dart';
import 'package:flutter/material.dart';
import 'package:esperk/pages/widgets/header_widget.dart';

class SpareParts extends StatefulWidget {
  @override
  SparePartsState createState() => SparePartsState();
}

class SparePartsState extends State<SpareParts> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "                   قطع غيار",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ])),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 200.0),
        child: SingleChildScrollView(
            child: Stack(
          children: [
            // Container(
            //   height: 100,
            //   child: HeaderWidget(100, false, Icons.house_rounded),
            // ),
            // children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 70.0),
                  SizedBox(
                    height: 0.0,
                    child: Text(
                      "    اضافة غيار",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 300, // <-- Your width
                          height: 70,

                          child: MaterialButton(
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            padding: EdgeInsets.only(
                                top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddSpara()));
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // new Image.asset(
                                //   'assets/images/video.png',
                                //   height: 40.0,
                                //   width: 40.0,
                                // ),
                                Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      "     إضافة قطع غيار",
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                            textColor: Color(0xFF292929),
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 0.0, top: 30.0, bottom: 0.0),
                          child: SizedBox(
                            width: 300, // <-- Your width
                            height: 70,
                            child: MaterialButton(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              padding: EdgeInsets.only(
                                  top: 7.0,
                                  bottom: 7.0,
                                  right: 40.0,
                                  left: 7.0),
                              onPressed: () {
                                // Navigator.of(context)
                                //     .pushReplacementNamed(IMAGE_SPLASH);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  // Image.asset('assets/images/image.png',
                                  //     height: 40.0, width: 40.0),
                                  Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        "    تعديل قطع غيار",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25.0),
                                      ))
                                ],
                              ),
                              textColor: Color(0xFF292929),
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 0.0, top: 30.0, bottom: 0.0),
                          child: SizedBox(
                            width: 300, // <-- Your width
                            height: 70,
                            child: MaterialButton(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              padding: EdgeInsets.only(
                                  top: 7.0,
                                  bottom: 7.0,
                                  right: 25.0,
                                  left: 7.0),
                              onPressed: () async {
                                // Navigator
                                //     .of(context)
                                //     .pushReplacementNamed(   );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  // new Image.asset(
                                  //   'assets/images/animation.png',
                                  //   height: 40.0,
                                  //   width: 40.0,
                                  // ),
                                  Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        "   حذف قطع غيار",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25.0),
                                      ))
                                ],
                              ),
                              textColor: Color(0xFF292929),
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
            // ],
            ),
      ),
      // ),
    );
  }
}
