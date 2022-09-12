import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memotiapp/pages/products/calendar.dart';
import 'package:memotiapp/pages/products/canvas.dart';
import 'package:memotiapp/pages/products/photobook.dart';
import 'package:memotiapp/pages/products/poster.dart';
import 'package:memotiapp/provider/database.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:memotiapp/provider/appaccess.dart';
import 'package:memotiapp/provider/statics.dart';

import 'package:memotiapp/localization/language/languages.dart';
import 'package:memotiapp/localization/locale_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    print(provider.oncecall);
    if (!provider.oncecall) {

      provider.fetchAllData();
      provider.getIsLoggedIN();
    }
    List<dynamic> data = provider.datumLists();

    return SafeArea(
      child: Scaffold(
          body: provider.datumLists().length > 0
              ? data.length == 0
                  ? Center(child: Text("No Data"))
                  : Column(children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 40 ,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset("assets/images/home_logo.png", fit: BoxFit.contain,),

                      ),
                      Expanded(
                        child: Container(
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                            height: MediaQuery.of(context).size.height - 60,
                            child: ListView.builder(
                                itemCount: data.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return GestureDetector(
                                        child: Column(children: [
                                      getLocal() == 'en_' || getLocal() == 'en'
                                          ? Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.21,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      "assets/images/home_banner.jpg"),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.21,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      "assets/images/home_banner_slovak.jpg"),
                                                ),
                                              ),
                                            ),
                                      Container(
                                          margin:
                                              EdgeInsets.only(bottom: 10, top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 3,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.22,
                                                color: HexColor("CCCED3"),
                                              ),
                                              Text(
                                                Languages.of(context)!.ProductsWeOffer,
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w800,
                                                    fontFamily: Font.quickLightFont,
                                                    color: HexColor("2C2C2C")),
                                              ),
                                              Container(
                                                height: 3,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.22,
                                                color: HexColor("CCCED3"),
                                              )
                                            ],
                                          ))
                                    ]));
                                  } else if (index == 3) {
                                    return Container();
                                  } else {
                                    // Container(
                                    //   child: Text(data[index]["category"]["ii"]),
                                    // )
                                    String img = data[index - 1]["category"]
                                            ["photo"]
                                        .toString();
                                    var images;
                                    if (img == '') {
                                      images = AssetImage(
                                          '${StaticLists.imagesHome[index - 1]}');
                                    } else {
                                      // images = NetworkImage("https://memotiapp.s3.eu-central-1.amazonaws.com/"+data[index-1]["category"]["photo"]);
                                      images =
                                          //  NetworkImage("https://memotiapp.s3.eu-central-1.amazonaws.com/"+data[index-1]["category"]["photo"]);
                                          //  Container(
                                          //    height: 200,
                                          //    width: 100,
                                          //     decoration: BoxDecoration(
                                          //       image: DecorationImage(image: NetworkImage("https://memotiapp.s3.eu-central-1.amazonaws.com/"+data[index-1]["category"]["photo"]),
                                          //       fit: BoxFit.cover)
                                          //     ));
                                          CachedNetworkImage(
                                        width:
                                            MediaQuery.of(context).size.width * 0.9,
                                        fit: BoxFit.fitWidth,
                                        imageUrl:
                                            "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
                                                data[index - 1]["category"]
                                                    ["photo"],
                                        placeholder: (context, url) => Center(
                                            child: SizedBox(
                                          child: CircularProgressIndicator(),
                                          height: 150.0,
                                          width: 150.0,
                                        )),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      );
                                    }
                                    return GestureDetector(
                                      child: Column(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.all(0),
                                              padding: EdgeInsets.all(0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              height: 40,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: HexColor("54C9CF"),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    topRight: Radius.circular(10)),
                                              ),
                                              child: getcategoryTitle(
                                                  provider, index)),
                                          Container(
                                              margin: EdgeInsets.only(bottom: 30),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding: EdgeInsets.all(0),
                                                  margin: EdgeInsets.all(0),
                                                  child: images)),
                                        ],
                                      ),
                                      onTap: () {
                                        provider.setCartIndex(null);
                                        switch (index) {
                                          case 0:
                                            break;
                                          case 1:
                                            //  MemotiDbProvider.db.deleteAllCreationData();
                                            //MemotiDbProvider.db.deleteAllcartData();
                                            provider.setProduct(provider
                                                .datumList[index - 1]["product"]);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PosterSubListPage(provider
                                                              .datumList[index - 1]
                                                          ["product"])),
                                            );
                                            break;
                                          case 2:
                                            provider.setProduct(provider
                                                .datumList[index - 1]["product"]);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PhotobookPage()),
                                            );
                                            break;
                                          case 3:
                                            //   provider.setProduct(provider.datumList[index-1]["product"]);
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(builder: (context) => CalendarPage()));
                                            break;
                                          case 4:
                                            provider.setProduct(provider
                                                .datumList[index - 1]["product"]);
                                            // setcanvasProduct(provider.datumList[index-1]["product"][0]);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CanvasDetailPage()),
                                            );
                                            break;
                                          case 5:
                                            provider.setProduct(provider
                                                .datumList[index - 1]["product"]);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PosterPage()),
                                            );
                                            break;
                                        }
                                      },
                                    );
                                  }
                                })),
                      )
                    ])
              : Center(child: CircularProgressIndicator())),
    );
  }
}
