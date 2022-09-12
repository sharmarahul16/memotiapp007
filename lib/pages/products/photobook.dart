import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_editor/image_editor.dart';
import 'package:memotiapp/pages/products/poster.dart';
import 'package:provider/provider.dart';
import 'package:memotiapp/provider/appaccess.dart';
import 'package:memotiapp/provider/statics.dart';
import 'package:memotiapp/pages/products/newphotoselection.dart';

import 'package:memotiapp/localization/language/languages.dart';
import 'package:memotiapp/localization/locale_constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'dart:ui' as ui;
import 'package:memotiapp/provider/database.dart';

import '../creations.dart';
import '../photo_edit.dart';

class PhotobookPage extends StatefulWidget {
  PhotobookPage({Key? key}) : super(key: key);

  @override
  _PhotobookPageState createState() => _PhotobookPageState();
}

class _PhotobookPageState extends State<PhotobookPage> {
  List<String> images = [];
  CarouselController buttonCarouselController = CarouselController();
  int _current = 0;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    if (count == 0) {
      print("provider.passtoProvider");
      provider.passtoProvider1(provider.selectedproduct, "photobook");
      for (int i = 0;
          i < provider.selectedproduct[0]["detail"]["photo"].length;
          i++) {
        images.add(
            /*Image.network()*/ "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
                provider.selectedproduct[0]["detail"]["photo"][i]);
      }
      count++;
    }

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(// Hide the AppBar\
              ),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(children: [
                  Stack(
                    children: <Widget>[
                      Container(
                          child: SizedBox(
                              height: 250.0,
                              width: MediaQuery.of(context).size.width * 1.0,
                              child: Stack(children: [
                                CarouselSlider(
                                  carouselController: buttonCarouselController,
                                  options: CarouselOptions(
                                    height: 250,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: images.length > 1 ? true : false,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index;
                                      });
                                    },
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  items: images
                                      .map((item) => Container(
                                            child: Center(
                                                child:
                                                    // Image.network(item, fit: BoxFit.cover, width: 1000)
                                                    CachedNetworkImage(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              fit: BoxFit.fitWidth,
                                              imageUrl: item,
                                              placeholder: (context, url) =>
                                                  Center(
                                                      child: SizedBox(
                                                child:
                                                    CircularProgressIndicator(),
                                                height: 150.0,
                                                width: 150.0,
                                              )),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            )),
                                            color: Colors.white,
                                          ))
                                      .toList(),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 16, right: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () => buttonCarouselController
                                              .previousPage(
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.linear),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Colors.black.withOpacity(0.5),
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
                                          onTap: () =>
                                              buttonCarouselController.nextPage(
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.linear),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Colors.black.withOpacity(0.5),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: images.map((image) {
                                        int index = images.indexOf(image);
                                        return Container(
                                          width: 8.0,
                                          height: 8.0,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 2.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _current == index
                                                  ? Color.fromRGBO(0, 0, 0, 0.9)
                                                  : Color.fromRGBO(
                                                      0, 0, 0, 0.4)),
                                        );
                                      }).toList(),
                                    ))
                              ]))),
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
                              ? provider.selectedproduct[0]["detail"]["title"]
                              : provider.selectedproduct[0]["detail"]
                                  ["slovaktitle"],
                          style: TextStyle(
                              color: MyColors.textColor,
                              fontWeight: FontWeight.bold,
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
                              ? provider.selectedproduct[0]["detail"]
                                  ["description"]
                              : provider.selectedproduct[0]["detail"]
                                  ["slovakdescription"],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: MyColors.textColor, fontSize: 14),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1.0, color: Colors.black),
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            16.0, 16.0, 0.0, 16.0),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/icon/Icon_Pages.png",
                                              height: 30.0,
                                              width: 30.0,
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                              width: 8.0,
                                            ),
                                            Text(
                                              provider.minPage == null
                                                  ? ""
                                                  : provider.minPage +
                                                              " to " +
                                                              provider
                                                                  .maxPage ==
                                                          null
                                                      ? ""
                                                      : provider.maxPage +
                                                          "\n" +
                                                          Languages.of(context)!
                                                              .pages,
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: MyColors.textColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
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
                                                width: 1.0,
                                                color: Colors.black),
                                          ),
                                        ),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "assets/icon/Icon_Premimum.png",
                                                height: 30.0,
                                                width: 30.0,
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                                width: 8.0,
                                              ),
                                              Text(
                                                Languages.of(context)!
                                                    .Premiumpaper,
                                                maxLines: 2,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: MyColors.textColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                child: Container(
                                  height: 1.0,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            16.0, 16.0, 0.0, 16.0),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/icon/Icon_Format.png",
                                              height: 30.0,
                                              width: 30.0,
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                              width: 8.0,
                                            ),
                                            Text(
                                              Languages.of(context)!.Format +
                                                  "\n15 * 15",
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: MyColors.textColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
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
                                                width: 1.0,
                                                color: Colors.black),
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
                                              Languages.of(context)!
                                                  .AUniqueGift,
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: MyColors.textColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
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
                                  fontWeight: FontWeight.bold,
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
                                    Text(
                                      String.fromCharCodes(
                                          new Runes("\u27A4  ")),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          Languages.of(context)!
                                                  .Dimensions1515cm3030cmA4A5PortraitA4A5Landscape +
                                              provider.sizes.join(", "),
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      String.fromCharCodes(
                                          new Runes("\u27A4  ")),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          Languages.of(context)!
                                                  .Bindingcoilspin +
                                              provider.bindings.join(", "),
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      String.fromCharCodes(
                                          new Runes("\u27A4  ")),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          Languages.of(context)!.Pagecounts +
                                              provider.minPage +
                                              "-" +
                                              provider.maxPage,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      String.fromCharCodes(
                                          new Runes("\u27A4  ")),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          Languages.of(context)!.Coilbinding +
                                              ": 20-96 stran",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      String.fromCharCodes(
                                          new Runes("\u27A4  ")),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          Languages.of(context)!
                                              .Spinbinding2036stran,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 16.0),
                          child: Container(
                              height: 45.0,
                              width: MediaQuery.of(context).size.width * 1.0,
                              child: ElevatedButton(
                                child: Text(Languages.of(context)!.CreateNow),
                                style: ElevatedButton.styleFrom(
                                  primary: MyColors.primaryColor,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0),
                                  ),
                                  side:
                                      BorderSide(color: MyColors.primaryColor),
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  String id = provider.selectedproduct[0]
                                          ["detail"]["ii"]
                                      .toString();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PhotoBookSizeSelectionPage()),
                                  );
                                },
                              )),
                        ),
                      ],
                    ),
                  )
                ]))));
  }
}

class PhotoBookSizeSelectionPage extends StatefulWidget {
  PhotoBookSizeSelectionPage({Key? key}) : super(key: key);

  @override
  _PhotoBookSizeSelectionPageState createState() =>
      _PhotoBookSizeSelectionPageState();
}

class _PhotoBookSizeSelectionPageState
    extends State<PhotoBookSizeSelectionPage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    if (count == 0) {
      provider.passtoProvider(provider.selectedproduct, "photobook");
      count++;
    }

    @override
    void dispose() {
      PaintingBinding.instance!.imageCache!.clear();
      PaintingBinding.instance!.imageCache!.clearLiveImages();
      // TODO: implement dispose
      super.dispose();
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
            Languages.of(context)!.ChooseOptions,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600),
          ),
          // actions: <Widget>[
          //   Padding(
          //       padding: EdgeInsets.fromLTRB(0.0, 16.0, 20.0, 0.0),
          //       child: GestureDetector(
          //           child: Text(
          //             Languages.of(context)!.Next,
          //             style: TextStyle(color: Colors.white, fontSize: 20),
          //           ),
          //                 )
          //                 )
          // ],
        ),
        body: provider.busy
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: double.infinity,
                            color: HexColor("F0F0F2"),
                            child: DynamicBoxForBookSize(
                              height: provider.height,
                              width: provider.width,
                              price: provider.price,
                              onPressed: () {} /*+' \u{20AC}'*/,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                            child: Text(
                              Languages.of(context)!.Size,
                              style: TextStyle(
                                  color: MyColors.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 6),
                            height: 80,
                            width: double.infinity,
                            child: GridView.builder(
                              shrinkWrap: false,
                              itemCount: provider.dimensions.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              2),
                                      crossAxisSpacing: 1,
                                      mainAxisSpacing: 1),
                              itemBuilder: (context, index) {
                                bool isSelected =
                                    provider.dimensions[index]["isSelected"];
                                String size =
                                    provider.dimensions[index]["sizeInString"];
                                String price = double.parse(
                                        provider.dimensions[index]["price"])
                                    .toStringAsFixed(2);
                                return GestureDetector(
                                    onTap: () =>
                                        provider.changeDimension(index),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: 120,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: isSelected
                                                    ? MyColors.primaryColor
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: isSelected
                                                        ? MyColors.primaryColor
                                                        : Colors.black,
                                                    width: 2,
                                                    style: BorderStyle.solid)),
                                            child: Text(
                                              size,
                                              style: TextStyle(
                                                  color: isSelected
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
                            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                            child: Container(
                              height: 1.0,
                              width: MediaQuery.of(context).size.width * 1.0,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                            child: Text(
                              Languages.of(context)!.Binding,
                              style: TextStyle(
                                  color: MyColors.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),

                          /*SizedBox(
                      height: 12.0,
                    ),*/
                          Container(
                            height: 130,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: provider.bindings.length,
                              itemBuilder: (BuildContext context, int index) {
                                String name = provider.bindings[index]["name"];
                                String ss;
                                String imagename;
                                if (name == "hardbinding") {
                                  ss = "HardBinding";
                                  imagename = "assets/img/CoilBinding.jpg";
                                } else if (name == "spinbinding") {
                                  ss = "SpinBinding";
                                  imagename = "assets/img/SpinBinding.jpg";
                                } else if (name == "coilbinding") {
                                  ss = "CoilBinding";
                                  imagename = "assets/img/CoilBinding.jpg";
                                } else {
                                  ss = name;
                                  imagename = "assets/img/CoilBinding.jpg";
                                }
                                bool isSelected =
                                    provider.bindings[index]["isSelected"];
                                return GestureDetector(
                                  onTap: () {
                                    provider.changeBindings(index);
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(left: 6),
                                          width: 120,
                                          height: 100.0,
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    width: 2,
                                                    color: isSelected
                                                        ? MyColors.primaryColor
                                                        : HexColor("999999"),
                                                  ),
                                                ),
                                                height: 108,
                                                margin: EdgeInsets.fromLTRB(
                                                    4, 0, 4, 0),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          6),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          6)),
                                                          image: DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: AssetImage(
                                                                "assets/images/Border_Thum1.jpg",
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 118,
                                                      padding: EdgeInsets.only(
                                                          top: 4, bottom: 4),
                                                      color: isSelected
                                                          ? MyColors
                                                              .primaryColor
                                                          : HexColor("999999"),
                                                      child: Text(
                                                        name,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: isSelected
                                                                ? Colors.white
                                                                : MyColors
                                                                    .primaryColor,
                                                            fontSize: 15.0,
                                                            height: 1),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Icon(
                                                  isSelected
                                                      ? Icons.check_circle
                                                      : null,
                                                  color: MyColors.primaryColor,
                                                ),
                                              ),
                                            ],
                                          )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          "20 – 96 stran",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              height: 1),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
                    child: Container(
                        height: 45.0,
                        width: MediaQuery.of(context).size.width * 1.0,
                        child: ElevatedButton(
                          child: Text(Languages.of(context)!.Next
                              // ""
                              ),
                          style: ElevatedButton.styleFrom(
                            primary: MyColors.primaryColor,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            side: BorderSide(color: MyColors.primaryColor),
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                          onPressed: () {
                            provider.artistApiCall = false;
                            // provider.isGooglemediaitemGet = false;
                            if (provider.isGoogleLoggedIn) {
                              provider.listGoogleMediaItem = [];
                              provider.isgoogleLoading = false;
                              provider.listmediaItem("");
                            }
                            provider.setTab(0);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewphotoselectionPage("photobook")),
                            );
                          },
                        )),
                  ),
                ],
              ));
  }
}

class PhotobookCustomizationPage extends StatelessWidget {
  List imageList;
  List itemList;
  String categorytype;
  late int max_photo;
  late int min_photo;
  late int creation_id;
  String product_id;
  String product_price;
  String selectedSize;
  String product_name;
  String slovaktitle;
  BuildContext contextmain;
  PhotobookCustomizationPage(
      this.contextmain,
      this.imageList,
      this.itemList,
      this.categorytype,
      this.max_photo,
      this.min_photo,
      this.product_id,
      this.product_price,
      this.selectedSize,
      this.product_name,
      this.slovaktitle,
      this.creation_id);
  @override
  Widget build(BuildContext context) {
    // print("rrrrrrrrr"+imageList.length.toString());
    return _PhotobookCustomizationPage(
        contextmain,
        imageList,
        itemList,
        categorytype,
        max_photo,
        min_photo,
        product_id,
        product_price,
        selectedSize,
        product_name,
        slovaktitle,
        creation_id);
  }
}

class _PhotobookCustomizationPage extends StatefulWidget {
  List imageList;
  List itemList;
  String categoryType;
  int max_photo;
  int min_photo;
  int creation_id;
  String product_id;
  String product_price;
  String selectedSize;
  String product_name;
  String slovaktitle;
  BuildContext contextmain;
  _PhotobookCustomizationPage(
      this.contextmain,
      this.imageList,
      this.itemList,
      this.categoryType,
      this.max_photo,
      this.min_photo,
      this.product_id,
      this.product_price,
      this.selectedSize,
      this.product_name,
      this.slovaktitle,
      this.creation_id);

  @override
  __PhotobookCustomizationPageState createState() =>
      __PhotobookCustomizationPageState(
          contextmain,
          imageList,
          itemList,
          categoryType,
          max_photo,
          min_photo,
          product_id,
          product_price,
          selectedSize,
          product_name,
          slovaktitle,
          creation_id);
}

class __PhotobookCustomizationPageState
    extends State<_PhotobookCustomizationPage> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;
  late List imageList;
  late List itemList;
  late BuildContext contextmain;
  late String categorytype;
  late int max_photo;
  late int min_photo;
  late int creation_id;
  late String product_id;
  late String product_price;
  late String selectedSize;
  late String product_name;
  late String slovaktitle;
  __PhotobookCustomizationPageState(
      this.contextmain,
      this.imageList,
      this.itemList,
      this.categorytype,
      this.max_photo,
      this.min_photo,
      this.product_id,
      this.product_price,
      this.selectedSize,
      this.product_name,
      this.slovaktitle,
      this.creation_id);
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();
  bool _cropping = false;
  //ExtendedImageCropLayerCornerPainter _cornerPainter;
  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(microseconds: 200), vsync: this);
    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
        .animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    // clearMemoryImageCache();
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
    super.dispose();
  }

  Widget withoutAppBar(BuildContext context, NavigationProvider provider) {
    return AppBar(
      backgroundColor: Colors.black.withOpacity(0.8),
      leading: provider.istextFormatting == 3
          ? Container()
          : IconButton(
              padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
              icon: Icon(Icons.clear, color: Colors.white70),
              onPressed: () async {
                if (provider.istextFormatting == 2) {
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
                      width: 100.0,
                      child: IconButton(
                        icon: Text(
                          Languages.of(contextmain)!.Remove,
                          // "",
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

  Widget setupAlertDialoadContainer(
      NavigationProvider provider, BuildContext context) {
    return Container(
      height: 100.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: provider.getLayout.length,
          itemBuilder: (BuildContext ctx, int index) {
            return LayoutItem(
                provider, index, ctx, provider.getLayout[index], true);
          }),
    );
  }

  void convertWidgetToImage(NavigationProvider provider) async {
    RenderRepaintBoundary? repaintBoundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
    ui.Image boxImage = await repaintBoundary!.toImage(pixelRatio: 1);
    ByteData? byteData =
        await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8list = byteData!.buffer.asUint8List();
    provider.updateImage(uint8list);
  }

  Future<void> convertImageToCropImage(NavigationProvider provider) async {
    final ExtendedImageEditorState? state = editorKey.currentState;
    final Rect? rect = state!.getCropRect();
    final EditActionDetails? action = state.editAction;
    final rotateAngle = action!.rotateAngle.toInt();
    final flipHorizontal = action.flipY;
    final flipVertical = action.flipX;
    final img = state.rawImageData;

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

    final Duration diff = DateTime.now().difference(start);

    provider.updateImage(result!);
  }

  Widget mainAppBar(BuildContext context, NavigationProvider provider) {
    return AppBar(
      backgroundColor: MyColors.primaryColor,
      leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (categorytype != "cart") {
              provider.addCreation(
                  contextmain,
                  categorytype,
                  context,
                  provider,
                  max_photo,
                  min_photo,
                  product_id,
                  product_price,
                  selectedSize,
                  product_name,
                  slovaktitle,
                  creation_id);
            } else {
              Navigator.of(context).pop();
            }
          }),
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        // "Edit Page",
        Languages.of(contextmain)!.Album,
        // "",
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: SizedBox(
                width: 80.0,
                child: IconButton(
                  icon: Text(
                    Languages.of(contextmain)!.Preview,
                    // "",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onPressed: () {
                    print(provider.mainImageList);
                    print(provider.imageList);
                    print(provider.getItems);
                    // return;
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.landscapeLeft,
                      DeviceOrientation.landscapeRight
                    ]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhotoBookPerviewPage(
                                contextmain,
                                provider.getItems,
                                provider.mainImageList,
                                product_id,
                                categorytype,
                                int.parse(provider.maxpage),
                                int.parse(provider.minPage),
                                product_price,
                                provider.selectedSize,
                                provider.product_name,
                                slovaktitle,
                                creation_id)));
                  },
                ))),
      ],
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

  int count = 0;
  @override
  Widget build(BuildContext context) {
    print('this.itemList');
    print(this.itemList);
    final provider = Provider.of<NavigationProvider>(context);
    if (count == 0) {
      count++;
      if (categorytype == "creation" || categorytype == "cart") {
        provider.addDataForCreationEdit(
            contextmain,
            imageList,
            itemList,
            categorytype,
            max_photo,
            min_photo,
            product_id,
            product_price,
            selectedSize,
            product_name,
            slovaktitle);
      } else {
        print(max_photo);
        print(min_photo);
        provider.addItemS(imageList, categorytype, max_photo, min_photo,
            product_price, product_id, product_name, slovaktitle);
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: provider.istextFormatting > 0 && provider.istextFormatting < 4
              ? withoutAppBar(context, provider)
              : mainAppBar(context, provider)),
      body: provider.busy
          ? Container(child: Center(child: CircularProgressIndicator()))
          : Container(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2 + 160,
                      child: GridView.builder(
                          shrinkWrap: false,
                          itemCount: provider.getItems.length + 1,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 1.0,
                            childAspectRatio: (1 / 0.55),
                            mainAxisSpacing: 1.0,
                          ),
                          itemBuilder: (context, index) {
                            if (index == provider.getItems.length) {
                              return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        useRootNavigator: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                                Languages.of(contextmain)!
                                                    .Pleaseselectlayout),
                                            content: setupAlertDialoadContainer(
                                                provider, context),
                                          );
                                        });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(16, 16, 16, 24),
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.black,
                                          style: BorderStyle.solid),
                                    ),
                                    child: Center(
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Colors.black.withOpacity(0.9),
                                            border: Border.all(
                                              width: 2,
                                              color:
                                                  Colors.black.withOpacity(0.9),
                                            ),
                                          ),
                                          child: Center(
                                            child: GestureDetector(
                                              child: Container(
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 28,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            } else {
                              print('provider.getItems[index]');
                              return PhotoBookCustomItem(
                                  contextmain,
                                  provider,
                                  index,
                                  context,
                                  provider.getItems[index],
                                  editorKey);
                            }
                          }),
                    ),
                  ),
                  // Positioned(
                  //   top: case2(
                  //     provider.isExpanded,
                  //     {
                  //       0: null,
                  //       1: 0,
                  //       2: 0,
                  //     },
                  //     null,
                  //   ),
                  //   bottom: 0,
                  //   left: 0,
                  //   right: 0,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       provider.setExpand("0", "expandclosed");
                  //       switch (controller.status) {
                  //         case AnimationStatus.dismissed:
                  //           controller.forward();
                  //           break;
                  //         default:
                  //       }
                  //     },
                  //     child: Container(
                  //         color: Colors.black.withOpacity(0.5),
                  //         child: Align(
                  //           alignment: Alignment.bottomCenter,
                  //           child: Container(
                  //             height: 50,
                  //             color: Colors.white,
                  //             child: Row(
                  //               children: [
                  //                 InkWell(
                  //                   onTap: () {
                  //                     provider.setExpand("1", "expandOpen");
                  //                     switch (controller.status) {
                  //                       case AnimationStatus.completed:
                  //                         controller.reverse();
                  //                         break;
                  //                       default:
                  //                     }
                  //                   },
                  //                   child: Container(
                  //                     width: MediaQuery.of(context).size.width *
                  //                         0.5,
                  //                     child: Center(
                  //                       child: Row(
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.center,
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.center,
                  //                         children: [
                  //                           Image.asset(
                  //                             "assets/icon/Photos_Unselect.png",
                  //                             fit: BoxFit.contain,
                  //                             height: 20,
                  //                             width: 20,
                  //                           ),
                  //                           Padding(
                  //                             padding: const EdgeInsets.only(
                  //                                 left: 8.0),
                  //                             child: Text(
                  //                               Languages.of(contextmain)!
                  //                                   .Photos,
                  //                               style: TextStyle(
                  //                                   fontSize: 18,
                  //                                   color: Colors.grey),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 InkWell(
                  //                   onTap: () {
                  //                     provider.setExpand("2", "expandOpen");
                  //                     switch (controller.status) {
                  //                       case AnimationStatus.completed:
                  //                         controller.reverse();
                  //                         break;
                  //                       default:
                  //                     }
                  //                   },
                  //                   child: Container(
                  //                     width: MediaQuery.of(context).size.width *
                  //                         0.5,
                  //                     child: Center(
                  //                       child: Row(
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.center,
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.center,
                  //                         children: [
                  //                           Image.asset(
                  //                             "assets/icon/Layout_Unselect.png",
                  //                             fit: BoxFit.contain,
                  //                             height: 20,
                  //                             width: 20,
                  //                           ),
                  //                           Padding(
                  //                             padding: const EdgeInsets.only(
                  //                                 left: 8.0),
                  //                             child: Text(
                  //                               // "Editor Bottom Layout"
                  //                               Languages.of(contextmain)!
                  //                                   .Layout,
                  //                               // "",
                  //                               style: TextStyle(
                  //                                   fontSize: 18,
                  //                                   color: Colors.grey),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //         )),
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SlideTransition(
                      position: offset,
                      child: Padding(
                        padding: EdgeInsets.only(top: 0.0),
                        child: AnimatedContainer(
                          color: Colors.white,
                          // height: case2(
                          //     provider.isExpanded,
                          //     {
                          //       0: 0,
                          //       1: 220,
                          //       2: 180,
                          //     },
                          //     0),
                          duration: Duration(milliseconds: 100),
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        provider.setExpand("1", "");
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Center(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                case2(provider.which_bottom, {
                                                  "": "assets/icon/Photos_Unselect.png",
                                                  "1":
                                                      "assets/icon/Photos_Select.png",
                                                  "2":
                                                      "assets/icon/Photos_Unselect.png",
                                                }),
                                                fit: BoxFit.contain,
                                                height: 20,
                                                width: 20,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  Languages.of(contextmain)!
                                                      .Photos,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: case2(
                                                          provider.which_bottom,
                                                          {
                                                            "": Colors.grey,
                                                            "1": MyColors
                                                                .primaryColor,
                                                            "2": Colors.grey,
                                                          })),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        provider.setExpand("2", "");
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Center(
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    case2(
                                                        provider.which_bottom, {
                                                      "": "assets/icon/Layout_Unselect.png",
                                                      "1":
                                                          "assets/icon/Layout_Unselect.png",
                                                      "2":
                                                          "assets/icon/Layout_Select.png",
                                                    }),
                                                    fit: BoxFit.contain,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      Languages.of(contextmain)!
                                                          .Layout,
                                                      // "",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: case2(
                                                              provider
                                                                  .which_bottom,
                                                              {
                                                                "": Colors.grey,
                                                                "1":
                                                                    Colors.grey,
                                                                "2": MyColors
                                                                    .primaryColor,
                                                              })),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  padding:
                                      EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                                  child: provider.which_bottom == "1"
                                      ? getSelectedImages(contextmain, provider,
                                          context, provider.seletedImagebase64)
                                      : getlayoutItems(
                                          contextmain, provider, context)),
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                                child: Container(
                                    height: 35.0,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: ElevatedButton(
                                      child:
                                          Text(Languages.of(contextmain)!.Done
                                              // ""
                                              ),
                                      style: ElevatedButton.styleFrom(
                                        primary: MyColors.primaryColor,
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        ),
                                        side: BorderSide(
                                            color: MyColors.primaryColor),
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      onPressed: () {
                                        provider.setExpand("0", "expandclosed");
                                        switch (controller.status) {
                                          case AnimationStatus.dismissed:
                                            controller.forward();
                                            break;
                                          default:
                                        }
                                      },
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  case2(
                    provider.istextFormatting,
                    {
                      0: Container(),
                      2: imageFilterWidget(contextmain, provider, context,
                          provider.seletedImagebase64),
                      1: textFormatingWidget(contextmain, provider, context),
                      3: chooseImage(contextmain, provider, context),
                    },
                    Container(),
                  )
                ],
              ),
            ),
    );
  }

  Widget chooseImage(BuildContext contextmain, NavigationProvider provider,
      BuildContext context) {
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
                                  child: Image.memory(base64Decode(
                                      provider.selcted_image_base64new))),
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
                                child: provider.selectedlowIMageuri == null
                                    ? Container()
                                    : Image.file(new File(
                                        provider.selectedlowIMageuri!)),
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

  Widget getSelectedImages(BuildContext contextmain,
      NavigationProvider provider, BuildContext context, String base64) {
    return Container(
      height: 120,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (MediaQuery.of(context).size.width) *
                0.24 /
                MediaQuery.of(context).size.height /
                .16,
            crossAxisSpacing: 4,
            mainAxisSpacing: 6),
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemCount: provider.mainImageList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return GestureDetector(
              onTap: () {
                gotoPhotoSelectionPage(
                    contextmain, context, provider, 1, 10, false);
              },
              child: DottedBorder(
                color: Colors.black,
                dashPattern: [6, 3],
                strokeWidth: 1,
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.black),
                    onPressed: () => gotoPhotoSelectionPage(
                        contextmain, context, provider, 1, 10, false),
                  ),
                ),
              ),
            );
          } else {
            return SelectedPhotoItem(provider, index - 1, context, contextmain,
                provider.mainImageList[(index - 1)]);
          }
        },
      ),
    );
  }

  Widget textFormatingWidget(BuildContext contextmain,
      NavigationProvider provider, BuildContext context) {
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
                                    onChanged: (value) {
                                      print(value);
                                      // provider.changeFontSize(value)
                                    },
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
                                    onChanged: (value) {
                                      print(value);
                                      //  provider.changeEditTextPostion(value)
                                    },
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
                    0: secondWidget(contextmain, provider, context),
                    1: secondColorWidget(provider, context, "text"),
                    2: secondColorWidget(provider, context, "bg"),
                  },
                  secondWidget(contextmain, provider, context),
                ),
                SizedBox(
                  height: 16,
                ),
                thirdWidget(contextmain, provider, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget testingTopWidget(BuildContext contextmain, NavigationProvider provider,
      BuildContext context) {
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
                      Icon(
                        Icons.format_color_text,
                        color: case2(
                            provider.selectedtextFormatTabindex,
                            {
                              0: MyColors.primaryColor,
                            },
                            Colors.grey[300]),
                        size: 30,
                      ),
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
                      Icon(
                        Icons.format_color_text,
                        color: case2(
                            provider.selectedtextFormatTabindex,
                            {
                              1: MyColors.primaryColor,
                            },
                            Colors.grey[300]),
                        size: 30,
                      ),
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
                      Icon(
                        Icons.format_color_text,
                        color: case2(
                            provider.selectedtextFormatTabindex,
                            {
                              2: MyColors.primaryColor,
                            },
                            Colors.grey[300]),
                        size: 30,
                      ),
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

  Widget thirdWidget(BuildContext contextmain, NavigationProvider provider,
      BuildContext context) {
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
                  fontFamily: provider.selectFontKey),
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

  Widget secondColorWidget(
      NavigationProvider provider, BuildContext context, String what) {
    return Container(
      height: 50,
      child: GridView.builder(
          shrinkWrap: false,
          itemCount: provider.colorList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 1.0,
            childAspectRatio: (1 / 0.55),
            mainAxisSpacing: 1.0,
          ),
          itemBuilder: (ctx, index) {
            return case2(what, {
              "text": TextColorItem(
                  provider, index, ctx, provider.colortList[index]),
              "bg":
                  BGColorItem(provider, index, ctx, provider.colortList[index]),
            });
          }),
    );
  }

  Widget secondWidget(BuildContext contextmain, NavigationProvider provider,
      BuildContext context) {
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
                fontWeight: FontWeight.bold,
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

  Widget getlayoutItems(BuildContext contextmain, NavigationProvider provider,
      BuildContext context) {
    print("provider.getLayout");
    // print(provider.getLayout);
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
          shrinkWrap: false,
          itemCount: provider.getLayout.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            // crossAxisSpacing: 1.0,
            childAspectRatio: (1 / 0.6),
            mainAxisSpacing: 1.0,
          ),
          itemBuilder: (ctx, index) {
            return LayoutItem(
                provider, index, ctx, provider.getLayout[index], false);
          }),
    );
  }

  Widget imagerotateThirdWidget(
      BuildContext contextmain,
      NavigationProvider provider,
      BuildContext context,
      GlobalKey<ExtendedImageEditorState> editorKey) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 8, 12, 0),
      height: 140,
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: GridView.builder(
                shrinkWrap: false,
                itemCount: provider.aspectRatios.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: (1 / 0.55),
                  mainAxisSpacing: 1.0,
                ),
                itemBuilder: (ctx, index) {
                  final AspectRatioItem item = provider.aspectRatios[index];
                  return GestureDetector(
                    child: AspectRatioWidget(
                      aspectRatio: item.value,
                      aspectRatioS: item.text,
                      isSelected: item == provider.aspectRatio,
                    ),
                    onTap: () {
                      provider.changeaspectratio(item);
                    },
                  );
                }),
          ),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                      child: ElevatedButton(
                    child:
                        Text(Languages.of(contextmain)!.Tryagain.toUpperCase()),
                    style: ElevatedButton.styleFrom(
                      primary: MyColors.primaryColor,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      side: BorderSide(color: MyColors.primaryColor),
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      editorKey.currentState!.rotate(right: false);
                    },
                  )),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                      child: ElevatedButton(
                    child: Text(Languages.of(contextmain)!.Flip),
                    style: ElevatedButton.styleFrom(
                      primary: MyColors.primaryColor,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      side: BorderSide(color: MyColors.primaryColor),
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    onPressed: () {
                      editorKey.currentState!.flip();
                    },
                  )),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                      child: ElevatedButton(
                    child: Text(Languages.of(contextmain)!.RotateRight),
                    style: ElevatedButton.styleFrom(
                      primary: MyColors.primaryColor,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      side: BorderSide(color: MyColors.primaryColor),
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    onPressed: () {
                      editorKey.currentState!.rotate(right: true);
                    },
                  )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget imageFilterThirdWidget(BuildContext contextmain,
      NavigationProvider provider, BuildContext context) {
    List<ImageFilterModel> list = provider.filterList;
    List<ImageFilterModelUrl> listUrl = provider.filterListUrl;
    return Container(
      height: 100,
      child: GridView.builder(
          shrinkWrap: false,
          itemCount: list.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 1.0,
            childAspectRatio: (1 / 0.55),
            mainAxisSpacing: 1.0,
          ),
          itemBuilder: (ctx, index) {
            return FilterItemList(
                provider,
                index,
                context,
                list[index],
                'phone',
                list[index].name,
                list[index].isSelected,
                list[index].filter);
          }),
    );
  }

  Widget imageFilterThirdWidgetUrl(BuildContext contextmain,
      NavigationProvider provider, BuildContext context) {
    List<ImageFilterModelUrl> listUrl = provider.filterListUrl;
    return listUrl.isNotEmpty
        ? Container(
            height: 100,
            child: GridView.builder(
                shrinkWrap: false,
                itemCount: listUrl.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: (1 / 0.55),
                  mainAxisSpacing: 1.0,
                ),
                itemBuilder: (ctx, index) {
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

  Widget imageFilterFirstWidget(
      NavigationProvider provider, BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: case2(
              provider.selectedimageFilterTabindex,
              {
                0: provider.selcted_image_type != null
                    ? Center(
                        child: provider.whichImageShow == "original"
                            ? ExtendedImage.memory(
                                base64Decode(provider.selcted_image_base64new),
                                shape: provider.isLayoutCircle
                                    ? BoxShape.circle
                                    : BoxShape.rectangle,
                                fit: BoxFit.contain,
                                height: 300,
                                width: 300,
                                cacheRawData: true,
                                clearMemoryCacheWhenDispose: true,
                                mode: ExtendedImageMode.editor,
                                enableLoadState: true,
                                extendedImageEditorKey: editorKey,
                                initEditorConfigHandler: (state) {
                                  return EditorConfig(
                                      maxScale: 8.0,
                                      cropRectPadding:
                                          const EdgeInsets.all(0.0),
                                      hitTestSize: 20.0,
                                      //cornerPainter: _cornerPainter,
                                      initCropRectType:
                                          InitCropRectType.layoutRect,
                                      cropAspectRatio:
                                          provider.aspectRatio.value);
                                },
                              )
                            : ExtendedImage.memory(
                                base64Decode(provider.selcted_image_base64new),
                                cacheRawData: true,
                                clearMemoryCacheWhenDispose: true,
                                shape: provider.isLayoutCircle
                                    ? BoxShape.circle
                                    : BoxShape.rectangle,
                                fit: BoxFit.contain,
                                height: 300,
                                width: 300,
                                mode: ExtendedImageMode.editor,
                                enableLoadState: true,
                                extendedImageEditorKey: editorKey,
                                initEditorConfigHandler: (state) {
                                  return EditorConfig(
                                      maxScale: 8.0,
                                      hitTestSize: 20.0,
                                      initCropRectType:
                                          InitCropRectType.layoutRect,
                                      cropAspectRatio:
                                          provider.aspectRatio.value);
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
                        decoration: BoxDecoration(
                          shape: provider.isLayoutCircle
                              ? BoxShape.circle
                              : BoxShape.rectangle,
                        ),
                        /*height: 250,*/
                        child: ColorFiltered(
                          colorFilter:
                              ColorFilter.matrix(provider.selected_filter),
                          child: provider.seletedImageuri == null
                              ? Image.asset(
                                  "assets/images/economy_photobook.jpg",
                                  fit: provider.isLayoutCircle
                                      ? BoxFit.cover
                                      : BoxFit.cover,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      //shape: provider.isLayoutCircle?BoxShape.circle:BoxShape.rectangle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: Image.memory(
                                            base64Decode(provider
                                                .selcted_image_base64new),
                                          ).image)),
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

  convertImagewhengointToText(NavigationProvider provider) async {
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
    provider.originaltextEditIMage = result!;
    // print("heheh" + result.toString());
  }

  void gotoPhotoSelectionPage(
      BuildContext contextmain,
      BuildContext context,
      NavigationProvider provider,
      int minPhoto,
      int maxPhoto,
      bool layout) async {
    List imageList;
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              // provider._where = "photobbokcustomization";
              NewphotoselectionPage("")),
    );

    if (result != null) {
      imageList = result;
      if (layout) {
        provider.addImage(imageList);
      } else {
        if (imageList.length == 1) {
          provider.replaceImage(imageList[0]);
        } else {
          provider.addIMages(imageList);
          // print("result - " + result.toString());
        }
      }
    }
  }

  Widget imageSecondWidget(contextmain, NavigationProvider provider,
      BuildContext context, String base64) {
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
            child: InkWell(
              onTap: () => provider.changeImageFilterSelectedTabColor(0),
              child: Center(
                child: Container(
                  child: Column(
                    children: [
                      Icon(
                        Icons.refresh,
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
                          Languages.of(contextmain)!.Rotate,
                          style: TextStyle(
                              color: case2(
                                  provider.selectedimageFilterTabindex,
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
            child: InkWell(
              onTap: () => provider.changeImageFilterSelectedTabColor(1),
              child: Center(
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
                          // "",
                          style: TextStyle(
                              color: case2(
                                  provider.selectedimageFilterTabindex,
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
            child: InkWell(
              onTap: () {
                print('gotoPhotoSelectionPage');
                // gotoPhotoSelectionPage(
                //     contextmain, context, provider, 1, 1, false);
              },
              child: Center(
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
            child: InkWell(
              onTap: () {
                if (provider.whichImageShow == "original") {
                  convertImagewhengointToText(provider);
                }
                provider.changeImageFilterSelectedTabColor(3);
              },
              child: Center(
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

  Widget imageFilterWidget(BuildContext contextmain,
      NavigationProvider provider, BuildContext context, String base64) {
    return Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        color: Colors.black.withOpacity(0.8),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imageFilterFirstWidget(provider, context),
              imageSecondWidget(contextmain, provider, context, base64),
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
            ],
          ),
        ),
      ),
    );
  }
}

class TextColorItem extends StatelessWidget {
  NavigationProvider provider;
  int index;
  BuildContext context;
  CustomColor customColor;

  TextColorItem(
    this.provider,
    this.index,
    this.context,
    this.customColor,
  );

  @override
  Widget build(BuildContext context) {
    bool isSelected = customColor.isSelected;
    Color itemColor = customColor.color;
    return GestureDetector(
      onTap: () => provider.changeTExtColor(index),
      child: Container(
        margin: EdgeInsets.all(8),
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: itemColor,
          border: Border.all(
            width: 2,
            color: isSelected ? MyColors.primaryColor : Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class BGColorItem extends StatelessWidget {
  NavigationProvider provider;
  int index;
  BuildContext context;
  CustomColor customColor;

  BGColorItem(this.provider, this.index, this.context, this.customColor);

  @override
  Widget build(BuildContext context) {
    bool isSelected = customColor.isSelected;
    Color itemColor = customColor.color;
    return GestureDetector(
      onTap: () => provider.changeBGColor(index),
      child: Container(
        margin: EdgeInsets.all(8),
        height: 30,
        width: 35,
        decoration: BoxDecoration(
          color: itemColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 2,
            color: isSelected ? MyColors.primaryColor : Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class SelectedPhotoItem extends StatelessWidget {
  NavigationProvider provider;
  int index;
  BuildContext context;
  BuildContext contextmain;
  Map model;

  SelectedPhotoItem(
      this.provider, this.index, this.contextmain, this.context, this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          provider.increaseCount(index, context, contextmain);
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
                border: Border.all(
                  color: MyColors.primaryColor,
                  width: 1,
                ),
                image: DecorationImage(
                  image: Image.memory(base64Decode(model["base64"])).image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 3, 3),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColors.primaryColor,
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Text(
                    model["count"] != ""
                        ? ((model["count"].split(",").length) / 2)
                            .toStringAsFixed(0)
                        : "0",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ),
            )
          ],
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
}

class LayoutItem extends StatelessWidget {
  NavigationProvider provider;
  int index;
  BuildContext context;
  dynamic model;
  bool addItemorNotChangeLayout;

  LayoutItem(this.provider, this.index, this.context, this.model,
      this.addItemorNotChangeLayout);

  @override
  Widget build(BuildContext context) {
    print("model");
    // print(model);
    return InkWell(
      onTap: () {
        if (addItemorNotChangeLayout) {
          provider.addItemafterPhotoSelect(model["_layout_id"]);
        } else {
          print('model["_layout_id"]');
          print(model["_layout_id"]);
          print(provider.getItems);
          if (provider.getItems[provider.selectedIndex]["_layout_id"] !=
              model["_layout_id"]) {
            print("changeLayout");
            provider.changeLayout(index);
          }
        }
      },
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 3,
                color: model["_isSelected"]
                    ? (Colors.grey[300])!
                    : (Colors.grey[100])!),
            color: Colors.white,
          ),
          width: 100,
          margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: case2(model["_layout_id"], {
            "1": getLayouTRow1(model["_isSelected"]),
            "2": getLayouTRow2(model["_isSelected"]),
            "3": getLayouTRow3(model["_isSelected"]),
          })),
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
}

Widget getLayouTRow1(bool isSelected) {
  return Row(
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: MyColors.primaryColor.withOpacity(isSelected ? 1 : 0.5),
              shape: BoxShape.circle),
        ),
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.all(4),
          color: MyColors.primaryColor.withOpacity(isSelected ? 1 : 0.5),
        ),
      ),
    ],
  );
}

Widget getLayouTRow2(bool isSelected) {
  return Row(
    children: [
      Expanded(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color:
                      MyColors.primaryColor.withOpacity(isSelected ? 1 : 0.5),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: MyColors.primaryColor
                            .withOpacity(isSelected ? 1 : 0.5),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: MyColors.primaryColor
                            .withOpacity(isSelected ? 1 : 0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.all(4),
          color: MyColors.primaryColor.withOpacity(isSelected ? 1 : 0.5),
        ),
      ),
    ],
  );
}

Widget getLayouTRow3(bool isSelected) {
  return Row(
    children: [
      Expanded(
        child: Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.all(4),
          color: MyColors.primaryColor.withOpacity(isSelected ? 1 : 0.5),
        ),
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: MyColors.primaryColor.withOpacity(isSelected ? 1 : 0.5),
          ),
        ),
      ),
    ],
  );
}

class FilterItemList extends StatelessWidget {
  NavigationProvider provider;
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
                        fit: BoxFit.cover,
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
  late NavigationProvider provider;
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
                              fit: BoxFit.cover,
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
                              imageUrl: imageUrl + "=w400-h400-c",
                              width: 80,
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

class PhotoBookCustomItem extends StatelessWidget {
  NavigationProvider provider;
  int index;
  BuildContext contextmain;
  BuildContext context;
  dynamic model;
  GlobalKey<ExtendedImageEditorState> editorKey;

  PhotoBookCustomItem(this.contextmain, this.provider, this.index, this.context,
      this.model, this.editorKey);

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => provider.selectItem(index),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.2+90,
        margin: EdgeInsets.fromLTRB(4, 16, 8, 4),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  Card(
                    elevation: model["isSelected"] ? 8 : 4,
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.2 + 32.8,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: model["isSelected"]
                                  ? MyColors.primaryColor
                                  : (Colors.grey[300])!),
                        ),
                        child: case2(
                          model["layout_id"],
                          {
                            "1": getPhotoBookCustomItem1(
                                contextmain, context, provider, model, index),
                            "2": getPhotoBookCustomItem2(
                                contextmain, context, provider, model, index),
                            "3": getPhotoBookCustomItem3(contextmain, context,
                                provider, model, index, editorKey),
                          },
                          getPhotoBookCustomItem3(contextmain, context,
                              provider, model, index, editorKey),
                        )),
                  ),
                ],
              ),
            ),
            model["isSelected"]
                ? Container(
                    child: Positioned(
                      right: 0.0,
                      top: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          provider.removeItem(index);
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            border: Border.all(
                              width: 2,
                              color: Colors.black,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              child: Icon(
                                Icons.clear,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget getPhotoBookCustomItem1(BuildContext contextmain, BuildContext context,
      NavigationProvider provider, model, int index) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.20 + 90,
            margin: EdgeInsets.all(8),
            decoration: model["imageModel"].imageType.length > 0 &&
                    model["imageModel"].imageType[0] != ""
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: Image.memory(
                              base64Decode(model["imageModel"].base64[0])
                            )
                          .image,
                      fit: BoxFit.cover,
                    ))
                : BoxDecoration(
                    shape: BoxShape.circle, color: MyColors.primaryColor),
            child: model["imageModel"].imageType.length > 0 &&
                    model["imageModel"].imageType[0] != ""
                ? Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.20 + 90,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.7),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 16,
                          ),
                          onPressed: () async {
                            editorKey = provider.editorKey;
                            bool isCropped = false;
                            if (model["imageModel"].iscroppeds[0] == "true") {
                              isCropped = true;
                            } else {
                              isCropped = false;
                            }
                            provider.width = provider.selected_width;
                            provider.height = provider.selected_height;
                            provider.openImageEdit(
                                model["imageModel"].base64[0],
                                isCropped,
                                model["imageModel"].imageType[0],
                                model["imageModel"].imageUrl[0],
                                model["imageModel"].fileuriPath[0],
                                model["imageModel"].fileuriPathlowreso[0],
                                "photobook",
                                false,
                                0);
                            provider.setphotobookpagePostion(index);
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhotoEdit(contextmain)),
                            );
                            if (result != null) {
                              provider.updatePhotobookImage(result);
                            }
                            print("provider.openImageFilter");
                          },
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: GestureDetector(
                      onTap: () {
                        print("model");
                        provider.addImageToLayout(
                            model["layout_id"],
                            index,
                            model["imageModel"].imageType.isNotEmpty
                                ? model["imageModel"].imageType.length
                                : 0,
                            0);
                        gotoPhotoSelectionPage(
                            contextmain, context, provider, 1, 1, true);
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.7),
                            border: Border.all(
                              width: 2,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          child: Center(
                            child: GestureDetector(
                              child: Container(
                                child: Icon(
                                  Icons.add,
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
          ),
        ),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.20 + 35,
            margin: EdgeInsets.all(8),
            decoration: (model["imageModel"].imageType.length > 1 &&
                    model["imageModel"].imageType[1] != "")
                ? BoxDecoration(
                    image: DecorationImage(
                    image: Image.memory(
                            base64Decode(model["imageModel"].base64[1]))
                        .image,
                    fit: BoxFit.cover,
                  ))
                : BoxDecoration(color: MyColors.primaryColor),
            child: (model["imageModel"].imageType.length > 1 &&
                    model["imageModel"].imageType[1] != "")
                ? Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.7),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                            onPressed: () async {
                              editorKey = provider.editorKey;
                              bool isCropped = false;
                              if (model["imageModel"].iscroppeds[1] == "true") {
                                isCropped = true;
                              } else {
                                isCropped = false;
                              }
                              provider.width = provider.selected_width;
                              provider.height = provider.selected_height;
                              provider.openImageEdit(
                                  model["imageModel"].base64[1],
                                  isCropped,
                                  model["imageModel"].imageType[1],
                                  model["imageModel"].imageUrl[1],
                                  model["imageModel"].fileuriPath[1],
                                  model["imageModel"].fileuriPathlowreso[1],
                                  "photobook",
                                  false,
                                  1);
                              provider.setphotobookpagePostion(index);
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PhotoEdit(contextmain)),
                              );
                              if (result != null) {
                                provider.updatePhotobookImage(result);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: GestureDetector(
                      onTap: () {
                        provider.addImageToLayout(
                            model["layout_id"],
                            index,
                            model["imageModel"].imageType.isNotEmpty
                                ? model["imageModel"].imageType.length
                                : 0,
                            1);
                        gotoPhotoSelectionPage(
                            contextmain, context, provider, 1, 1, true);
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.7),
                            border: Border.all(
                              width: 2,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          child: Center(
                            child: GestureDetector(
                              child: Container(
                                child: Icon(
                                  Icons.add,
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
          ),
        ),
      ],
    );
  }

  void gotoPhotoSelectionPage(
      BuildContext contextmain,
      BuildContext context,
      NavigationProvider provider,
      int minPhoto,
      int maxPhoto,
      bool layout) async {
    List imageList;
    var result = null;
    result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NewPhotoSelction(contextmain, minPhoto,
              maxPhoto, "", "", "", "", "", "postercustomization")),
    );

    if (result != null) {
      imageList = result;
      if (layout) {
        provider.addImage(imageList);
      } else {
        if (imageList.length == 1) {
          provider.replaceImage(imageList[0]);
        } else {
          provider.addIMages(imageList);
          // print("result - " + result.toString());
        }
      }
    }
  }

  Widget getPhotoBookCustomItem2(BuildContext contextmain, BuildContext context,
      provider, model, int index) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.20 + 90,
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.20 + 32.8,
                    margin: EdgeInsets.only(bottom: 2),
                    decoration: (model["imageModel"].imageType.length > 1 &&
                            model["imageModel"].imageType[1] != "")
                        ? BoxDecoration(
                            image: DecorationImage(
                            image: Image.memory(
                                    base64Decode(model["imageModel"].base64[1]))
                                .image,
                            fit: BoxFit.cover,
                          ))
                        : BoxDecoration(color: MyColors.primaryColor),
                    child: (model["imageModel"].imageType.length > 1 &&
                            model["imageModel"].imageType[1] != "")
                        ? Center(
                            child: Container(
                              height: 40,
                              width: 40,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.7),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                                child: Center(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    onPressed: () async {
                                      editorKey = provider.editorKey;
                                      bool isCropped = false;
                                      if (model["imageModel"].iscroppeds[1] ==
                                          "true") {
                                        isCropped = true;
                                      } else {
                                        isCropped = false;
                                      }
                                      provider.width = provider.selected_width;
                                      provider.height =
                                          provider.selected_height;
                                      provider.openImageEdit(
                                          model["imageModel"].base64[1],
                                          isCropped,
                                          model["imageModel"].imageType[1],
                                          model["imageModel"].imageUrl[1],
                                          model["imageModel"].fileuriPath[1],
                                          model["imageModel"]
                                              .fileuriPathlowreso[1],
                                          "photobook",
                                          false,
                                          1);
                                      provider.setphotobookpagePostion(index);
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PhotoEdit(contextmain)),
                                      );
                                      if (result != null) {
                                        provider.updatePhotobookImage(result);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: GestureDetector(
                              onTap: () {
                                provider.addImageToLayout(
                                    model["layout_id"],
                                    index,
                                    model["imageModel"].imageType.isNotEmpty
                                        ? model["imageModel"].imageType.length
                                        : 0,
                                    1);
                                gotoPhotoSelectionPage(
                                    contextmain, context, provider, 1, 1, true);
                              },
                              child: Container(
                                height: 20,
                                width: 20,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.7),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ),
                                  child: Center(
                                    child: GestureDetector(
                                      child: Container(
                                        child: Icon(
                                          Icons.add,
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
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * 0.20 + 32.8,
                          margin: EdgeInsets.only(top: 2, right: 2),
                          decoration:
                              (model["imageModel"].imageType.length > 2 &&
                                      model["imageModel"].imageType[2] != "")
                                  ? BoxDecoration(
                                      image: DecorationImage(
                                      image: Image.memory(base64Decode(
                                              model["imageModel"].base64[2]))
                                          .image,
                                      fit: BoxFit.cover,
                                    ))
                                  : BoxDecoration(color: MyColors.primaryColor),
                          child: (model["imageModel"].imageType.length > 2 &&
                                  model["imageModel"].imageType[2] != "")
                              ? Center(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black.withOpacity(0.7),
                                        border: Border.all(
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                      ),
                                      child: Center(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          onPressed: () async {
                                            editorKey = provider.editorKey;
                                            bool isCropped = false;
                                            if (model["imageModel"]
                                                    .iscroppeds[2] ==
                                                "true") {
                                              isCropped = true;
                                            } else {
                                              isCropped = false;
                                            }
                                            provider.width =
                                                provider.selected_width;
                                            provider.height =
                                                provider.selected_height;
                                            provider.openImageEdit(
                                                model["imageModel"].base64[2],
                                                isCropped,
                                                model["imageModel"]
                                                    .imageType[2],
                                                model["imageModel"].imageUrl[2],
                                                model["imageModel"]
                                                    .fileuriPath[2],
                                                model["imageModel"]
                                                    .fileuriPathlowreso[2],
                                                "photobook",
                                                false,
                                                2);
                                            provider
                                                .setphotobookpagePostion(index);
                                            final result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PhotoEdit(contextmain)),
                                            );
                                            if (result != null) {
                                              provider
                                                  .updatePhotobookImage(result);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      provider.addImageToLayout(
                                          model["layout_id"],
                                          index,
                                          model["imageModel"]
                                                  .imageType
                                                  .isNotEmpty
                                              ? model["imageModel"]
                                                  .imageType
                                                  .length
                                              : 0,
                                          2);
                                      gotoPhotoSelectionPage(contextmain,
                                          context, provider, 1, 1, true);
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black.withOpacity(0.7),
                                          border: Border.all(
                                            width: 2,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                          ),
                                        ),
                                        child: Center(
                                          child: GestureDetector(
                                            child: Container(
                                              child: Icon(
                                                Icons.add,
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
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 2, left: 2),
                          decoration:
                              (model["imageModel"].imageType.length > 3 &&
                                      model["imageModel"].imageType[3] != "" &&
                                      model["imageModel"].base64.length > 3 &&
                                      model["imageModel"].base64[3] != null &&
                                      model["imageModel"].base64[3] != '')
                                  ? BoxDecoration(
                                      image: DecorationImage(
                                      image: Image.memory(base64Decode(
                                              model["imageModel"].base64[3]))
                                          .image,
                                      fit: BoxFit.cover,
                                    ))
                                  : BoxDecoration(color: MyColors.primaryColor),
                          child: (model["imageModel"].imageType.length > 3 &&
                                  model["imageModel"].imageType[3] != "")
                              ? Center(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black.withOpacity(0.7),
                                        border: Border.all(
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                      ),
                                      child: Center(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          onPressed: () async {
                                            editorKey = provider.editorKey;
                                            bool isCropped = false;
                                            if (model["imageModel"]
                                                    .iscroppeds[3] ==
                                                "true") {
                                              isCropped = true;
                                            } else {
                                              isCropped = false;
                                            }
                                            provider.width =
                                                provider.selected_width;
                                            provider.height =
                                                provider.selected_height;
                                            provider.openImageEdit(
                                                model["imageModel"].base64[3],
                                                isCropped,
                                                model["imageModel"]
                                                    .imageType[3],
                                                model["imageModel"].imageUrl[3],
                                                model["imageModel"]
                                                    .fileuriPath[3],
                                                model["imageModel"]
                                                    .fileuriPathlowreso[3],
                                                "photobook",
                                                false,
                                                3);
                                            provider
                                                .setphotobookpagePostion(index);
                                            final result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PhotoEdit(contextmain)),
                                            );
                                            if (result != null) {
                                              provider
                                                  .updatePhotobookImage(result);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      provider.addImageToLayout(
                                          model["layout_id"],
                                          index,
                                          model["imageModel"]
                                                  .imageType
                                                  .isNotEmpty
                                              ? model["imageModel"]
                                                  .imageType
                                                  .length
                                              : 0,
                                          3);
                                      gotoPhotoSelectionPage(contextmain,
                                          context, provider, 1, 1, true);
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black.withOpacity(0.7),
                                          border: Border.all(
                                            width: 2,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                          ),
                                        ),
                                        child: Center(
                                          child: GestureDetector(
                                            child: Container(
                                              child: Icon(
                                                Icons.add,
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
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(8),
            height: MediaQuery.of(context).size.height * 0.20 + 35,
            decoration: (model["imageModel"].imageType.length > 0 &&
                    model["imageModel"].imageType[0] != "")
                ? BoxDecoration(
                    image: DecorationImage(
                    image: Image.memory(
                            base64Decode(model["imageModel"].base64[0]))
                        .image,
                    fit: BoxFit.cover,
                  ))
                : BoxDecoration(color: MyColors.primaryColor),
            child: (model["imageModel"].imageType.length > 0 &&
                    model["imageModel"].imageType[0] != "")
                ? Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.7),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                            onPressed: () async {
                              editorKey = provider.editorKey;
                              bool isCropped = false;
                              if (model["imageModel"].iscroppeds[0] == "true") {
                                isCropped = true;
                              } else {
                                isCropped = false;
                              }
                              provider.width = provider.selected_width;
                              provider.height = provider.selected_height;
                              provider.openImageEdit(
                                  model["imageModel"].base64[0],
                                  isCropped,
                                  model["imageModel"].imageType[0],
                                  model["imageModel"].imageUrl[0],
                                  model["imageModel"].fileuriPath[0],
                                  model["imageModel"].fileuriPathlowreso[0],
                                  "photobook",
                                  false,
                                  0);
                              provider.setphotobookpagePostion(index);
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PhotoEdit(contextmain)),
                              );
                              if (result != null) {
                                provider.updatePhotobookImage(result);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: GestureDetector(
                      onTap: () {
                        provider.addImageToLayout(
                            model["layout_id"],
                            index,
                            model["imageModel"].imageType.isNotEmpty
                                ? model["imageModel"].imageType.length
                                : 0,
                            0);
                        gotoPhotoSelectionPage(
                            contextmain, context, provider, 1, 1, true);
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.7),
                            border: Border.all(
                              width: 2,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          child: Center(
                            child: GestureDetector(
                              child: Container(
                                child: Icon(
                                  Icons.add,
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
          ),
        ),
      ],
    );
  }

  Widget getPhotoBookCustomItem3(
      BuildContext contextmain,
      BuildContext context,
      provider,
      model,
      int index,
      GlobalKey<ExtendedImageEditorState> editorKey) {
    String base64 = model["imageModel"].base64[0].toString();
    String base641 = model["imageModel"].base64[1].toString();
    return Row(
      children: [
        Expanded(
            child: Container(
          width: MediaQuery.of(context).size.width * 0.20,
          margin: const EdgeInsets.all(8),
          child: Stack(
            children: [
              Container(
                // width: MediaQuery.of(context).size.width * 0.35,
                decoration: (model["imageModel"].imageType.length > 0 &&
                        model["imageModel"].imageType[0] != "")
                    ? BoxDecoration(
                        image: DecorationImage(
                        image: Image.memory(base64Decode(base64)).image,
                        fit: BoxFit.cover,
                      ))
                    : BoxDecoration(color: MyColors.primaryColor),
                // height: provider.selected_height*10,
                child: (model["imageModel"].imageType.length > 0 &&
                        model["imageModel"].imageType[0] != "")
                    ? Center(
                        child: Container(
                          height: 40,
                          width: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.7),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  // Left side image
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                onPressed: () async {
                                  editorKey = provider.editorKey;
                                  bool isCropped = false;
                                  if (model["imageModel"].iscroppeds[0] ==
                                      "true") {
                                    isCropped = true;
                                  } else {
                                    isCropped = false;
                                  }
                                  provider.width = provider.selected_width;
                                  provider.height = provider.selected_height;
                                  provider.openImageEdit(
                                      model["imageModel"].base64[0],
                                      isCropped,
                                      model["imageModel"].imageType[0],
                                      model["imageModel"].imageUrl[0],
                                      model["imageModel"].fileuriPath[0],
                                      model["imageModel"].fileuriPathlowreso[0],
                                      "photobook",
                                      false,
                                      0);
                                  provider.setphotobookpagePostion(index);
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PhotoEdit(contextmain)),
                                  );
                                  if (result != null) {
                                    provider.updatePhotobookImage(result);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: GestureDetector(
                          onTap: () {
                            provider.addImageToLayout(
                                model["layout_id"],
                                index,
                                model["imageModel"].imageType.isNotEmpty
                                    ? model["imageModel"].imageType.length
                                    : 0,
                                0);
                            gotoPhotoSelectionPage(
                                contextmain, context, provider, 1, 1, true);
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.7),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                              child: Center(
                                child: GestureDetector(
                                  child: Container(
                                    child: Icon(
                                      Icons.add,
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
              ),
            ],
          ),
        )),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(8),
            decoration: (model["imageModel"].imageType.length > 1 &&
                    model["imageModel"].imageType[1] != "")
                ? BoxDecoration(
                    image: DecorationImage(
                    image: Image.memory(base64Decode(base641)).image,
                    fit: BoxFit.cover,
                  ))
                : BoxDecoration(color: MyColors.primaryColor),
            height: MediaQuery.of(context).size.height * 0.20 + 35,
            child: (model["imageModel"].imageType.length > 1 &&
                    model["imageModel"].imageType[1] != "")
                ? Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.7),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              // Right side Image
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                            onPressed: () async {
                              editorKey = provider.editorKey;
                              bool isCropped = false;
                              if (model["imageModel"].iscroppeds[1] == "true") {
                                isCropped = true;
                              } else {
                                isCropped = false;
                              }
                              provider.width = provider.selected_width;
                              provider.height = provider.selected_height;
                              provider.openImageEdit(
                                  model["imageModel"].base64[1],
                                  isCropped,
                                  model["imageModel"].imageType[1],
                                  model["imageModel"].imageUrl[1],
                                  model["imageModel"].fileuriPath[1],
                                  model["imageModel"].fileuriPathlowreso[1],
                                  "photobook",
                                  false,
                                  1);
                              provider.setphotobookpagePostion(index);
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PhotoEdit(contextmain)),
                              );
                              if (result != null) {
                                provider.updatePhotobookImage(result);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: GestureDetector(
                      onTap: () {
                        provider.addImageToLayout(
                            model["layout_id"],
                            index,
                            model["imageModel"].imageType.isNotEmpty
                                ? model["imageModel"].imageType.length
                                : 0,
                            1);
                        gotoPhotoSelectionPage(
                            contextmain, context, provider, 1, 1, true);
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.7),
                            border: Border.all(
                              width: 2,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          child: Center(
                            child: GestureDetector(
                              child: Container(
                                child: Icon(
                                  Icons.add,
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
          ),
        ),
      ],
    );
  }
}

class PhotoBookPerviewPage extends StatelessWidget {
  List imagelist;
  List itemList;
  String categorytype;
  int max_photo;
  int min_photo;
  int creation_id;
  String product_id;
  String product_price;
  String selectedSize;
  String product_name;
  String slovaktitle;
  BuildContext contextmain;

  PhotoBookPerviewPage(
      this.contextmain,
      this.imagelist,
      this.itemList,
      this.product_id,
      this.categorytype,
      this.max_photo,
      this.min_photo,
      this.product_price,
      this.selectedSize,
      this.product_name,
      this.slovaktitle,
      this.creation_id);
  @override
  Widget build(BuildContext context) {
    return InnerPhotoBookPerviewPage(
        contextmain,
        imagelist,
        itemList,
        product_id,
        categorytype,
        max_photo,
        min_photo,
        product_price,
        selectedSize,
        product_name,
        slovaktitle,
        creation_id);
  }
}

class InnerPhotoBookPerviewPage extends StatefulWidget {
  List imagelist;
  List itemList;
  String categorytype;
  int max_photo;
  int min_photo;
  int creation_id;
  String product_id;
  String product_price;
  String selectedSize;
  String product_name;
  String slovaktitle;
  BuildContext contextmain;
  InnerPhotoBookPerviewPage(
      this.contextmain,
      this.imagelist,
      this.itemList,
      this.product_id,
      this.categorytype,
      this.max_photo,
      this.min_photo,
      this.product_price,
      this.selectedSize,
      this.product_name,
      this.slovaktitle,
      this.creation_id);
  @override
  _InnerPhotoBookPerviewPageState createState() =>
      _InnerPhotoBookPerviewPageState(
          contextmain,
          imagelist,
          itemList,
          product_id,
          categorytype,
          max_photo,
          min_photo,
          product_price,
          selectedSize,
          product_name,
          slovaktitle,
          creation_id);
}

class _InnerPhotoBookPerviewPageState extends State<InnerPhotoBookPerviewPage>
    with SingleTickerProviderStateMixin {
  late List imagelist;
  late String product_id;
  late String product_price;
  late String selectedSize;
  late BuildContext contextmain;
  late String product_name;
  late List itemList;
  late String categorytype;
  late int max_photo;
  late int min_photo;
  late int creation_id;
  late String slovaktitle;
  _InnerPhotoBookPerviewPageState(
      this.contextmain,
      this.imagelist,
      this.itemList,
      this.product_id,
      this.categorytype,
      this.max_photo,
      this.min_photo,
      this.product_price,
      this.selectedSize,
      this.product_name,
      this.slovaktitle,
      this.creation_id);
  late AnimationController _controller;
  late Animation _animation;
  late AnimationController _controller1;
  late Animation _animation1;
  bool check = false;

  Future<void> changeorentation() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    PaintingBinding.instance!.imageCache!.clear();
    PaintingBinding.instance!.imageCache!.clearLiveImages();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    //_controller.dispose();
    super.dispose();
  }

  String imageloadingstate = "";
  checkImageState(String imagestate) {
    imageloadingstate = imagestate;
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

  Widget perviewPageCustomItem3(
      BuildContext context, provider, model, int index, fulllist) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      // width: MediaQuery.of(context).size.height,
      // width: (((MediaQuery.of(context).size.width * 0.20)*2)+10)/2,
      child: Row(
        children: [
          Container(
              // width: (((MediaQuery.of(context).size.width * 0.20)*2)+110)/2-10,
              width: MediaQuery.of(context).size.height / 2 - 5,
              child: AnimatedOpacity(
                opacity: provider.fade_in_out ? 1.0 : 0.0,
                duration: Duration(milliseconds: 250),
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child:
                      // Stack(
                      //   children: [
                      Container(
                    // width: (((MediaQuery.of(context).size.width * 0.20)*2)+110)/2-10,
                    width: MediaQuery.of(context).size.height / 2 - 5,
                    decoration: model["imageModel"].imageType.isNotEmpty
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: Image.memory(base64Decode(
                                      model["imageModel"].base64[0]))
                                  .image,
                              fit: BoxFit.cover,
                            ),
                          )
                        : BoxDecoration(color: MyColors.primaryColor),
                    // height: MediaQuery.of(context).size.height,
                    // width: MediaQuery.of(context).size.height,
                  ),
                  //   ],
                  // ),
                ),
              )),
          Container(
            // width: (((MediaQuery.of(context).size.width * 0.20)*2)+110)/2-10,
            width: MediaQuery.of(context).size.height / 2 - 5,
            child: AnimatedOpacity(
              opacity: provider.fade_in_out ? 1.0 : 0.0,
              duration: Duration(milliseconds: 250),
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: model["imageModel"].imageType.length > 1
                    ? BoxDecoration(
                        image: DecorationImage(
                          image: Image.memory(
                                  base64Decode(model["imageModel"].base64[1]))
                              .image,
                          fit: BoxFit.cover,
                        ),
                      )
                    : BoxDecoration(color: MyColors.primaryColor),
                // height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.height,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int count = 0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    if (count == 0) {
      count++;
      provider.addItemSS(
          imagelist,
          itemList,
          product_price,
          selectedSize,
          product_name,
          slovaktitle,
          product_id,
          categorytype,
          min_photo,
          max_photo,
          creation_id);
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

    Widget perviewPageCustomItem1(
        BuildContext context, provider, model, int index, fulllist) {
      return Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Row(children: [
          Expanded(
            child: AnimatedOpacity(
              opacity: provider.fade_in_out ? 1.0 : 0.0,
              duration: Duration(milliseconds: 250),
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: model["imageModel"].imageType.isNotEmpty
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: Image.memory(
                                  base64Decode(model["imageModel"].base64[0]))
                              .image,
                          fit: BoxFit.cover,
                        ),
                      )
                    : BoxDecoration(
                        shape: BoxShape.circle, color: MyColors.primaryColor),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
              ),
            ),
          ),
          Expanded(
              child: AnimatedOpacity(
                  opacity: provider.fade_in_out ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 250),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: (model["imageModel"].imageType.length > 1 &&
                            model["imageModel"].imageType[1].isNotEmpty)
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: Image.memory(base64Decode(
                                      model["imageModel"].base64[1]))
                                  .image,
                              fit: BoxFit.cover,
                            ),
                          )
                        : BoxDecoration(
                            shape: BoxShape.circle,
                            color: MyColors.primaryColor),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.height,
                  )))
        ]),
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            Languages.of(contextmain)!.Page +
                (provider.currentNumber - 1).toString() +
                "-" +
                provider.currentNumber.toString() +
                Languages.of(contextmain)!.oF +
                (provider.getItems.length * 2).toString(),
            style: TextStyle(color: Colors.white70, fontSize: 20),
          ),
          actions: [
            // Text("Add To Cart",style: TextStyle(color: Colors.white70,),)
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  child: ExtendedImage.memory(
                base64Decode(provider.updateimagepathbase64),
                fit: BoxFit.contain,
                cacheRawData: true,
                clearMemoryCacheWhenDispose: true,
                height: 200,
                width: 200,
                mode: ExtendedImageMode.editor,
                enableLoadState: true,
                extendedImageEditorKey: provider.cropKey,
                loadStateChanged: (ExtendedImageState state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.loading:
                      {
                        provider.checkImageState("loading");
                        break;
                      }
                    case LoadState.completed:
                      provider.checkImageState("complete");
                      // TODO: Handle this case.
                      break;
                    case LoadState.failed:
                      provider.checkImageState("failed");
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
                      cropAspectRatio: provider.width / provider.height);
                },
              )),
              Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      // alignment: Alignment.center,
                      // width: ((MediaQuery.of(context).size.height)*2),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                provider.deacreasePerviewPagePostion();
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(52, 0, 16, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Card(
                                      color: Colors.white70,
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.white70, width: 1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Icon(
                                        Icons.arrow_back,
                                        size: 25,
                                        color: MyColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    // Left side text
                                    Languages.of(contextmain)!.Gotopage +
                                        (provider.previousNumber - 1)
                                            .toString() +
                                        "-" +
                                        provider.previousNumber.toString(),
                                    // "",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: MyColors.primaryColor,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          provider.getItems.length > 0
                              ?
                              // Expanded(
                              //   child:
                              Container(
                                  width: MediaQuery.of(context).size.height,
                                  // width: ((MediaQuery.of(context).size.width * 0.20)*2)+110,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  padding: const EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: MyColors.primaryColor,
                                          width: 5)),
                                  child: case2(
                                    provider.getItems[provider
                                        .perview_page_position]["layout_id"],
                                    {
                                      "1": perviewPageCustomItem1(
                                          context,
                                          provider,
                                          provider.getItems[
                                              provider.perview_page_position],
                                          provider.perview_page_position,
                                          provider.getItems),
                                      "2": perviewPageCustomItem2(
                                          context,
                                          provider,
                                          provider.getItems[
                                              provider.perview_page_position],
                                          provider.perview_page_position,
                                          provider.getItems),
                                      "3": perviewPageCustomItem3(
                                          context,
                                          provider,
                                          provider.getItems[
                                              provider.perview_page_position],
                                          provider.perview_page_position,
                                          provider.getItems),
                                    },
                                    perviewPageCustomItem3(
                                        context,
                                        provider,
                                        provider.getItems[
                                            provider.perview_page_position],
                                        provider.perview_page_position,
                                        provider.getItems),
                                  ),
                                  // ),
                                )
                              : Container(),
                          GestureDetector(
                            onTap: () {
                              provider.increasePerviewPagePostion();
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(16, 0, 52, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Card(
                                    color: Colors.white70,
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white70, width: 1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        size: 25,
                                        color: MyColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    Languages.of(contextmain)!.Gotopage +
                                        (provider.nextNumber - 1).toString() +
                                        "-" +
                                        provider.nextNumber.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: MyColors.primaryColor,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    // provider.base64String != null ? Container(child: Image.memory(base64Decode(provider.base64String)),): Container(child: Text("Base64 Image"),),
                    RepaintBoundary(
                      key: provider.globalKey,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
                        child: Container(
                            height: 45.0,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ElevatedButton(
                              child: provider.boolerror
                                  ? Text(
                                      "error! Try again",
                                    )
                                  : provider.addcart
                                      ? Center(
                                          child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              provider
                                                  .stringUploadingImageCount,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            SizedBox(
                                              width: 32,
                                            ),
                                            CircularProgressIndicator(
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(Colors.white),
                                            )
                                          ],
                                        ))
                                      : Text(
                                          // Add to cart Preview page
                                          Languages.of(contextmain)!.AddtoCart,
                                          // "",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18)),
                              style: ElevatedButton.styleFrom(
                                primary: MyColors.primaryColor,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                ),
                                side: BorderSide(color: MyColors.primaryColor),
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                provider.addtocart(contextmain, context);
                              },
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget perviewPageCustomItem2(
      BuildContext context, provider, model, int index, fulllist) {
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

    return Container(
      // height: MediaQuery.of(context).size.height,
      height: MediaQuery.of(context).size.height / 2,
      child: Row(
        children: [
          Expanded(
            child: AnimatedOpacity(
              opacity: provider.fade_in_out ? 1.0 : 0.0,
              duration: Duration(milliseconds: 250),
              child: Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.height,
                        margin: EdgeInsets.only(bottom: 2),
                        decoration: (model["imageModel"].imageType.length > 1 &&
                                model["imageModel"].imageType[1].isNotEmpty)
                            ? BoxDecoration(
                                image: DecorationImage(
                                  image: Image.memory(base64Decode(
                                          model["imageModel"].base64[1]))
                                      .image,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : BoxDecoration(color: MyColors.primaryColor),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.height,
                              margin: EdgeInsets.only(top: 2, right: 2),
                              decoration: (model["imageModel"]
                                              .imageType
                                              .length >
                                          2 &&
                                      model["imageModel"]
                                          .imageType[2]
                                          .isNotEmpty)
                                  ? BoxDecoration(
                                      image: model["imageModel"]
                                                  .iscroppeds[2] ==
                                              "true"
                                          ?
                                          // FileImage(File(model["imageModel"].fileuriPathlowreso[2]))
                                          DecorationImage(
                                              image: Image.memory(base64Decode(
                                                      model["imageModel"]
                                                          .base64[2]))
                                                  .image,
                                              fit: BoxFit.cover,
                                            )
                                          : DecorationImage(
                                              image: Image.memory(base64Decode(
                                                      model["imageModel"]
                                                          .base64[2]))
                                                  .image,
                                              fit: BoxFit.cover,
                                            ),
                                    )
                                  : BoxDecoration(color: MyColors.primaryColor),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.height,
                              margin: EdgeInsets.only(top: 2, left: 2),
                              decoration: (model["imageModel"]
                                              .imageType
                                              .length >
                                          3 &&
                                      model["imageModel"]
                                          .imageType[3]
                                          .isNotEmpty)
                                  ? BoxDecoration(
                                      image: DecorationImage(
                                        image: Image.memory(base64Decode(
                                                model["imageModel"].base64[3]))
                                            .image,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : BoxDecoration(color: MyColors.primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: AnimatedOpacity(
              opacity: provider.fade_in_out ? 1.0 : 0.0,
              duration: Duration(milliseconds: 250),
              child: Container(
                margin: EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height,
                decoration: model["imageModel"].imageType.isNotEmpty
                    ? BoxDecoration(
                        image: DecorationImage(
                          image: Image.memory(
                                  base64Decode(model["imageModel"].base64[0]))
                              .image,
                          fit: BoxFit.cover,
                        ),
                      )
                    : BoxDecoration(color: MyColors.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
