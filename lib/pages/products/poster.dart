import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:camerawesome/camerapreview.dart';
import 'package:camerawesome/models/capture_modes.dart';
import 'package:camerawesome/models/flashmodes.dart';
import 'package:camerawesome/models/orientations.dart';
import 'package:camerawesome/models/sensors.dart';
import 'package:camerawesome/picture_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_editor/image_editor.dart';
import 'package:memotiapp/pages/photo_edit.dart';
import 'package:memotiapp/provider/database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:memotiapp/provider/appaccess.dart';
import 'package:memotiapp/provider/statics.dart';
import 'package:memotiapp/localization/language/languages.dart';
import 'package:memotiapp/localization/locale_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memotiapp/pages/products/newphotoselection.dart';
import 'dart:ui' as ui;

import '../creations.dart';

class PosterPage extends StatefulWidget {
  PosterPage({Key? key}) : super(key: key);

  @override
  _PosterPageState createState() => _PosterPageState();
}

class _PosterPageState extends State<PosterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    // print(provider.currentIndex);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          centerTitle: true,
          title: Text(
            Languages.of(context)!.Cart == null
                ? ""
                : Languages.of(context)!.Cart,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Container(child: Center(child: Text("cart"))));
  }
}

class PosterSubListPage extends StatelessWidget {
  List product;
  PosterSubListPage(this.product);
  @override
  Widget build(BuildContext context) {
    return InnerPosterSubListPage(product);
  }
}

class InnerPosterSubListPage extends StatelessWidget {
  List products;
  InnerPosterSubListPage(this.products);
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    var provider = Provider.of<NavigationProvider>(context);
    provider.setposterData(products);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 2, 16, 8),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/bg.png'),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: _height * 0.07,
                margin: EdgeInsets.only(top: 16, bottom: 16),
                width: _width,
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(Icons.arrow_back, color: Colors.black),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            Languages.of(context)!.Poster,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                    Container(
                      width: _width * .08,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(_width * .08, 0, _width * .08, 8),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      UiData.lorem_ipsum,
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: MyColors.textColor,
                          fontSize: 15,
                          letterSpacing: 1.5,
                          wordSpacing: 2),
                    )),
              ),
              Container(
                height: _height - _height * 0.3,
                child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (_width - 30) * 0.5 / _height / .35,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 8),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PosterDetailPage(products[index], context)),
                        ),
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.white,
                          elevation: 8,
                          shadowColor: Colors.grey[200],
                          child: Column(
                            children: [
                              Expanded(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
                                          products[index]["detail"]["photo"][0],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                      child: SizedBox(
                                    child: CircularProgressIndicator(),
                                    width: 50,
                                    height: 50,
                                  )),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              Container(
                                height: 70,
                                padding: EdgeInsets.fromLTRB(8, 6, 8, 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      langcode == "en" || langcode == "en_"
                                          ? products[index]["detail"]["title"]
                                          : products[index]["detail"]
                                              ["slovaktitle"],
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 4),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Languages.of(context)!.From,
                                            // "",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[350],
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            products[index]["detail"]["sizes"]
                                                    [0]["perpage"] +
                                                " €",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: MyColors.primaryColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PosterDetailPage extends StatelessWidget {
  Map product;
  BuildContext context;
  PosterDetailPage(this.product, this.context);
  @override
  Widget build(BuildContext context) {
    return InnerPosterDetailPage(product, context);
  }
}

class InnerPosterDetailPage extends StatelessWidget {
  late Map product;
  late BuildContext context;
  late List<String> images;
  InnerPosterDetailPage(this.product, this.context);
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    images = [];
    provider.passpostertoProvider(product);
    for (int i = 0; i < provider.product["detail"]["photo"].length; i++) {
      images.add(
          /*Image.network()*/ "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
              provider.product["detail"]["photo"][i]);
    }
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(// Hide the AppBar\
              ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      child: ImageSlider(images),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(16.0, 24.0, 0.0, 0.0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment(-1.0, -1.0),
                  margin: EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        langcode == "en" || langcode == "en_"
                            ? provider.product["detail"]["title"]
                            : provider.product["detail"]["slovaktitle"],
                        style: TextStyle(
                            color: MyColors.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 22),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        Languages.of(context)!.From +
                            provider.doubleminPrice.toStringAsFixed(2) +
                            " € " +
                            " to " +
                            provider.doublemaxPrice.toStringAsFixed(2) +
                            " € ",
                        style: TextStyle(
                            color: MyColors.primaryColor, fontSize: 16),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        langcode == "en" || langcode == "en_"
                            ? provider.product["detail"]["description"]
                            : provider.product["detail"]["slovakdescription"],
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(color: MyColors.textColor, fontSize: 14),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 1.0, color: Colors.black),
                            bottom: BorderSide(width: 1.0, color: Colors.black),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Row(
                                        children: [
                                          // SvgPicture.asset(
                                          //   "assets/icon/icon_environmentfriendly.svg",
                                          Image.asset(
                                            "assets/image-folder/icon_environmentfriendly.png",
                                            height: 30.0,
                                            width: 30.0,
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                            width: 8.0,
                                          ),
                                          Text(
                                            Languages.of(context)!
                                                .EnvironmentFriendly,
                                            maxLines: 2,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          16.0, 16.0, 0.0, 16.0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                              width: 1.0, color: Colors.black),
                                        ),
                                      ),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            // SvgPicture.asset(
                                            //   "assets/icon/icon_superpersonalisable.svg",
                                          Image.asset(
                                            "assets/image-folder/icon_superpersonalisable.png",
                                              height: 30.0,
                                              width: 30.0,
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                              width: 8.0,
                                            ),
                                            Text(
                                              Languages.of(context)!
                                                  .SuperPersonalisable,
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: MyColors.textColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              child: Container(
                                height: 1.0,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Row(
                                        children: [
                                          // SvgPicture.asset(
                                          //   "assets/icon/icon_rigid&durable.svg",
                                          Image.asset(
                                            "assets/image-folder/icon_rigid&durable.png",
                                            height: 30.0,
                                            width: 30.0,
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                            width: 8.0,
                                          ),
                                          Text(
                                            Languages.of(context)!.RigidDurable,
                                            maxLines: 2,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          16.0, 16.0, 0.0, 16.0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                              width: 1.0, color: Colors.black),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          // SvgPicture.asset(
                                          //   "assets/icon/icon_calendar_gift.svg",
                                          Image.asset(
                                            "assets/image-folder/icon_calendar_gift.png",
                                            height: 30.0,
                                            width: 30.0,
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                            width: 8.0,
                                          ),
                                          Text(
                                            Languages.of(context)!.AUniqueGift,
                                            maxLines: 2,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: MyColors.textColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Languages.of(context)!.Getmoredetails,
                            style: TextStyle(
                                color: MyColors.textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          InkWell(
                            splashColor: MyColors.primaryColor,
                            highlightColor: Colors.blue,
                            child: provider.viewVisible
                                ? Icon(Icons.keyboard_arrow_up, size: 30)
                                : Icon(Icons.keyboard_arrow_down, size: 30),
                            onTap: () {
                              provider.showMoreDetail();
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        child: Container(
                          height: 1.0,
                          width: MediaQuery.of(context).size.width * 1.0,
                          color: Colors.black,
                        ),
                      ),
                      Visibility(
                        maintainSize: false,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: provider.viewVisible,
                        replacement: Spacer(),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1.0,
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(String.fromCharCodes(new Runes("\u27A4  ")),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(Languages.of(context)!.Dimensions1515cm3030cmA4A5PortraitA4A5Landscape+provider.sizes.join(", "),
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(String.fromCharCodes(new Runes("\u27A4  ")),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(Languages.of(context)!.Customizewithphotos,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: MyColors.calender_detail_box_bg_ecolour,
                                    border: Border.all(
                                      color: MyColors.calender_detail_box_bg_ecolour,
                                    ),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                                padding:
                                EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Languages.of(context)!.Organiseyouryearmomentsbymomentsinauniquepersonalisedcalendar,
                                      style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: MyColors.primaryColor),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      UiData.lorem_ipsum,
                                      maxLines: 6,
                                      style: TextStyle(fontWeight: FontWeight.w600,fontSize: 13,color: MyColors.textColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          /*child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    Languages.of(context)
                                            .Dimensions1515cm3030cmA4A5PortraitA4A5Landscape +
                                        provider.sizes.join(", "),
                                    style: TextStyle(
                                        color: MyColors.textColor,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    Languages.of(context)!.Customizewithphotos,
                                    style: TextStyle(
                                        color: MyColors.textColor,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color:
                                        MyColors.calender_detail_box_bg_ecolour,
                                    border: Border.all(
                                      color: MyColors
                                          .calender_detail_box_bg_ecolour,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Languages.of(context)
                                          .Organiseyouryearmomentsbymomentsinauniquepersonalisedcalendar,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: MyColors.primaryColor),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      UiData.lorem_ipsum,
                                      maxLines: 6,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: MyColors.textColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),*/
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 16.0),
                        child: Container(
                          height: 45.0,
                          width: MediaQuery.of(context).size.width * 1.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: MyColors.primaryColor,
                            onPressed: () {

                              String id = provider.product["detail"]["ii"].toString();
                              MemotiDbProvider.db.getCreationswithid(id).then((value) {
                                print("photobook creation list");
                                print(value);
                                print(value.length);
                                // if(value.length>0){
                                //   provider.creationsingleprojectList = value;
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(builder: (context) => CreationSingleProductList()),);
                                // }else{
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PosterSizeSelectionPage(
                                                product, context)),
                                  );
                                // }
                              });
                            },
                            child: Text(Languages.of(context)!.CreateNow,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class ImageSlider extends StatefulWidget {
  List<String> images;

  ImageSlider(this.images);

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  CarouselController buttonCarouselController = CarouselController();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.images
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: item,
                          fit: BoxFit.contain,
                          width: 1000.0,
                          placeholder: (context, url) => Center(
                              child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator())),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
    return SizedBox(
      height: 250.0,
      width: MediaQuery.of(context).size.width * 1.0,
      child: Stack(
        children: [
          CarouselSlider(
              items: imageSliders,
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                height: 400,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: imageSliders.length > 1 ? true : false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
                scrollDirection: Axis.horizontal,
              )),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => buttonCarouselController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.chevron_left,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => buttonCarouselController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.chevron_right,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.images.map((image) {
                  int index = widget.images.indexOf(image);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Color.fromRGBO(0, 0, 0, 0.9)
                            : Color.fromRGBO(0, 0, 0, 0.4)),
                  );
                }).toList(),
              ))
        ],
      ),
    );
  }
}

class PosterSizeSelectionPage extends StatelessWidget {
  Map product;
  BuildContext contextmain;
  PosterSizeSelectionPage(this.product, this.contextmain);
  @override
  Widget build(BuildContext context) {
    return InnerPosterSizeSelection(product, contextmain);
  }
}

class InnerPosterSizeSelection extends StatelessWidget {
  Map product;
  BuildContext contextmain;
  InnerPosterSizeSelection(this.product, this.contextmain);
  int postercount = 0;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    if (postercount == 0) {
      print("postercount++");
      postercount++;
      provider.passpostersizetoProvider(product);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          langcode == "en" || langcode == "en_"
              ? provider.product["detail"]["title"]
              : provider.product["detail"]["slovaktitle"],
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              color: HexColor("F0F0F2"),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Card(
                        elevation: 5,
                        child: Container(
                          alignment: Alignment.center,
                          width: provider.width,
                          height: provider.height,
                          color: HexColor("D5D6D8"),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text(
                        provider.price + ' \u{20AC}',
                        style: TextStyle(
                            color: MyColors.textColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: Text(
                  Languages.of(contextmain)!.Size,
                  style: TextStyle(
                      color: MyColors.textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                )),
            //  DIMENSION SIZES LISTVIEW
            Container(
              margin: EdgeInsets.only(left: 6, right: 6),
              height: 80,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.dimensions.length,
                itemBuilder: (BuildContext context, int index) {
                  // print("check noti3");
                  // print(provider.dimensions);
                  // bool isSelected = provider.dimensions[index]["isSelected"];
                  String size = provider.dimensions[index]["sizeInString"];
                  String price = provider.dimensions[index]["price"];

                  return GestureDetector(
                      onTap: () {
                        provider.changeposterDimension(index);
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              width: 120,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: provider.dimensions[index]
                                          ["isSelected"]
                                      ? MyColors.primaryColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: provider.dimensions[index]
                                              ["isSelected"]
                                          ? MyColors.primaryColor
                                          : Colors.black,
                                      width: 2,
                                      style: BorderStyle.solid)),
                              child: Text(
                                size,
                                style: TextStyle(
                                    color: provider.dimensions[index]
                                            ["isSelected"]
                                        ? Colors.white
                                        : MyColors.textColor,
                                    fontSize: 16),
                              ),
                            ),
                            Text(
                              price + ' \u{20AC}',
                              style: TextStyle(
                                  color: MyColors.textColor,
                                  fontSize: 16,
                                  height: 1.5),
                            ),
                          ],
                        ),
                      ));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0.0),
              child: Container(
                height: 1.0,
                width: MediaQuery.of(context).size.width * 1.0,
                color: Colors.grey
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 16.0),
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 1.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: MyColors.primaryColor,
                  onPressed: () {
                    provider.contextmain = contextmain;
                    provider.passtoProvidercanvas(product, "poster");
                    provider.artistApiCall = false;
                    // provider.isGooglemediaitemGet = false;
                    if(provider.isGoogleLoggedIn){
                      provider.listGoogleMediaItem = [];
                      provider.isgoogleLoading = false;
                      provider.listmediaItem("");
                    }
                    provider.setTab(0);
                    //provider.googleSignIn();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewphotoselectionPage("poster")),);
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewPhotoSelction(
                              contextmain,
                              int.parse(
                                  product["detail"]["minpage"].toString()),
                              int.parse(
                                  product["detail"]["maxpage"].toString()),
                              product["detail"]["ii"],
                              provider.price,
                              provider.selectedSize,
                              product["detail"]["title"],
                              product["detail"]["slovaktitle"],
                              "poster")),
                    );*/
                  },
                  child: Text(Languages.of(contextmain)!.Next,
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewPhotoSelction extends StatelessWidget {
  BuildContext contextmain;
  int max_photo;
  int min_photo;
  String product_id;
  String product_price;
  String selectedSize;
  String where;
  String product_name;
  String slovaktitle;

  NewPhotoSelction(
      this.contextmain,
      this.min_photo,
      this.max_photo,
      this.product_id,
      this.product_price,
      this.selectedSize,
      this.product_name,
      this.slovaktitle,
      this.where);

  @override
  Widget build(BuildContext context) {
    //
    return ChangeNotifierProvider<NavigationProvider>(
        create: (BuildContext context) => NavigationProvider(),
        child: NewPhotoSelectionMainView(
            contextmain,
            min_photo,
            max_photo,
            product_id,
            product_price,
            selectedSize,
            product_name,
            slovaktitle,
            where));
  }
}

class NewPhotoSelectionMainView extends StatelessWidget {
  BuildContext contextmain;
  int max_photo;
  String product_price;
  String selectedSize;
  String where;
  String product_name;
  int min_photo;
  String product_id;
  String slovaktitle;

  NewPhotoSelectionMainView(
      this.contextmain,
      this.min_photo,
      this.max_photo,
      this.product_id,
      this.product_price,
      this.selectedSize,
      this.product_name,
      this.slovaktitle,
      this.where);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    provider.max_photo = max_photo;
    provider.where = where;
    provider.min_photo = min_photo;
    // print(min_photo);
    provider.product_id = product_id;
    provider.product_price = product_price;
    provider.selectedSize = selectedSize;
    provider.product_name = product_name;
    provider.slovaktitle = slovaktitle;

    return Scaffold(
      /*appBar: CustomAppBar(
        height: 150,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            firstAppBar(contextmain,context,provider,max_photo,min_photo,where,product_id,product_price,selectedSize,product_name,slovaktitle),
            //where == "photobbokcustomization" ? secondAnotherAppBar(contextmain,context,provider) : secondAppBar(contextmain,context,provider)
          ],
        ),
      ),*/
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.clear, color: Colors.white),
          onPressed: () {
            if(provider.wechatIMages!= null){
              provider.wechatIMages.clear();
              provider.imagess.clear();
              provider.selectedCategoryImage.clear();
              provider.images = [];
            }
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          Languages.of(contextmain)!.SelectPhoto,
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () async {
              // print(provider.where);
              // print(provider.selectedCategoryImage[0]["base64"]);
              // return ;
              if(provider.addinginside){
                 AlertDialog alert = AlertDialog(
                    title: Text(''),
                    content: Text(Languages.of(context)!.WeareprocessingthephotosPLeasewait),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  );
                   showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                return;
              }
              // print(provider.selectedCategoryImage[0]);
              // print(provider.selectedCategoryImage[0]["url_image"]);
              // print(provider.selectedCategoryImage[0]["uint8list"].length);
              // if(provider.selectedCategoryImage[0]["uint8list"].length == 0){
              //   provider.selectedCategoryImage[0]["uint8list"].add(await provider.networkImageToBase64bytes(provider.selectedCategoryImage[0]["url_image"]));
              // }
              // return;
              // print(provider.currentTabIndex);
              // print(provider.imageCount);
              // print(provider.min_photo);
              // for (var x = 0; x < provider.selectedCategoryImage.length; x++) {
                // print(provider.selectedCategoryImage[x]["id"]);
                // print(provider.selectedCategoryImage[x]["base64"]);
              // }
              if (!provider.photoProcessingworking) {
                if (provider.imageCount >= provider.min_photo) {
                  if (provider.imageCount <= provider.max_photo) {
                    List emptyItemList = [];
                    switch (where) {
                      case "photobook":
                        {
                          // Navigator.push(
                          //   context, MaterialPageRoute(builder: (context) => PhotobookCustomizationPage(contextmain,provider.selectedCategoryImage, emptyItemList, where,max_photo,min_photo,product_id,product_price,selectedSize,product_name,slovaktitle,-1)),);
                          break;
                        }
                      case "calendar":
                        {
                          print(product_name);
                          switch (product_name.trim()) {
                            case "Desk":
                              {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(builder: (context) => CalendarAfterImageSelectionPage(contextmain,provider.selectedCategoryImage, where,max_photo,min_photo,product_id,product_price,selectedSize,product_name,slovaktitle),));
                                break;
                              }
                            case "Poster":
                              {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => CalendarPosterPreviewPage(-1,"calendar",contextmain,provider.selectedCategoryImage, max_photo,min_photo,product_id,product_price,selectedSize,product_name,slovaktitle)),);
                                break;
                              }
                            case "Wall":
                              {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(builder: (context) => CalendarAfterImageSelectionPage(contextmain,provider.selectedCategoryImage, where,max_photo,min_photo,product_id,product_price,selectedSize,product_name,slovaktitle),));

                                break;
                              }
                            case "Little Moments":
                              {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(builder: (context) => CalendarAfterImageSelectionPage(contextmain,provider.selec tedCategoryImage, where,max_photo,min_photo,product_id,product_price,selectedSize,product_name,slovaktitle),));

                                break;
                              }

                              print("dd");
                          }
                          break;
                        }
                      case "canvas":
                        {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => CanvasSizeSelectionPage(provider.selectedCategoryImage,contextmain,-1,"canvas")),);
                          break;
                        }

                      case "poster":
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PosterAfterImageSelectionPage(
                                        -1,
                                        "poster",
                                        contextmain,
                                        provider.selectedCategoryImage,
                                        max_photo,
                                        min_photo,
                                        product_id,
                                          product_price,
                                        selectedSize,
                                        product_name,
                                        slovaktitle)),
                          );

                          break;
                        }

                      /*  case "Prints Pack" :{
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => PosterAfterImageSelectionPage(provider.selectedCategoryImage,provider.where,contextmain)),);
                         break;
                       }

                       case "Standard Photo" :{
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => PosterAfterImageSelectionPage(provider.selectedCategoryImage,provider.where,contextmain)),);
                         break;
                       }
                       case "Art Print" :{
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => PosterAfterImageSelectionPage(provider.selectedCategoryImage,provider.where,contextmain)),);
                         break;
                       }*/
                      case "canvascustomization":
                        {
                          Navigator.pop(
                              context, provider.selectedCategoryImage);
                          break;
                        }
                      case "photobbokcustomization":
                        {
                          Navigator.pop(
                              context, provider.selectedCategoryImage);
                          break;
                        }
                      case "postercustomization":
                        {
                          Navigator.pop(
                              context, provider.selectedCategoryImage);
                          break;
                        }
                      default :{
                        Navigator.pop(
                            context, provider.selectedCategoryImage);
                        break;
                      }
                    }
                  } else {
                    provider.setMaxPhotoImageCheck(context);
                    _showMyDialog(contextmain, context, provider);
                  }
                } else {
                  provider.setMiniPhotoImageCheck(context);
                  _showMyDialog(contextmain, context, provider);
                }
              } else {
                provider.setIMageProcessingDialog(context);
                _showMyDialog(contextmain, context, provider);
              }
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    // Replace image
                    Languages.of(contextmain)!.Done,
                    // "",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          /* Padding(
            padding: EdgeInsets.fromLTRB(0.0, 17.0, 20.0, 0.0),
            child: GestureDetector(
              child: Text(
                Languag/es.of(contextmain).Creations,
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              onTap: () => provider.addcreation(context),
            ),
          ),*/
        ],
      ),
      // floatingActionButton: Visibility(
      //     visible: provider.show_fab_button,
      //     child: FloatingActionButton(
      //       backgroundColor: MyColors.primaryColor,
      //         child: Icon(Icons.camera), onPressed: () {
      //         provider.getCameraImage(provider, context);
      //         },
      //     ),
      // ),
      body: Column(
        children: [
          where == "photobbokcustomization"
              ? secondAnotherAppBar(contextmain, context, provider)
              : secondAppBar(contextmain, context, provider),
          Expanded(
            child: Stack(
              children: [
                Visibility(
                  visible: provider.currentTabIndex == 0,
                  child:
                      provider.getPhotoGallery(contextmain, provider, context),
                  maintainState: true,
                  maintainSize: false,
                ),
                Visibility(
                  visible: provider.currentTabIndex == 1,
                  child: MemotiGalleryScreen(provider, context),
                  maintainState: true,
                  maintainSize: false,
                ),
                Visibility(
                  visible: provider.currentTabIndex == 2,
                  child: GoogleGalleryScreen(provider, context),
                  maintainState: true,
                  maintainSize: false,
                ),
                Visibility(
                  visible: provider.currentTabIndex == 3,
                  child: FacebookGalleryScreen(contextmain),
                  maintainState: true,
                  maintainSize: false,
                ),
                Visibility(
                  visible: provider.currentTabIndex == 4,
                  child: InstaGramGalleryScreen(contextmain, provider),
                  maintainState: true,
                  maintainSize: false,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: MyColors.primaryColor,
        unselectedItemColor: HexColor("CDCFD3"),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            activeIcon:
                SvgPicture.asset("assets/icon/IconSelected_PhoneGallery.svg"),
            icon:
                SvgPicture.asset("assets/icon/IconUnselected_PhoneGallery.svg"),
            label: Languages.of(contextmain)!.PhoneGallery,
          ),
          BottomNavigationBarItem(
            activeIcon:
                SvgPicture.asset("assets/icon/IconSelected_MemotiGallery.svg"),
            icon: SvgPicture.asset(
                "assets/icon/IconUnselected_MemotiGallery.svg"),
            label: Languages.of(contextmain)!.MemotiGallery,
          ),
          BottomNavigationBarItem(
            activeIcon:
                SvgPicture.asset("assets/icon/IconSelected_GooglePhotos.svg"),
            icon:
                SvgPicture.asset("assets/icon/IconUnselected_GooglePhotos.svg"),
            label: Languages.of(contextmain)!.GooglePhoto,
          ),
          BottomNavigationBarItem(
            activeIcon:
                SvgPicture.asset("assets/icon/IconSelected_Facebook.svg"),
            icon: SvgPicture.asset("assets/icon/IconUnselected_Facebook.svg"),
            label: Languages.of(contextmain)!.Facebook + "\n ",
          ),
          BottomNavigationBarItem(
            activeIcon:
                SvgPicture.asset("assets/icon/IconSelected_Instagram.svg"),
            icon: SvgPicture.asset("assets/icon/IconUnselected_Instagram.svg"),
            label: Languages.of(contextmain)!.Instagram + "\n ",
          ),
        ],
        currentIndex: provider.currentTabIndex,
        onTap: provider.setTab,
      ),
    );
  }
}

Widget firstAppBar(
    BuildContext contextmain,
    BuildContext context,
    NavigationProvider provider,
    int maxPhoto,
    int minPhoto,
    String where,
    String productId,
    String productPrice,
    String selectedSize,
    String productName,
    String slovaktitle) {
  return Container(
    //padding: EdgeInsets.fromLTRB(4, 20, 0, 0),
    color: MyColors.primaryColor,
    height: 105,
    width: MediaQuery.of(context).size.width,
    child: Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: IconButton(
                icon: Icon(Icons.clear, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                Languages.of(contextmain)!.SelectPhoto,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                print(provider.where);
                print(provider.currentTabIndex);
                print(provider.imageCount);
                print(provider.min_photo);
                for (var x = 0;
                    x < provider.selectedCategoryImage.length;
                    x++) {
                  print(provider.selectedCategoryImage[x].id);
                }
                if (!provider.photoProcessingworking) {
                  if (provider.imageCount >= provider.min_photo) {
                    if (provider.imageCount <= provider.max_photo) {
                      List emptyItemList = [];
                      switch (where) {
                        case "photobook":
                          {
                            //  Navigator.push(
                            //    context, MaterialPageRoute(builder: (context) => PhotobookCustomizationPage(contextmain,provider.selectedCategoryImage, emptyItemList, where,max_photo,min_photo,product_id,product_price,selectedSize,product_name,slovaktitle,-1)),);
                            break;
                          }
                        case "calendar":
                          {
                            print(productName);
                            switch (productName.trim()) {
                              case "Desk":
                                {
                                  //  Navigator.push(
                                  //    context,
                                  //    MaterialPageRoute(builder: (context) => CalendarAfterImageSelectionPage(contextmain,provider.selectedCategoryImage, where,max_photo,min_photo,product_id,product_price,selectedSize,product_name,slovaktitle),));
                                  break;
                                }
                              case "Poster":
                                {
                                  //  Navigator.push(
                                  //    context,
                                  //    MaterialPageRoute(builder: (context) => CalendarPosterPreviewPage(-1,"calendar",contextmain,provider.selectedCategoryImage, max_photo,min_photo,product_id,product_price,selectedSize,product_name,slovaktitle)),);
                                  break;
                                }
                              case "Wall":
                                {
                                  //  Navigator.push(
                                  //      context,
                                  //      MaterialPageRoute(builder: (context) => CalendarAfterImageSelectionPage(contextmain,provider.selectedCategoryImage, where,max_photo,min_photo,product_id,product_price,selectedSize,product_name,slovaktitle),));

                                  break;
                                }
                              case "Little Moments":
                                {
                                  //  Navigator.push(
                                  //      context,
                                  //      MaterialPageRoute(builder: (context) => CalendarAfterImageSelectionPage(contextmain,provider.selectedCategoryImage, where,max_photo,min_photo,product_id,product_price,selectedSize,product_name,slovaktitle),));

                                  break;
                                }

                                print("dd");
                            }
                            break;
                          }
                        case "canvas":
                          {
                            //  Navigator.push(
                            //    context,
                            //    MaterialPageRoute(builder: (context) => CanvasSizeSelectionPage(provider.selectedCategoryImage,contextmain,-1,"canvas")),);
                            break;
                          }

                        case "poster":
                          {
                            //  Navigator.push(
                            //    context,
                            //    MaterialPageRoute(builder: (context) => PosterAfterImageSelectionPage(-1,"poster",contextmain, provider.selectedCategoryImage,max_photo,min_photo,product_id,product_price,selectedSize,product_name,slovaktitle)),);

                            break;
                          }

                        /*  case "Prints Pack" :{
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => PosterAfterImageSelectionPage(provider.selectedCategoryImage,provider.where,contextmain)),);
                         break;
                       }

                       case "Standard Photo" :{
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => PosterAfterImageSelectionPage(provider.selectedCategoryImage,provider.where,contextmain)),);
                         break;
                       }
                       case "Art Print" :{
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => PosterAfterImageSelectionPage(provider.selectedCategoryImage,provider.where,contextmain)),);
                         break;
                       }*/
                        case "canvascustomization":
                          {
                            Navigator.pop(
                                context, provider.selectedCategoryImage);
                            break;
                          }
                        case "photobbokcustomization":
                          {
                            Navigator.pop(
                                context, provider.selectedCategoryImage);
                            break;
                          }
                        case "postercustomization":
                          {
                            Navigator.pop(
                                context, provider.selectedCategoryImage);
                            break;
                          }
                      }
                    } else {
                      provider.setMaxPhotoImageCheck(context);
                      _showMyDialog(contextmain, context, provider);
                    }
                  } else {
                    provider.setMiniPhotoImageCheck(context);
                    _showMyDialog(contextmain, context, provider);
                  }
                } else {
                  provider.setIMageProcessingDialog(context);
                  _showMyDialog(contextmain, context, provider);
                }
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      Languages.of(contextmain)!.Done,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> _showMyDialog(BuildContext contextmain, BuildContext context,
    NavigationProvider provider) async {
  return showDialog<void>(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(provider.dialog_title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(provider.dialog_text),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
              child: Text(Languages.of(contextmain)!.Ok),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      );
    },
  );
}

Widget secondAnotherAppBar(BuildContext contextmain, BuildContext context,
    NavigationProvider provider) {
  return Container(
    height: 45,
    width: MediaQuery.of(context).size.width,
    child: Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
        child: Text(
          Languages.of(contextmain)!.Selected +
              "(" +
              provider.imageCount.toString() +
              "/" +
              provider.min_photo.toString() +
              ")",
          style: TextStyle(
              color: MyColors.primaryColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}

Widget setupAlertDialoadContainer(
    NavigationProvider provider, BuildContext context) {
  return Container(
    height: 100.0, // Change as per your requirement
    width: 100.0, // Change as per your requirement
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget setupAlertDialoadContainer2(
    BuildContext contextmain, BuildContext context, String text) {
  return Container(
    height: 200.0, // Change as per your requirement
    width: 200.0, // Change as per your requirement
    child: Column(
      children: [
        Text(text),
        SizedBox(
          height: 28,
        ),
        RaisedButton(
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
            side: BorderSide(color: MyColors.primaryColor),
          ),
          color: MyColors.primaryColor,
          child: Container(
            height: 45,
            width: MediaQuery.of(context).size.width * .4,
            child: Center(
              child: Text(
                Languages.of(contextmain)!.Close,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}

Widget secondAppBar(BuildContext contextmain, BuildContext context,
    NavigationProvider provider) {
  return Container(
    height: 45,
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.only(top: 5, bottom: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () {
              provider.unselectAll();
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
              child: Text(
                Languages.of(contextmain)!.UnselectAll,
                style: TextStyle(
                    color: MyColors.primaryColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        // Container(
        //    width: 100,
        //       decoration: BoxDecoration(
        //           // border: Border.all(color: MyColors.textColor, width: 2),
        //     color: MyColors.primaryColor,
        //           borderRadius: BorderRadius.all(Radius.circular(6))),
        //    child: IconButton(
        //     icon: Text("Choose images", style: TextStyle(color: Colors.white, fontSize: 11),),
        //     onPressed: provider.loadAssets,
        //   )
        // ),
        Visibility(
          visible: false,
          child: Align(
            alignment: Alignment.center,
            child: provider.where == "photobook"
                ? GestureDetector(
                    onTap: () {
                      /*if(provider.isautoselectedimageget){
                  provider.checkCategoryImageLengthGreaterThanMinPhoto().then((value) {
                    if(value){
                      provider.AutoSelectPhotos().then((value) {
                        List<PhotoBookCustomModel> emptyItemList = [];
                        print("valse.lenght - "+value.length.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AutoSelectionScreen(contextmain,value,emptyItemList,provider.where,provider.max_photo,provider.min_photo,provider.product_id,provider.product_price,provider.selectedSize,provider.product_name,provider.slovaktitle)),);
                      });
                    }else{
                      showDialog(
                          context: context,
                          useRootNavigator: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(Languages.of(contextmain)!.Alert),
                              content: setupAlertDialoadContainer2( contextmain,context,Languages.of(contextmain)!.PhotogalleryimageslengtharelessthanminimumphotorequirementYouhavetoaddmoreimagesorchoodeotheroption),);
                          });
                    }
                  });
                }else{
                  provider.autoselcttap = true;
                  showDialog(
                      context: context,
                      useRootNavigator: false,
                      builder: (  BuildContext context) {
                        return AlertDialog(
                          title: Text(Languages.of(contextmain)!.Gettingphotos),
                          content: setupAlertDialoadContainer2( contextmain,context,Languages.of(contextmain)!.waitforamoment),);
                      });
                }*/
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: MyColors.textColor, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Text(
                        Languages.of(contextmain)!.AutoSelect,
                        style: TextStyle(
                            color: MyColors.textColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                : Container(),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
            child: Text(
              Languages.of(contextmain)!.Selected +
                  "(" +
                  provider.imageCount.toString() +
                  "/" +
                  provider.max_photo.toString() +
                  ")",
              style: TextStyle(
                  color: MyColors.primaryColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    ),
  );
}

class CustomAppBar extends PreferredSize {
  late Widget child;
  late double height;
  @override
  Size get preferredSize => Size.fromHeight(height);

  CustomAppBar({required this.child, this.height = kToolbarHeight}) : super(child: child, preferredSize: Size.fromHeight(height));


  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.white,
      alignment: Alignment.center,
      child: child,
    );
  }
}

class CameraClass extends StatefulWidget {
  final bool randomPhotoName;
  CameraClass({this.randomPhotoName = true});
  @override
  _CameraClassState createState() => _CameraClassState();
}

class _CameraClassState extends State<CameraClass>
    with TickerProviderStateMixin {
  late String _lastPhotoPath, _lastVideoPath;
  bool _focus = false, _fullscreen = true, _isRecordingVideo = false;

  ValueNotifier<CameraFlashes> _switchFlash = ValueNotifier(CameraFlashes.NONE);
  ValueNotifier<double> _zoomNotifier = ValueNotifier(0);
  ValueNotifier<Size> _photoSize = ValueNotifier(Size(0, 0));
  ValueNotifier<Sensors> _sensor = ValueNotifier(Sensors.BACK);
  ValueNotifier<CaptureModes> _captureMode = ValueNotifier(CaptureModes.PHOTO);
  ValueNotifier<bool> _enableAudio = ValueNotifier(true);
  ValueNotifier<CameraOrientations> _orientation =
      ValueNotifier(CameraOrientations.PORTRAIT_UP);
  File? img = null;
  bool imgget = false;

  /// use this to call a take picture
  PictureController _pictureController = PictureController();

  /// use this to record a video
  VideoController _videoController = VideoController();

  /// list of available sizes
  late List<Size> _availableSizes;

  late AnimationController _iconsAnimationController, _previewAnimationController;
  late Animation<Offset> _previewAnimation;
  late Timer _previewDismissTimer;
  // StreamSubscription<Uint8List> previewStreamSub;
  late Stream<Uint8List> previewStream;

  get imgUtils => null;

  @override
  void initState() {
    super.initState();
    _iconsAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _previewAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1300),
      vsync: this,
    );
    _previewAnimation = Tween<Offset>(
      begin: const Offset(-2.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _previewAnimationController,
        curve: Curves.elasticOut,
        reverseCurve: Curves.elasticIn,
      ),
    );
  }

  @override
  void dispose() {
    _iconsAnimationController.dispose();
    _previewAnimationController.dispose();
    // previewStreamSub.cancel();
    _photoSize.dispose();
    _captureMode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          /*imgget?Container():*/ this._fullscreen
              ? buildFullscreenCamera()
              : buildFullscreenCamera() /*buildSizedScreenCamera()*/,
          /*imgget?Container():*/ _buildInterface(),
          imgget
              ? Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    color: Colors.black,
                    child: Center(
                        child: img == null
                            ? Container()
                            : Image.file(
                                img!,
                                fit: BoxFit.cover,
                              )),
                  ),
                )
              : Container(),
          imgget
              ? SafeArea(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: ClipOval(
                        child: Material(
                          color: Color(0xFF4F6AFF),
                          child: InkWell(
                            child: SizedBox(
                              width: 48,
                              height: 48,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 24.0,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                imgget = false;
                                img = null;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 34),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipOval(
                            child: Material(
                              color: Color(0xFF4F6AFF),
                              child: InkWell(
                                child: SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    imgget = false;
                                    img = null;
                                  });
                                },
                              ),
                            ),
                          ),
                          ClipOval(
                            child: Material(
                              color: Color(0xFF4F6AFF),
                              child: InkWell(
                                child: SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context, img);
                                  imgget = false;
                                  img = null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
              : Container(),
          /* (!_isRecordingVideo)
              ? PreviewCardWidget(
            lastPhotoPath: _lastPhotoPath,
            orientation: _orientation,
            previewAnimation: _previewAnimation,
          )
              : Container(),*/
        ],
      ),
    );
  }

  Widget _buildInterface() {
    return Stack(
      children: <Widget>[
        SafeArea(
          bottom: false,
          child: TopBarWidget(
              isFullscreen: _fullscreen,
              isRecording: _isRecordingVideo,
              enableAudio: _enableAudio,
              photoSize: _photoSize,
              captureMode: _captureMode,
              switchFlash: _switchFlash,
              orientation: _orientation,
              rotationController: _iconsAnimationController,
              onFlashTap: () {
                switch (_switchFlash.value) {
                  case CameraFlashes.NONE:
                    _switchFlash.value = CameraFlashes.ON;
                    break;
                  case CameraFlashes.ON:
                    _switchFlash.value = CameraFlashes.AUTO;
                    break;
                  case CameraFlashes.AUTO:
                    _switchFlash.value = CameraFlashes.ALWAYS;
                    break;
                  case CameraFlashes.ALWAYS:
                    _switchFlash.value = CameraFlashes.NONE;
                    break;
                }
                setState(() {});
              },
              onAudioChange: () {
                this._enableAudio.value = !this._enableAudio.value;
                setState(() {});
              },
              onChangeSensorTap: () {
                this._focus = !_focus;
                if (_sensor.value == Sensors.FRONT) {
                  _sensor.value = Sensors.BACK;
                } else {
                  _sensor.value = Sensors.FRONT;
                }
              },
              onResolutionTap: () => _buildChangeResolutionDialog(),
              onFullscreenTap: () {
                this._fullscreen = !this._fullscreen;
                setState(() {});
              }),
        ),
        BottomBarWidget(
          onZoomInTap: () {
            if (_zoomNotifier.value <= 0.9) {
              _zoomNotifier.value += 0.1;
            }
            setState(() {});
          },
          onZoomOutTap: () {
            if (_zoomNotifier.value >= 0.1) {
              _zoomNotifier.value -= 0.1;
            }
            setState(() {});
          },
          onCaptureModeSwitchChange: () {
            if (_captureMode.value == CaptureModes.PHOTO) {
              _captureMode.value = CaptureModes.VIDEO;
            } else {
              _captureMode.value = CaptureModes.PHOTO;
            }
            setState(() {});
          },
          onCaptureTap: (_captureMode.value == CaptureModes.PHOTO)
              ? _takePhoto
              //: _recordVideo,
              : _takePhoto,
          rotationController: _iconsAnimationController,
          orientation: _orientation,
          isRecording: _isRecordingVideo,
          captureMode: _captureMode,
        ),
      ],
    );
  }

  _takePhoto() async {
    final Directory extDir = await getTemporaryDirectory();
    final testDir =
        await Directory('${extDir.path}/test').create(recursive: true);
    final String filePath = widget.randomPhotoName
        ? '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg'
        : '${testDir.path}/photo_test.jpg';
    await _pictureController.takePicture(filePath);
    // lets just make our phone vibrate
    HapticFeedback.mediumImpact();
    _lastPhotoPath = filePath;
    setState(() {});
    if (_previewAnimationController.status == AnimationStatus.completed) {
      _previewAnimationController.reset();
    }
    _previewAnimationController.forward();
    print("----------------------------------");
    // print("TAKE PHOTO CALLED");
    final file = new File(filePath);
    // print("==> hastakePhoto : ${file.exists()} | path : $filePath");
    setState(() {
      img = file;
      imgget = true;
    });
    final imgq = imgUtils.decodeImage(file.readAsBytesSync());
    // print("==> img.width : ${imgq.width} | img.height : ${imgq.height}");

    print("----------------------------------");
  }

  /*_recordVideo() async {
    // lets just make our phone vibrate
    HapticFeedback.mediumImpact();

    if (this._isRecordingVideo) {
      await _videoController.stopRecordingVideo();

      _isRecordingVideo = false;
      setState(() {});

      final file = File(_lastVideoPath);
      print("----------------------------------");
      print("VIDEO RECORDED");
      print(
          "==> has been recorded : ${file.exists()} | path : $_lastVideoPath");
      print("----------------------------------");

      await Future.delayed(Duration(milliseconds: 300));
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraPreview(
            videoPath: _lastVideoPath,
          ),
        ),
      );
    } else {
      final Directory extDir = await getTemporaryDirectory();
      final testDir =
      await Directory('${extDir.path}/test').create(recursive: true);
      final String filePath = widget.randomPhotoName
          ? '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4'
          : '${testDir.path}/video_test.mp4';
      await _videoController.recordVideo(filePath);
      _isRecordingVideo = true;
      _lastVideoPath = filePath;
      setState(() {});
    }
  }*/

  _buildChangeResolutionDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => ListTile(
          key: ValueKey("resOption"),
          onTap: () {
            this._photoSize.value = _availableSizes[index];
            setState(() {});
            Navigator.of(context).pop();
          },
          leading: Icon(Icons.aspect_ratio),
          title: Text(
              "${_availableSizes[index].width}/${_availableSizes[index].height}"),
        ),
        separatorBuilder: (context, index) => Divider(),
        itemCount: _availableSizes.length,
      ),
    );
  }

  _onOrientationChange(CameraOrientations newOrientation) {
    _orientation.value = newOrientation;
    if (_previewDismissTimer != null) {
      _previewDismissTimer.cancel();
    }
  }

  _onPermissionsResult(bool granted) {
    if (!granted) {
      AlertDialog alert = AlertDialog(
        title: Text('Error'),
        content: Text(
            'It seems you doesn\'t authorized some permissions. Please check on your settings and try again.'),
        actions: [
          TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }),
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      setState(() {});
      print("granted");
    }
  }

  // /// this is just to preview images from stream
  // /// This use a bufferTime to take an image each 1500 ms
  // /// you cannot show every frame as flutter cannot draw them fast enough
  // /// [THIS IS JUST FOR DEMO PURPOSE]
  // Widget _buildPreviewStream() {
  //   if (previewStream == null) return Container();
  //   return Positioned(
  //     left: 32,
  //     bottom: 120,
  //     child: StreamBuilder(
  //       stream: previewStream.bufferTime(Duration(milliseconds: 1500)),
  //       builder: (context, snapshot) {
  //         print(snapshot);
  //         if (!snapshot.hasData || snapshot.data == null) return Container();
  //         List<Uint8List> data = snapshot.data;
  //         print(
  //             "...${DateTime.now()} new image received... ${data.last.lengthInBytes} bytes");
  //         return Image.memory(
  //           data.last,
  //           width: 120,
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget buildFullscreenCamera() {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: Center(
        child: CameraAwesome(
          onPermissionsResult: _onPermissionsResult(false),
          selectDefaultSize: (availableSizes) {
            this._availableSizes = availableSizes;
            return availableSizes[1];
          },
          captureMode: _captureMode,
          photoSize: _photoSize,
          sensor: _sensor,
          enableAudio: _enableAudio,
          switchFlashMode: _switchFlash,
          zoom: _zoomNotifier,
          // onOrientationChanged: _onOrientationChange,
          // imagesStreamBuilder: (imageStream) {
          //   /// listen for images preview stream
          //   /// you can use it to process AI recognition or anything else...
          //   print("-- init CamerAwesome images stream");
          //   setState(() {
          //     previewStream = imageStream;
          //   });

          //   imageStream.listen((Uint8List imageData) {
          //     print(
          //         "...${DateTime.now()} new image received... ${imageData.lengthInBytes} bytes");
          //   });
          // },
          onCameraStarted: () {
            // camera started here -- do your after start stuff
          },
        ),
      ),
    );
  }

  Widget buildSizedScreenCamera() {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: Container(
        color: Colors.black,
        child: Center(
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: CameraAwesome(
              onPermissionsResult: _onPermissionsResult(false),
              selectDefaultSize: (availableSizes) {
                this._availableSizes = availableSizes;
                return availableSizes[0];
              },
              captureMode: _captureMode,
              photoSize: _photoSize,
              sensor: _sensor,
              fitted: true,
              switchFlashMode: _switchFlash,
              zoom: _zoomNotifier,
              // onOrientationChanged: _onOrientationChange,
            ),
          ),
        ),
      ),
    );
  }
}

class BottomBarWidget extends StatelessWidget {
  final AnimationController rotationController;
  final ValueNotifier<CameraOrientations> orientation;
  final ValueNotifier<CaptureModes> captureMode;
  final bool isRecording;
  final Function onZoomInTap;
  final Function onZoomOutTap;
  final Function onCaptureTap;
  final Function onCaptureModeSwitchChange;

  const BottomBarWidget({
    Key? key,
    required this.rotationController,
    required this.orientation,
    required this.isRecording,
    required this.captureMode,
    required this.onZoomOutTap,
    required this.onZoomInTap,
    required this.onCaptureTap,
    required this.onCaptureModeSwitchChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            Container(
              color: Colors.black12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    /*  OptionButton(
                      icon: Icons.zoom_out,
                      rotationController: rotationController,
                      orientation: orientation,
                      onTapCallback: () => onZoomOutTap?.call(),
                    ),*/
                    CameraButton(
                      key: ValueKey('cameraButton'),
                      captureMode: captureMode.value,
                      isRecording: isRecording,
                      onTap: () =>
                          onCaptureTap.call(),
                    ),
                    /*OptionButton(
                      icon: Icons.zoom_in,
                      rotationController: rotationController,
                      orientation: orientation,
                      onTapCallback: () => onZoomInTap?.call(),
                    ),*/
                  ],
                ),
                SizedBox(height: 10.0),
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo_camera,
                      color: Colors.white,
                    ),
                    Switch(
                      key: ValueKey('captureModeSwitch'),
                      value: (captureMode.value == CaptureModes.VIDEO),
                      activeColor: Color(0xFF4F6AFF),
                      onChanged: !isRecording
                          ? (value) {
                        HapticFeedback.heavyImpact();
                        onCaptureModeSwitchChange?.call();
                      }
                          : null,
                    ),
                    */ /*Icon(
                      Icons.videocam,
                      color: Colors.white,
                    ),*/ /*
                  ],
                ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TopBarWidget extends StatelessWidget {
  final bool isFullscreen;
  final bool isRecording;
  final ValueNotifier<Size> photoSize;
  final AnimationController rotationController;
  final ValueNotifier<CameraOrientations> orientation;
  final ValueNotifier<CaptureModes> captureMode;
  final ValueNotifier<bool> enableAudio;
  final ValueNotifier<CameraFlashes> switchFlash;
  final Function onFullscreenTap;
  final Function onResolutionTap;
  final Function onChangeSensorTap;
  final Function onFlashTap;
  final Function onAudioChange;

  const TopBarWidget({
    Key? key,
    required this.isFullscreen,
    required this.isRecording,
    required this.captureMode,
    required this.enableAudio,
    required this.photoSize,
    required this.orientation,
    required this.rotationController,
    required this.switchFlash,
    required this.onFullscreenTap,
    required this.onAudioChange,
    required this.onFlashTap,
    required this.onChangeSensorTap,
    required this.onResolutionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ClipOval(
                    child: Material(
                      color: Color(0xFF4F6AFF),
                      child: InkWell(
                        child: SizedBox(
                          width: 48,
                          height: 48,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24.0,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  /* Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Opacity(
                      opacity: isRecording ? 0.3 : 1.0,
                      child: IconButton(
                        icon: Icon(
                          isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                          color: Colors.white,
                        ),
                        onPressed:
                        isRecording ? null : () => onFullscreenTap?.call(),
                      ),
                    ),
                  ),*/
                  /*Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IgnorePointer(
                          ignoring: isRecording,
                          child: Opacity(
                            opacity: isRecording ? 0.3 : 1.0,
                            child: ValueListenableBuilder(
                              valueListenable: photoSize,
                              builder: (context, value, child) => TextButton(
                                key: ValueKey("resolutionButton"),
                                onPressed: () {
                                  HapticFeedback.selectionClick();

                                  onResolutionTap?.call();
                                },
                                child: Text(
                                  '${value?.width?.toInt()} / ${value?.height?.toInt()}',
                                  key: ValueKey("resolutionTxt"),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  OptionButton(
                    icon: Icons.switch_camera,
                    rotationController: rotationController,
                    orientation: orientation,
                    onTapCallback: () => onChangeSensorTap.call(), isEnabled: false,
                  ),
                  SizedBox(width: 20.0),
                  OptionButton(
                    rotationController: rotationController,
                    icon: _getFlashIcon(),
                    orientation: orientation,
                    onTapCallback: () => onFlashTap.call(), isEnabled: false,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              captureMode.value == CaptureModes.VIDEO
                  ? OptionButton(
                      icon: enableAudio.value ? Icons.mic : Icons.mic_off,
                      rotationController: rotationController,
                      orientation: orientation,
                      isEnabled: !isRecording,
                      onTapCallback: () => onAudioChange.call(),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getFlashIcon() {
    switch (switchFlash.value) {
      case CameraFlashes.NONE:
        return Icons.flash_off;
      case CameraFlashes.ON:
        return Icons.flash_on;
      case CameraFlashes.AUTO:
        return Icons.flash_auto;
      case CameraFlashes.ALWAYS:
        return Icons.highlight;
      default:
        return Icons.flash_off;
    }
  }
}

class OptionButton extends StatefulWidget {
  final IconData icon;
  final Function onTapCallback;
  final AnimationController rotationController;
  final ValueNotifier<CameraOrientations> orientation;
  final bool isEnabled;
  OptionButton({
    Key? key,
    required this.icon,
    required this.onTapCallback,
    required this.rotationController,
    required this.orientation,
    required this.isEnabled,
  }) : super(key: key);

  @override
  _OptionButtonState createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton>
    with SingleTickerProviderStateMixin {
  double? _angle = 0.0;
  CameraOrientations _oldOrientation = CameraOrientations.PORTRAIT_UP;

  @override
  void initState() {
    super.initState();

    Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(widget.rotationController)
        .addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _oldOrientation = OrientationUtils.convertRadianToOrientation(_angle!);
      }
    });

    widget.orientation.addListener(() {
      // _angle =
      //     OrientationUtils.convertOrientationToRadian(widget.orientation.value);

      if (widget.orientation.value == CameraOrientations.PORTRAIT_UP) {
        widget.rotationController.reverse();
      } else if (_oldOrientation == CameraOrientations.LANDSCAPE_LEFT ||
          _oldOrientation == CameraOrientations.LANDSCAPE_RIGHT) {
        widget.rotationController.reset();

        if ((widget.orientation.value == CameraOrientations.LANDSCAPE_LEFT ||
            widget.orientation.value == CameraOrientations.LANDSCAPE_RIGHT)) {
          widget.rotationController.forward();
        } else if ((widget.orientation.value ==
            CameraOrientations.PORTRAIT_DOWN)) {
          if (_oldOrientation == CameraOrientations.LANDSCAPE_RIGHT) {
            widget.rotationController.forward(from: 0.5);
          } else {
            widget.rotationController.reverse(from: 0.5);
          }
        }
      } else if (widget.orientation.value == CameraOrientations.PORTRAIT_DOWN) {
        widget.rotationController.reverse(from: 0.5);
      } else {
        widget.rotationController.forward();
      }
    });
  }

  late double newAngle;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.rotationController,
      builder: (context, child) {

        if (_oldOrientation == CameraOrientations.LANDSCAPE_LEFT) {
          if (widget.orientation.value == CameraOrientations.PORTRAIT_UP) {
            newAngle = -widget.rotationController.value;
          }
        }

        if (_oldOrientation == CameraOrientations.LANDSCAPE_RIGHT) {
          if (widget.orientation.value == CameraOrientations.PORTRAIT_UP) {
            newAngle = widget.rotationController.value;
          }
        }

        if (_oldOrientation == CameraOrientations.PORTRAIT_DOWN) {
          if (widget.orientation.value == CameraOrientations.PORTRAIT_UP) {
            newAngle = widget.rotationController.value * -pi;
          }
        }

        return IgnorePointer(
          ignoring: !widget.isEnabled,
          child: Opacity(
            opacity: widget.isEnabled ? 1.0 : 0.3,
            child: Transform.rotate(
              angle: newAngle,
              child: ClipOval(
                child: Material(
                  color: Color(0xFF4F6AFF),
                  child: InkWell(
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: Icon(
                        widget.icon,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ),
                    onTap: () {
                      if (widget.onTapCallback != null) {
                        // Trigger short vibration
                        HapticFeedback.selectionClick();

                        widget.onTapCallback();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

  late CameraOrientations orientation;
class OrientationUtils {
  static CameraOrientations convertRadianToOrientation(double radians) {
    if (radians == -pi / 2) {
      orientation = CameraOrientations.LANDSCAPE_LEFT;
    } else if (radians == pi / 2) {
      orientation = CameraOrientations.LANDSCAPE_RIGHT;
    } else if (radians == 0.0) {
      orientation = CameraOrientations.PORTRAIT_UP;
    } else if (radians == pi) {
      orientation = CameraOrientations.PORTRAIT_DOWN;
    }
    return orientation;
  }
  late double radians;
  double convertOrientationToRadian(CameraOrientations orientation) {
    switch (orientation) {
      case CameraOrientations.LANDSCAPE_LEFT:
        radians = -pi / 2;
        break;
      case CameraOrientations.LANDSCAPE_RIGHT:
        radians = pi / 2;
        break;
      case CameraOrientations.PORTRAIT_UP:
        radians = 0.0;
        break;
      case CameraOrientations.PORTRAIT_DOWN:
        radians = pi;
        break;
      default:
    }
    return radians;
  }

  bool isOnPortraitMode(CameraOrientations orientation) {
    return (orientation == CameraOrientations.PORTRAIT_DOWN ||
        orientation == CameraOrientations.PORTRAIT_UP);
  }
}

class CameraButton extends StatefulWidget {
  final CaptureModes captureMode;
  final bool isRecording;
  final Function onTap;

  CameraButton({
    Key? key,
    required this.captureMode,
    required this.isRecording,
    required this.onTap,
  }) : super(key: key);

  @override
  _CameraButtonState createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late double _scale;
  Duration _duration = Duration(milliseconds: 100);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animationController.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Container(
        key: ValueKey('cameraButton' +
            (widget.captureMode == CaptureModes.PHOTO ? 'Photo' : 'Video')),
        height: 80,
        width: 80,
        child: Transform.scale(
          scale: _scale,
          child: CustomPaint(
            painter: CameraButtonPainter(
              widget.captureMode,
              isRecording: widget.isRecording,
            ),
          ),
        ),
      ),
    );
  }

  _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  _onTapUp(TapUpDetails details) {
    Future.delayed(_duration, () {
      _animationController.reverse();
    });

    this.widget.onTap.call();
  }

  _onTapCancel() {
    _animationController.reverse();
  }
}

class CameraButtonPainter extends CustomPainter {
  final CaptureModes captureMode;
  final bool isRecording;

  CameraButtonPainter(
    this.captureMode, {
    this.isRecording = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var bgPainter = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    var radius = size.width / 2;
    var center = Offset(size.width / 2, size.height / 2);
    bgPainter.color = Colors.white.withOpacity(.5);
    canvas.drawCircle(center, radius, bgPainter);

    if (this.captureMode == CaptureModes.VIDEO && this.isRecording) {
      bgPainter.color = Colors.red;
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(
                17,
                17,
                size.width - (17 * 2),
                size.height - (17 * 2),
              ),
              Radius.circular(12.0)),
          bgPainter);
    } else {
      bgPainter.color =
          captureMode == CaptureModes.PHOTO ? Colors.white : Colors.red;
      canvas.drawCircle(center, radius - 8, bgPainter);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            if (!mounted) return;

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}



// Future<void> main() async {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TakeImage(),
//     );
//   }
// }
//
// class TakeImage extends StatefulWidget{
//   @override
//   _TakeImageState createState() => _TakeImageState();
// }
//
// class _TakeImageState extends State<TakeImage> {
//
//   List<CameraDescription>? cameras; //list out the camera available
//   CameraController? controller; //controller for camera
//   XFile? image; //for captured image
//
//   @override
//   void initState() {
//     loadCamera();
//     super.initState();
//   }
//
//   loadCamera() async {
//     cameras = await availableCameras();
//     if(cameras != null){
//       controller = CameraController(cameras![0], ResolutionPreset.max);
//       //cameras[0] = first camera, change to 1 to another camera
//
//       controller!.initialize().then((_) {
//         if (!mounted) {
//           return;
//         }
//         setState(() {});
//       });
//     }else{
//       print("NO any camera found");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return  Scaffold(
//       appBar: AppBar(
//         title: Text("Capture Image from Camera"),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: Container(
//           child: Column(
//               children:[
//                 Container(
//                     height:300,
//                     width:400,
//                     child: controller == null?
//                     Center(child:Text("Loading Camera...")):
//                     !controller!.value.isInitialized?
//                     Center(
//                       child: CircularProgressIndicator(),
//                     ):
//                     CameraPreview(controller!)
//                 ),
//                 ElevatedButton.icon( //image capture button
//                   onPressed: () async{
//                     try {
//                       if(controller != null){ //check if contrller is not null
//                         if(controller!.value.isInitialized){ //check if controller is initialized
//                           image = await controller!.takePicture(); //capture image
//                           setState(() {
//                             //update UI
//                           });
//                         }
//                       }
//                     } catch (e) {
//                       print(e); //show error
//                     }
//                   },
//                   icon: Icon(Icons.camera),
//                   label: Text("Capture"),
//                 ),
//
//                 Container( //show captured image
//                   padding: EdgeInsets.all(10),
//                   child: image == null?
//                   Text("No image captured"):
//                   Image.file(File(image!.path), height: 230,),
//                   //display captured image
//                 )
//               ]
//           )
//       ),
//     );
//   }
//}

class PosterAfterImageSelectionPage extends StatelessWidget {
  int creation_id;
  String categorytype;
  BuildContext contextmain;
  List imageList;
  int max_photo;
  int min_photo;
  String product_id;
  String product_price;
  String selectedSize;
  String product_name;
  String slovaktitle;

  PosterAfterImageSelectionPage(
      this.creation_id,
      this.categorytype,
      this.contextmain,
      this.imageList,
      this.max_photo,
      this.min_photo,
      this.product_id,
      this.product_price,
      this.selectedSize,
      this.product_name,
      this.slovaktitle);

  @override
  Widget build(BuildContext context) {
    return InnerPosterAfterImageSelectionPage(
        creation_id,
        categorytype,
        contextmain,
        imageList,
        max_photo,
        min_photo,
        product_id,
        product_price,
        selectedSize,
        product_name,
        slovaktitle);
  }
}

class InnerPosterAfterImageSelectionPage extends StatelessWidget {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();
  bool _cropping = false;

  //ExtendedImageCropLayerCornerPainter _cornerPainter;
  final GlobalKey _globalKey = GlobalKey();

  int creation_id;
  String categorytype;
  BuildContext contextmain;
  List imageList;
  int max_photo;
  int min_photo;
  String product_id;
  String product_price;
  String selectedSize;
  String product_name;
  String slovaktitle;
  int croxaxiscount = 2;

  InnerPosterAfterImageSelectionPage(
      this.creation_id,
      this.categorytype,
      this.contextmain,
      this.imageList,
      this.max_photo,
      this.min_photo,
      this.product_id,
      this.product_price,
      this.selectedSize,
      this.product_name,
      this.slovaktitle);

  List<Widget> getWidgetList(
      List imageList, NavigationProvider provider, BuildContext context) {
    // print("imageList.length - "+imageList.length.toString());
    List<Widget> list = [];
    for (int i = 0; i < imageList.length; i++) {
      Uint8List? iimage = null;
      if(categorytype=="creation"||categorytype=="cart"){
        List<int> list = utf8.encode(imageList[i]["uint8list"].toString());
        iimage = new Uint8List(0);
        // print(iimage);
      }else{
        // print('imageList[i]["uint8list"]');
        // print(imageList[i]["uint8list"]);
        // iimage = imageList[i]["uint8list"];
      }
      list.add(Container(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 6,
          shadowColor: Colors.black87,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image:
                Image.memory(base64Decode(imageList[i]["base64"])).image
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.6),
                ),
                child: Container(
                  height: 20,
                  width: 20,
                  child: InkWell(
                    onTap: () async {
                      bool isCropped = false;
                      if (imageList[i]["isCropped"] == "true") {
                        isCropped = true;
                        //provider.optiontoChooseIMage(i);
                      } else {
                        isCropped = false;
                        // provider.openImageFilterposter(i);
                      }
                      provider.width = provider.selected_width;
                      provider.height = provider.selected_height;
                      // print(imageList[i]["base64"]);
                      // return;
                      // print("imageList");
                      provider.openImageEdit(imageList[i]["base64"], isCropped, imageList[i]["image_type"], imageList[i]["url_image"], imageList[i]["fileuriPath"], imageList[i]["lowresofileuriPath"], "poster", false, i);
                      final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => PhotoEdit(contextmain)),);
                      if(result!=null){
                        provider.updatePosterImage(result);
                      }
                    },
                    child: Center(
                      // Edit poster
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ));
    }
    if (imageList.length < max_photo) {
      list.add(InkWell(
        onTap: () {
          gotoPhotoSelectionPage(contextmain, context, provider, 1, 1, true);
        },
        child: Container(
          margin: EdgeInsets.all(32 / croxaxiscount),
          child: DottedBorder(
            color: Colors.black,
            dashPattern: [6, 3],
            strokeWidth: 1,
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 80 / croxaxiscount,
              ),
            ),
          ),
        ),
      ));
      return list;
    } else {
      return list;
    }
  }
  int ppcount = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    double _width = double.parse(selectedSize.split("x")[0]);
    double _height = double.parse(selectedSize.split("x")[1].split("cm")[0]);

    if (ppcount ==0) {
      ppcount++;
      print("gtvbuo,");
      provider.imageList = imageList;
      provider.addposterOtherData(
          creation_id,
          categorytype,
          contextmain,
          imageList,
          max_photo,
          min_photo,
          product_id,
          product_price,
          selectedSize,
          product_name,
          slovaktitle);
    }

    List<Widget> widgetList =
        getWidgetList(provider.imageList, provider, context);

    switch (product_name) {
      case "Flush Mount":
        {
          croxaxiscount = 2;
        }
        break;
      case "Prints pack":
        {
          croxaxiscount = 3;
        }
        break;
      case "Standard Photo":
        {
          croxaxiscount = 2;
        }
        break;
      case "Art Print":
        {
          croxaxiscount = 3;
        }
        break;
    }
    Widget withoutAppBar(BuildContext context, provider) {
      return AppBar(
        backgroundColor: Colors.black.withOpacity(0.8),
        leading: provider.istextFormatting == 3
            ? Container()
            : IconButton(
                padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
                icon: Icon(Icons.clear, color: Colors.white70),
                onPressed: () async {
                  if (provider.istextFormatting == 2) {
                    /*await convertImageToCropImageeeeeee(provider);*/
                    provider.closedImageFilter();
                  } else if (provider.istextFormatting == 1) {
                    provider.closedtextformatting();
                  }
                },
              ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: provider.istextFormatting == 3
            ? Container()
            : InkWell(
                onTap: () async {
                  if (provider.istextFormatting == 1) {
                    provider.closedtextformatting();
                  } else {
                    if (provider.selectedimageFilterTabindex == 0) {
                      await convertImageToCropImage(provider);
                      provider.closedImageFilter();
                    } else if (provider.selectedimageFilterTabindex == 1) {
                      convertWidgetToImage(provider);
                      provider.closedImageFilter();
                    }
                  }
                },
                child: Container(
                  child: Text(
                    Languages.of(contextmain)!.Done,
                    // "",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
        actions: provider.istextFormatting == 2
            ? <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: SizedBox(
                        width: 80.0,
                        child: IconButton(
                          icon: Text(
                            Languages.of(contextmain)!.Remove,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          onPressed: () {
                            provider.removeIMage();
                          },
                        ))),
              ]
            : null,
      );
    }
print("provider.updateimagepathbase64");
print(provider.updateimagepathbase64);
    return Scaffold(
      appBar: PreferredSize(
    preferredSize: const Size.fromHeight(100),
    child: provider.istextFormatting != 0
          ? withoutAppBar(context, provider)
          : AppBar(
              backgroundColor: MyColors.primaryColor,
              // Back Button
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  if(categorytype != "cart") {
                    provider.addPostercreation(context);
                  }else{
                    Navigator.of(context).pop();
                  }
                },
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Text(
                langcode == "en" || langcode == "en_"
                    ? product_name
                    : slovaktitle,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            )),
      body: Stack(
        children: [
          Container(
            child:
            provider.updateimagepathbase64.contains('.png') ||
            provider.updateimagepathbase64.contains('.jpg') ?
            ExtendedImage.asset(
                        provider.updateimagepathbase64,
                        fit: BoxFit.contain,
                        cacheRawData: true,
                        clearMemoryCacheWhenDispose: true,
                        height: 300,
                        width: 300,
                        mode: ExtendedImageMode.editor,
                        enableLoadState: true,
                        extendedImageEditorKey: provider.cropKey,
                        loadStateChanged: (ExtendedImageState state) {
                          switch (state.extendedImageLoadState) {
                            case LoadState.loading:
                              {
                                //provider.checkImageState("loading");
                                break;
                              }
                            case LoadState.completed:
                              provider.checkImageState("complete");
                              // TODO: Handle this case.
                              break;
                            case LoadState.failed:
                              provider.checkImageState("failed");
                              //provider.checkImageState("failed");
                              // TODO: Handle this case.
                              break;
                          }
                        },
                        initEditorConfigHandler: (state) {
                          return EditorConfig(
                              maxScale: 8.0,
                              cropRectPadding: const EdgeInsets.all(0.0),
                              hitTestSize: 20.0,
                              //cornerPainter: _cornerPainter,
                              initCropRectType: InitCropRectType.layoutRect,
                              cropAspectRatio: provider.selected_width /
                                  provider.selected_height);
                        },
                      ) :
            ExtendedImage.memory(
                        base64Decode(provider.updateimagepathbase64),
                        fit: BoxFit.contain,
                        cacheRawData: true,
                        clearMemoryCacheWhenDispose: true,
                        height: 300,
                        width: 300,
                        mode: ExtendedImageMode.editor,
                        enableLoadState: true,
                        extendedImageEditorKey: provider.cropKey,
                        loadStateChanged: (ExtendedImageState state) {
                          switch (state.extendedImageLoadState) {
                            case LoadState.loading:
                              {
                                //provider.checkImageState("loading");
                                break;
                              }
                            case LoadState.completed:
                              provider.checkImageState("complete");
                              // TODO: Handle this case.
                              break;
                            case LoadState.failed:
                              provider.checkImageState("failed");
                              //provider.checkImageState("failed");
                              break;
                          }
                        },
                        initEditorConfigHandler: (state) {
                          return EditorConfig(
                              maxScale: 8.0,
                              cropRectPadding: const EdgeInsets.all(0.0),
                              hitTestSize: 20.0,
                              //cornerPainter: _cornerPainter,
                              initCropRectType: InitCropRectType.layoutRect,
                              cropAspectRatio: provider.selected_width /
                                  provider.selected_height);
                        },
                      )
            // !provider.imageupdate
              //   ? Container()
              //   : provider.type == "phone"
              //       ? ExtendedImage.file(
              //           new File(provider.updateimagepath),
              //           fit: BoxFit.contain,
              //           cacheRawData: true,
              //           clearMemoryCacheWhenDispose: true,
              //           height: 300,
              //           width: 300,
              //           mode: ExtendedImageMode.editor,
              //           enableLoadState: true,
              //           extendedImageEditorKey: provider.cropKey,
              //           loadStateChanged: (ExtendedImageState state) {
              //             switch (state.extendedImageLoadState) {
              //               case LoadState.loading:
              //                 {
              //                   //provider.checkImageState("loading");
              //                   break;
              //                 }
              //               case LoadState.completed:
              //                 provider.checkImageState("complete");
              //                 // TODO: Handle this case.
              //                 break;
              //               case LoadState.failed:
              //                 provider.checkImageState("failed");
              //                 //provider.checkImageState("failed");
              //                 // TODO: Handle this case.
              //                 break;
              //             }
              //           },
              //           initEditorConfigHandler: (ExtendedImageState state) {
              //             return EditorConfig(
              //                 maxScale: 8.0,
              //                 cropRectPadding: const EdgeInsets.all(0.0),
              //                 hitTestSize: 20.0,
              //                 //cornerPainter: _cornerPainter,
              //                 initCropRectType: InitCropRectType.layoutRect,
              //                 cropAspectRatio: provider.selected_width /
              //                     provider.selected_height);
              //           },
              //         )
              //       : ExtendedImage.network(
              //           provider.updateimagepath,
              //           //shape: provider.isLayoutCircle?BoxShape.circle:BoxShape.rectangle,
              //           fit: BoxFit.contain,
              //           cacheRawData: true,
              //           clearMemoryCacheWhenDispose: true,
              //           height: 300,
              //           width: 300,
              //           mode: ExtendedImageMode.editor,
              //           enableLoadState: true,
              //           extendedImageEditorKey: provider.cropKey,
              // loadStateChanged: (ExtendedImageState state) {
              //   switch (state.extendedImageLoadState) {
              //     case LoadState.loading:
              //       {
              //         //provider.checkImageState("loading");
              //         break;
              //       }
              //     case LoadState.completed:
              //       provider.checkImageState("complete");
              //       // TODO: Handle this case.
              //       break;
              //     case LoadState.failed:
              //       provider.checkImageState("failed");
              //     //provider.checkImageState("failed");
              //     // TODO: Handle this case.
              //       break;
              //   }
              // },
              //           initEditorConfigHandler: (ExtendedImageState state) {
              //             return EditorConfig(
              //                 maxScale: 8.0,
              //                 cropRectPadding: const EdgeInsets.all(0.0),
              //                 hitTestSize: 20.0,
              //                 //cornerPainter: _cornerPainter,
              //                 initCropRectType: InitCropRectType.layoutRect,
              //                 cropAspectRatio: provider.selected_width /
              //                     provider.selected_height);
              //           },
              //         ),
          ),
          provider.busy?Container(child: Center( child: CircularProgressIndicator())): Container(
            padding: EdgeInsets.only(top: 16, left: 12, right: 12),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child:
                  GridView.count(
                    padding: EdgeInsets.all(12),
                    primary: false,
                    childAspectRatio: _width / _height,
                    crossAxisCount: croxaxiscount,
                    crossAxisSpacing: 20 / croxaxiscount,
                    mainAxisSpacing: 30 / croxaxiscount,
                    children: widgetList,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
                  child: Container(
                    height: 45.0,
                    width: MediaQuery.of(context).size.width * 1.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: MyColors.primaryColor,
                      onPressed: () {
                        // print(categorytype);
                        if(categorytype=="cart"){
                          MemotiDbProvider.db.removecart(provider.cartIndex1);
                        }
                        if(creation_id!=-1){
                          MemotiDbProvider.db.removecreationItem(creation_id);
                        }
                        provider.addToCart(contextmain, context);
                      } /*Navigator.popUntil(context, ModalRoute.withName('/'))*/,
                      child: provider.boolerror
                          ? Text("error! Try again",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18))
                          : provider.addcart
                              ? CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text(
                                Languages.of(contextmain)!.AddtoCart,
                                // "",
                                  style: TextStyle(
                                      letterSpacing: 3,
                                      wordSpacing: 4,
                                      color: Colors.white,
                                      fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          case2(
            provider.istextFormatting,
            {
              0: Container(),
              2: imageFilterWidget(contextmain, provider, context),
              1: textFormatingWidget(contextmain, provider, context),
              3: chooseImage(contextmain, provider, context),
            },
            Container(),
          ),
        ],
      ),
    );
  }

  Widget chooseImage(BuildContext contextmain, provider, BuildContext context) {
    return Positioned(
        top: 0.0,
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            color: Colors.black.withOpacity(0.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      provider.setImageSelection("original");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ClipRect(
                              child: Align(
                                alignment: Alignment.center,
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: provider.selcted_image_type == "phone"
                                    ? Image.file(
                                        new File(provider.seletedImageuri),
                                        fit: BoxFit.cover,
                                      )
                                    : provider.selcted_image_type == "memoti"
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                provider.selcted_image_url,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Center(
                                                    child: SizedBox(
                                              child:
                                                  CircularProgressIndicator(),
                                              width: 50,
                                              height: 50,
                                            )),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          )
                                        : CachedNetworkImage(
                                            imageUrl:
                                                provider.selcted_image_url,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Center(
                                                    child: SizedBox(
                                              child:
                                                  CircularProgressIndicator(),
                                              width: 50,
                                              height: 50,
                                            )),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 20,
                              right: MediaQuery.of(context).size.width * .37,
                              child: Center(
                                child: Container(
                                    padding: EdgeInsets.all(8),
                                    color: Colors.grey.withOpacity(0.5),
                                    child: Text(
                                      "Original",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      provider.setImageSelection("crop");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ClipRect(
                              child: Align(
                                alignment: Alignment.center,
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: provider.selectedlowIMageuri != null
                                    ? Image.file(
                                    new File(provider.selectedlowIMageuri))
                                    : Container(),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 20,
                              right: MediaQuery.of(context).size.width * .37,
                              child: Center(
                                child: Container(
                                    padding: EdgeInsets.all(8),
                                    color: Colors.grey.withOpacity(0.5),
                                    child: Text(
                                      "Crop one",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget textFormatingWidget(
      BuildContext contextmain, provider, BuildContext context) {
    return Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
        color: Colors.black.withOpacity(0.8),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* IconButton(
                  padding: EdgeInsets.all(16),
                  icon: Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    provider.closedtextformatting();
                  },
                ),*/
                testingTopWidget(contextmain, provider, context),
                SizedBox(
                  height: 16,
                ),
                provider.selectedtextFormatTabindex == 0
                    ? Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: Text(
                                      Languages.of(contextmain)!.ChooseFont,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: MyColors.textColor),
                                    ),
                                    items: provider.fontsizeList,
                                    isDense: true,
                                    value: provider.selectedFontSizeindex,
                                    onChanged: (value) =>
                                        provider.changeFontSize(value),
                                    isExpanded: true,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: Text(
                                      Languages.of(contextmain)!.ChooseFont,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: MyColors.textColor),
                                    ),
                                    items: provider.editTextPostionList,
                                    isDense: true,
                                    value: provider.selectededitTextPosition,
                                    onChanged: (value) =>
                                        provider.changeEditTextPostion(value),
                                    isExpanded: true,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 16,
                ),
                case2(
                  provider.selectedtextFormatTabindex,
                  {
                    0: secondWidget(provider, context),
                    1: secondColorWidget(provider, context, "text"),
                    2: secondColorWidget(provider, context, "bg"),
                  },
                  secondWidget(provider, context),
                ),
                SizedBox(
                  height: 16,
                ),
                thirdWidget(provider, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget testingTopWidget(
      BuildContext contextmain, provider, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () => provider.changeTextFormatSelectedTabColor(0),
                child: Container(
                  child: Column(
                    children: [
                      Image.asset(case2(
                          provider.selectedtextFormatTabindex,
                          {
                            0: "assets/icon/IconFont_Select.png",
                          },
                          "assets/icon/IconFont_Unselect.png"),fit: BoxFit.contain,height: 30,width: 30,),

                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          Languages.of(contextmain)!.Font,
                          style: TextStyle(
                              color: case2(
                                  provider.selectedtextFormatTabindex,
                                  {
                                    0: MyColors.primaryColor,
                                  },
                                  Colors.grey[300]),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () => provider.changeTextFormatSelectedTabColor(1),
                child: Container(
                  child: Column(
                    children: [
                      Image.asset(case2(
                          provider.selectedtextFormatTabindex,
                          {
                            1: "assets/icon/FontColor_Select.png",
                          },
                          "assets/icon/FontColor_Unselect.png"),fit: BoxFit.contain,height: 30,width: 30,),

                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          Languages.of(contextmain)!.FontColor,
                          style: TextStyle(
                              color: case2(
                                  provider.selectedtextFormatTabindex,
                                  {
                                    1: MyColors.primaryColor,
                                  },
                                  Colors.grey[300]),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () => provider.changeTextFormatSelectedTabColor(2),

                child: Container(
                  child: Column(
                    children: [
                      Image.asset(case2(
                          provider.selectedtextFormatTabindex,
                          {
                            2: "assets/icon/BGColor_Select.png",
                          },
                          "assets/icon/BGColor_Unselect.png"),fit: BoxFit.contain,height: 30,width: 30,),
                      /*Icon(
                        Icons.format_color_text,
                        color: case2(
                            provider.selectedtextFormatTabindex,
                            {
                              2: MyColors.primaryColor,
                            },
                            Colors.grey[300]),
                        size: 30,
                      ),*/
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          Languages.of(contextmain)!.BgColor,
                          style: TextStyle(
                              color: case2(
                                  provider.selectedtextFormatTabindex,
                                  {
                                    2: MyColors.primaryColor,
                                  },
                                  Colors.grey[300]),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget secondWidget(NavigationProvider provider, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Text(
            Languages.of(contextmain)!.ChooseFont,
            style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: MyColors.textColor),
          ),
          items: provider.fontList,
          isDense: true,
          value: provider.selectedFontindex,
          onChanged: (value) {
            print(value);
            // provider.changeFont(value)
          },
          isExpanded: true,
        ),
      ),
    );
  }

  Widget secondColorWidget(provider, BuildContext context, String what) {
    return Container(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: provider.colorList.length,
          itemBuilder: (BuildContext ctx, int index) {
            return case2(what, {
              "text": TextColorItem(
                  provider, index, ctx, provider.colorList[index]),
              "bg":
                  BGColorItem(provider, index, ctx, provider.colorList[index]),
            });
          }),
    );
  }

  Widget thirdWidget(NavigationProvider provider, BuildContext context) {
    return Container(
        child: Column(
      children: [
        DottedBorder(
          color: Colors.grey,
          dashPattern: [6, 3],
          strokeWidth: 2,
          radius: Radius.circular(8),
          child: Container(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            height: 200,
            decoration: BoxDecoration(
              color: provider.currentBGColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              controller: provider.textEditingController,
              style: TextStyle(
                  fontSize: provider.selectedFontSizeindex.toDouble(),
                  color: provider.currenttextColor,
                  fontFamily: provider.selectedFontKey),
              decoration: InputDecoration(
                hintText: Languages.of(contextmain)!.Enteryourmessage,
              ),
              scrollPadding: EdgeInsets.all(20.0),
              keyboardType: TextInputType.multiline,
              maxLines: 99999,
              autofocus: true,
            ),
          ),
        ),
      ],
    ));
  }

  Widget fourthWidegt(
      BuildContext contextmain, provider, BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 36.0, 0.0, 0.0),
      child: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width * 1.0,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          color: MyColors.primaryColor,
          onPressed: () => provider.closedtextformatting(),
          child: Text(
            Languages.of(contextmain)!.Done,
            // "",
              style: TextStyle(
                  letterSpacing: 2,
                  wordSpacing: 2,
                  color: Colors.white,
                  fontSize: 18)),
        ),
      ),
    );
  }

  Widget imageFilterWidget(
      BuildContext contextmain, provider, BuildContext context) {
    return Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        color: Colors.black.withOpacity(0.8),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*Row(
                  children: [

                    IconButton(
                      padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
                      icon: Icon(Icons.clear, color: Colors.white70),
                      onPressed: () {
                        provider.closedImageFilter();
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 0, 20, 0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: (){
                              provider.removeIMage();
                            },
                            child: Text(
                              Languages.of(contextmain)!.Remove,
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),*/
                imageFilterFirstWidget(provider, context),
                imageSecondWidget(contextmain, provider, context),
                SizedBox(
                  height: 16,
                ),
                case2(
                  provider.selectedimageFilterTabindex,
                  {
                    0: imagerotateThirdWidget(
                        contextmain, provider, context, editorKey),
                    1: case2(
                        provider.selcted_image_type,
                        {
                          "memoti": imageFilterThirdWidgetUrl(
                              contextmain, provider, context),
                          "google": imageFilterThirdWidgetUrl(
                              contextmain, provider, context),
                        },
                        imageFilterThirdWidget(contextmain, provider, context)),
                    2: Container(), //imageFilterThirdWidget(provider, context),
                  },
                  imagerotateThirdWidget(
                      contextmain, provider, context, editorKey),
                ),
                /* SizedBox(
                  height: 11,
                ),
                case2(
                  provider.selectedimageFilterTabindex,
                  {
                    0: ImagecropfourthWidegt(provider, context),
                    1: ImageFilterfourthWidegt(provider, context),
                    2: Container(), //imageFilterThirdWidget(provider, context),
                  },
                  //ImageFilterfourthWidegt(provider, context),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TValue
  case2<TOptionType, TValue>(
    TOptionType selectedOption,
    Map<TOptionType, TValue> branches, [
    TValue? defaultValue,
  ]) {
    if (!branches.containsKey(selectedOption)) {
      return defaultValue;
    }

    return branches[selectedOption];
  }

  Widget imageFilterFirstWidget(provider, BuildContext context) {
    return Stack(
      children: [
        Container(
          /*  decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white70.withOpacity(0.9),
          ),*/
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: case2(
              provider.selectedimageFilterTabindex,
              {
                0: provider.selcted_image_type != null
                    ? Center(
                        child: provider.whichImageShow == "original"
                            ? case2(
                                provider.selcted_image_type,
                                {
                                  "memoti": ExtendedImage.network(
                                    provider.selcted_image_url,
                                    shape: BoxShape.rectangle,
                                    fit: BoxFit.contain,
                                    height: 300,
                                    width: 300,
                                    cacheRawData: true,
                                    clearMemoryCacheWhenDispose: true,
                                    mode: ExtendedImageMode.editor,
                                    enableLoadState: true,
                                    extendedImageEditorKey: editorKey,
                                    initEditorConfigHandler:
                                        (state) {
                                      return EditorConfig(
                                          maxScale: 8.0,
                                          cropRectPadding:
                                              const EdgeInsets.all(0.0),
                                          hitTestSize: 20.0,
                                          //cornerPainter: _cornerPainter,
                                          initCropRectType:
                                              InitCropRectType.layoutRect,
                                          cropAspectRatio:
                                              provider.selected_width /
                                                  provider.selected_height);
                                    },
                                  ),
                                  "google": ExtendedImage.network(
                                    provider.selcted_image_url +"=w400-h400-c",
                                    shape: BoxShape.rectangle,
                                    fit: BoxFit.contain,
                                    cacheRawData: true,
                                    clearMemoryCacheWhenDispose: true,
                                    height: 300,
                                    width: 300,
                                    mode: ExtendedImageMode.editor,
                                    enableLoadState: true,
                                    extendedImageEditorKey: editorKey,
                                    initEditorConfigHandler:
                                        (state) {
                                      return EditorConfig(
                                          maxScale: 8.0,
                                          cropRectPadding:
                                              const EdgeInsets.all(0.0),
                                          hitTestSize: 20.0,
                                          //cornerPainter: _cornerPainter,
                                          initCropRectType:
                                              InitCropRectType.layoutRect,
                                          cropAspectRatio:
                                              provider.selected_width /
                                                  provider.selected_height);
                                    },
                                  )
                                },
                                ExtendedImage.file(
                                  new File(provider.seletedImageuri),
                                  //shape: provider.isLayoutCircle?BoxShape.circle:BoxShape.rectangle,
                                  fit: BoxFit.contain,
                                  cacheRawData: true,
                                  clearMemoryCacheWhenDispose: true,
                                  height: 300,
                                  width: 300,
                                  mode: ExtendedImageMode.editor,
                                  enableLoadState: true,
                                  extendedImageEditorKey: editorKey,
                                  initEditorConfigHandler:
                                      (state) {
                                    return EditorConfig(
                                        maxScale: 8.0,
                                        cropRectPadding:
                                            const EdgeInsets.all(0.0),
                                        hitTestSize: 20.0,
                                        //cornerPainter: _cornerPainter,
                                        initCropRectType:
                                            InitCropRectType.layoutRect,
                                        cropAspectRatio:
                                            provider.selected_width /
                                                provider.selected_height);
                                  },
                                ))
                            : ExtendedImage.file(
                                new File(provider.selectedlowIMageuri),
                                //shape: provider.isLayoutCircle?BoxShape.circle:BoxShape.rectangle,
                                fit: BoxFit.contain,
                                cacheRawData: true,
                                clearMemoryCacheWhenDispose: true,
                                height: 300,
                                width: 300,
                                mode: ExtendedImageMode.editor,
                                enableLoadState: true,
                                extendedImageEditorKey: editorKey,
                                initEditorConfigHandler:
                                    (state) {
                                  return EditorConfig(
                                      maxScale: 8.0,
                                      cropRectPadding:
                                          const EdgeInsets.all(0.0),
                                      hitTestSize: 20.0,
                                      //cornerPainter: _cornerPainter,
                                      initCropRectType:
                                          InitCropRectType.layoutRect,
                                      cropAspectRatio: provider.selected_width /
                                          provider.selected_height);
                                },
                              ),
                      )
                    : Container(),
                1: Center(
                  child: Container(
                    child: RepaintBoundary(
                      key: _globalKey,
                      child: Container(
                        height: 300,
                        width: 300,
                        /*decoration: BoxDecoration(
                          shape: provider.isLayoutCircle?BoxShape.circle:BoxShape.rectangle,
                    ),*/
                        /*height: 250,*/
                        child: ColorFiltered(
                          colorFilter:
                              ColorFilter.matrix(provider.selected_filter),
                          child: provider.seletedImageuri == null
                              ? Image.asset(
                                  "assets/images/economy_photobook.jpg",
                                  fit: BoxFit.contain,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      shape: /*provider.isLayoutCircle?BoxShape.circle:*/ BoxShape
                                          .rectangle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: provider.whichImageShow ==
                                                "original"
                                            ? case2(
                                                provider.selcted_image_type,
                                                {
                                                  "memoti":
                                                      CachedNetworkImageProvider(
                                                    provider.selcted_image_url,
                                                  ),
                                                  "google":
                                                      CachedNetworkImageProvider(
                                                    provider.selcted_image_url +"=w400-h400-c",
                                                  ),
                                                },
                                                FileImage(
                                                  new File(
                                                      provider.seletedImageuri),
                                                ),
                                              )
                                            : FileImage(
                                                new File(provider
                                                    .selectedlowIMageuri),
                                              ),
                                      )),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                2: Container(),
              },
              Container()),
        ),
        Positioned(
          top: null,
          right: null,
          left: 32.0,
          bottom: 32.0,
          child: IconButton(
            padding: EdgeInsets.all(16),
            icon: Icon(
              Icons.warning,
              color: HexColor(provider.imageQulaityColor),
              size: 20,
            ),
            onPressed: () {
              provider.showWarningofImageQuality(contextmain, context);
            },
          ),
        ),
      ],
    );
  }

  Widget imageSecondWidget(contextmain, provider, BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: EdgeInsets.only(top: 12, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () => provider.changeImageFilterSelectedTabColor(0),
                child: Container(
                  child: Column(
                    children: [
                      Icon(
                        Icons.zoom_in,
                        color: case2(
                            provider.selectedimageFilterTabindex,
                            {
                              0: MyColors.primaryColor,
                            },
                            Colors.grey[300]),
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          Languages.of(contextmain)!.Zoom,
                          style: TextStyle(
                              color: case2(
                                  provider.selectedimageFilterTabindex,
                                  {
                                    0: MyColors.primaryColor,
                                  },
                                  Colors.grey[300]),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () => provider.changeImageFilterSelectedTabColor(1),
                child: Container(
                  child: Column(
                    children: [
                      Icon(
                        Icons.brush,
                        color: case2(
                            provider.selectedimageFilterTabindex,
                            {
                              1: MyColors.primaryColor,
                            },
                            Colors.grey[300]),
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          Languages.of(contextmain)!.Filters,
                          style: TextStyle(
                              color: case2(
                                  provider.selectedimageFilterTabindex,
                                  {
                                    1: MyColors.primaryColor,
                                  },
                                  Colors.grey[300]),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  gotoPhotoSelectionPage(
                      contextmain, context, provider, 1, 1, false);
                },
                child: Container(
                  child: Column(
                    children: [
                      Icon(
                        Icons.loop,
                        color: case2(
                            provider.selectedimageFilterTabindex,
                            {
                              2: MyColors.primaryColor,
                            },
                            Colors.grey[300]),
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          Languages.of(contextmain)!.Replace,
                          style: TextStyle(
                              color: case2(
                                  provider.selectedimageFilterTabindex,
                                  {
                                    2: MyColors.primaryColor,
                                  },
                                  Colors.grey[300]),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  if (provider.whichImageShow == "original") {
                    convertImagewhengointToText(provider);
                  }
                  provider.changeImageFilterSelectedTabColor(3);
                },
                child: Container(
                  child: Column(
                    children: [
                      Icon(
                        Icons.text_format,
                        color: case2(
                            provider.selectedimageFilterTabindex,
                            {
                              3: MyColors.primaryColor,
                            },
                            Colors.grey[300]),
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          Languages.of(contextmain)!.Text,
                          style: TextStyle(
                              color: case2(
                                  provider.selectedimageFilterTabindex,
                                  {
                                    3: MyColors.primaryColor,
                                  },
                                  Colors.grey[300]),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imagerotateThirdWidget(BuildContext contextmain, provider,
      BuildContext context, GlobalKey<ExtendedImageEditorState> editorKey) {
    return Container(
      margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: IconButton(
                icon: Icon(
                  Icons.rotate_left_outlined,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  editorKey.currentState!.rotate(right: false);
                },
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: IconButton(
                icon: Icon(
                  Icons.flip_camera_android_outlined,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  editorKey.currentState!.flip();
                },
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: IconButton(
                icon: Icon(
                  Icons.rotate_right_outlined,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  editorKey.currentState!.flip();
                  editorKey.currentState!.rotate(right: true);
                },
              ),
            ),
          ),
          /*Expanded(
            child: Center(
              child: Container(
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  color: MyColors.primaryColor,
                  onPressed: () => editorKey.currentState.rotate(right: false),
                  child: Text(Languages.of(contextmain)!.RotateLeft,
                      style: TextStyle(
                          letterSpacing: 0.5,
                          wordSpacing: 1,
                          color: Colors.white,
                          fontSize: 13)),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  color: MyColors.primaryColor,
                  onPressed: () => editorKey.currentState.flip(),
                  child: Text(Languages.of(contextmain)!.Flip,
                      style: TextStyle(
                          letterSpacing: 0.5,
                          wordSpacing: 1,
                          color: Colors.white,
                          fontSize: 13)),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  color: MyColors.primaryColor,
                  onPressed: () => editorKey.currentState.rotate(right: true),
                  child: Text(Languages.of(contextmain)!.RotateRight,
                      style: TextStyle(
                          letterSpacing: 0.5,
                          wordSpacing: 1,
                          color: Colors.white,
                          fontSize: 13)),
                ),
              ),
            ),
          )*/
        ],
      ),
    );
  }

  Future<void> convertImageToCropImage(provider) async {
    final ExtendedImageEditorState? state = editorKey.currentState;
    final Rect? rect = state!.getCropRect();
    final EditActionDetails? action = state.editAction;
    final rotateAngle = action!.rotateAngle.toInt();
    final flipHorizontal = action.flipY;
    final flipVertical = action.flipX;
    final img = state.rawImageData;
    // print("rawImageData " + img.toString());
    ImageEditorOption option = ImageEditorOption();

    if (action.needCrop) option.addOption(ClipOption.fromRect(rect!));

    if (action.needFlip)
      option.addOption(
          FlipOption(horizontal: flipHorizontal, vertical: flipVertical));

    if (action.hasRotateAngle) option.addOption(RotateOption(rotateAngle));
    final result = await ImageEditor.editImage(
      image: img,
      imageEditorOption: option,
    );
    final DateTime start = DateTime.now();
    // print("result.length -" + result.toString());

    final Duration diff = DateTime.now().difference(start);
    // print('image_editor time : $diff');

    provider.updateImage(result);
    // print("heheh" + result.toString());
  }

  convertImagewhengointToText(provider) async {
    final ExtendedImageEditorState? state = editorKey.currentState;
    final Rect? rect = state!.getCropRect();
    final EditActionDetails? action = state.editAction;
    final rotateAngle = action!.rotateAngle.toInt();
    final flipHorizontal = action.flipY;
    final flipVertical = action.flipX;
    final img = state.rawImageData;
    // print("rawImageData " + img.toString());
    ImageEditorOption option = ImageEditorOption();

    if (action.needCrop) option.addOption(ClipOption.fromRect(rect!));

    if (action.needFlip)
      option.addOption(
          FlipOption(horizontal: flipHorizontal, vertical: flipVertical));

    if (action.hasRotateAngle) option.addOption(RotateOption(rotateAngle));
    final result = await ImageEditor.editImage(
      image: img,
      imageEditorOption: option,
    );
    final DateTime start = DateTime.now();
    // print("result.length -" + result.toString());

    final Duration diff = DateTime.now().difference(start);
    // print('image_editor time : $diff');

    provider.isoriginaltextEditIMage = true;
    provider.originaltextEditIMage = result;
    // print("heheh" + result.toString());
  }

  void flip() {
    editorKey.currentState!.flip();
  }

  void rotate(bool right) {
    editorKey.currentState!.rotate(right: right);
  }

  void convertWidgetToImage(provider) async {
    RenderRepaintBoundary? repaintBoundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
    ui.Image boxImage = await repaintBoundary!.toImage(pixelRatio: 1);
    ByteData? byteData =
        await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8list = byteData!.buffer.asUint8List();
    provider.updateImage(uint8list);
    // print("heheh" + uint8list.toString());
  }

  Widget ImageFilterfourthWidegt(provider, BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width * 1.0,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          color: MyColors.primaryColor,
          onPressed: () {
            convertWidgetToImage(provider);
            provider.closedImageFilter();
          },
          child: Text(
            // "",
            Languages.of(contextmain)!.Done,
              style: TextStyle(
                  letterSpacing: 2,
                  wordSpacing: 2,
                  color: Colors.white,
                  fontSize: 18)),
        ),
      ),
    );
  }

  Widget ImagecropfourthWidegt(provider, BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width * 1.0,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          color: MyColors.primaryColor,
          onPressed: () async {
            await convertImageToCropImage(provider);
            provider.closedImageFilter();
          },
          child: Text(
            Languages.of(contextmain)!.Done,
            // "",
              style: TextStyle(
                  letterSpacing: 2,
                  wordSpacing: 2,
                  color: Colors.white,
                  fontSize: 18)),
        ),
      ),
    );
  }

  Widget imageFilterThirdWidget(
      BuildContext contextmain, provider, BuildContext context) {
    List<ImageFilterModel> list = provider.filterList;
    List<ImageFilterModelUrl> listUrl = provider.filterListUrl;
    // print(list[0].filter);
    // print(listUrl[0].imageUrl);
    // print(list[0].name);
    // print(list[0].isSelected);
    return Container(
      height: 100,
      child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext ctx, int index) {
            return FilterItemList(
                provider,
                index,
                context,
                list[index],
                'phone',
                list[index].name,
                list[index].isSelected,
                list[index].filter);
            // return Container();
          }),
    );
  }

  Widget imageFilterThirdWidgetUrl(
      BuildContext contextmain, provider, BuildContext context) {
    List<ImageFilterModelUrl> listUrl = provider.filterListUrl;
    return listUrl.isNotEmpty
        ? Container(
            height: 100,
            child: ListView.builder(
                itemCount: listUrl.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext ctx, int index) {
                  return FilterItemListUrl(
                      provider,
                      index,
                      context,
                      listUrl[0],
                      listUrl[index].imageUrl,
                      "memoti",
                      listUrl[index].name,
                      listUrl[index].isSelected,
                      listUrl[index].filter);
                  // return Container();
                }))
        : Container();
  }

  void gotoPhotoSelectionPage(BuildContext contextmain, BuildContext context,
      provider, int minPhoto, int maxPhoto, bool layout) async {
    List imageList;
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NewPhotoSelction(contextmain, minPhoto,
              maxPhoto, "", "", "", "", "", "postercustomization")),
    );

    if (result != null) {
      imageList = result;
      if (layout) {
        provider.addImagetolist(imageList);
      } else {
        provider.replaceImage(imageList[0]);
      }
    }
  }
}

class FilterItemList extends StatelessWidget {
  final provider;
  int index;
  BuildContext context;
  String imageType;
  String name;
  bool select;
  ImageFilterModel model;
  List<double> filter;

  FilterItemList(this.provider, this.index, this.context, this.model,
      this.imageType, this.name, this.select, this.filter);

  @override
  Widget build(BuildContext context) {
    bool isSelected = select;
    return Stack(children: [
      GestureDetector(
        onTap: () => provider.changeFilter(index),
        child: Container(
          margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Column(
            children: [
              Container(
                height: 80,
                width: 100,
                padding: EdgeInsets.fromLTRB(2, 2, 2, 4),
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1,
                        color: isSelected ? Colors.white : Colors.grey,
                      ),
                    ),
                    child: ColorFiltered(
                      child: Image.file(
                        new File(model.assetImage),
                        width: 80,
                        fit: BoxFit.fill,
                      ),
                      colorFilter: ColorFilter.matrix(filter),
                    ),
                  ),
                ),
              ),
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 14),
              )
            ],
          ),
        ),
      ),
      Positioned(
        top: 0.0,
        right: 0.0,
        child: isSelected
            ? Container(
                height: 20,
                width: 20,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColors.primaryColor,
                    border: Border.all(
                      width: 1,
                      color: Colors.white,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      )
    ]);
  }
}

class FilterItemListUrl extends StatelessWidget {
  final provider;
  late int index;
  late BuildContext context;
  late String imageUrl;
  late String imageType;
  late String name;
  late bool select;
  late ImageFilterModel model;
  late ImageFilterModelUrl modelUrl;
  late List<double> filter;

  FilterItemListUrl(this.provider, this.index, this.context, this.modelUrl,
      this.imageUrl, this.imageType, this.name, this.select, this.filter);

  @override
  Widget build(BuildContext context) {
    bool isSelected = select;
    return Stack(children: [
      GestureDetector(
        onTap: () => provider.changeFilterUrl(index),
        child: Container(
          margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Column(
            children: [
              Container(
                height: 80,
                width: 100,
                padding: EdgeInsets.fromLTRB(2, 2, 2, 4),
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1,
                        color: isSelected ? Colors.white : Colors.grey,
                      ),
                    ),
                    child: ColorFiltered(
                      child: imageType == "memoti"
                          ? CachedNetworkImage(
                              imageUrl: imageUrl,
                              width: 80,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Center(
                                  child: SizedBox(
                                child: CircularProgressIndicator(),
                                width: 50,
                                height: 50,
                              )),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )
                          : CachedNetworkImage(
                              imageUrl: imageUrl+"=w400-h400-c",
                              width: 80,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Center(
                                  child: SizedBox(
                                child: CircularProgressIndicator(),
                                width: 50,
                                height: 50,
                              )),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                      colorFilter: ColorFilter.matrix(filter),
                    ),
                  ),
                ),
              ),
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 14),
              )
            ],
          ),
        ),
      ),
      Positioned(
        top: 0.0,
        right: 0.0,
        child: isSelected
            ? Container(
                height: 20,
                width: 20,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColors.primaryColor,
                    border: Border.all(
                      width: 1,
                      color: Colors.white,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      )
    ]);
  }
}
