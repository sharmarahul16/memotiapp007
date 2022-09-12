// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_editor/image_editor.dart';
import 'package:memotiapp/pages/photo_edit.dart';
import 'package:memotiapp/pages/products/newphotoselection.dart';
import 'package:memotiapp/pages/products/poster.dart';
import 'package:memotiapp/provider/database.dart';
import 'package:provider/provider.dart';
import 'package:memotiapp/provider/appaccess.dart';
import 'package:memotiapp/provider/statics.dart';
import 'package:memotiapp/localization/language/languages.dart';
import 'package:memotiapp/localization/locale_constant.dart';
import 'dart:ui' as ui;

class CanvasPage extends StatefulWidget {
  CanvasPage({Key? key}) : super(key: key);

  @override
  _CanvasPageState createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  @override
  Widget build(BuildContext context) {
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

class CanvasDetailPage extends StatelessWidget {
  CanvasDetailPage();
  @override
  Widget build(BuildContext context) {
    return InnerCanvasDetailPage();
  }
}

// ignore: must_be_immutable
class InnerCanvasDetailPage extends StatelessWidget {
  late List<String> images;
  InnerCanvasDetailPage();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    images = [];
    provider.passtoProvidercanvas(provider.selectedproduct[0], "canvas");
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
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          // SvgPicture.asset(
                                          //   "assets/icon/icon_testingyourcreativity.svg",
                                          Image.asset(
                                            "assets/image-folder/icon_testingyourcreativity.png",
                                            height: 30.0,
                                            width: 30.0,
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                            width: 8.0,
                                          ),
                                          Text(
                                            Languages.of(context)!
                                                .TestingYourCreativity,
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
                                          15.0, 16.0, 0.0, 16.0),
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
                                            //   "assets/icon/icon_feelinglike.svg",
                                            Image.asset(
                                              "assets/image-folder/icon_feelinglike.png",
                                              height: 30.0,
                                              width: 30.0,
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                              width: 8.0,
                                            ),
                                            Text(
                                              Languages.of(context)!
                                                  .FeelingLikeAnArtCollector,
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
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Row(
                                        children: [
                                          // SvgPicture
                                          // SvgPicture.asset(
                                          //   "assets/icon/icon_bringingyour.svg",
                                          Image.asset(
                                            "assets/image-folder/icon_bringingyour.png",
                                            height: 30.0,
                                            width: 29.0,
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                            width: 8.0,
                                          ),
                                          Text(
                                            Languages.of(context)!
                                                .BringingYourHallwayToLife,
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
                                          15.0, 16.0, 0.0, 16.0),
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
                                            width: 29.0,
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                            width: 8.0,
                                          ),
                                          Text(
                                            Languages.of(context)!
                                                .GiftingSomeoneoflove,
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
                                  Text(
                                    String.fromCharCodes(new Runes("\u27A4  ")),
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
                                    String.fromCharCodes(new Runes("\u27A4  ")),
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
                                            .Possibiltytochooseprintingtoedgeorprintingovertheedge,
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
                                    String.fromCharCodes(new Runes("\u27A4  ")),
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
                                            .Ifprintingedgethanpossibiltytochoosecanvasbackgroundcolor,
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
                              SizedBox(
                                height: 30.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  Languages.of(context)!
                                      .Weguaranteeaqualityservisenmaximumprotectingduringtransportifyourcanvasarrivesdamagedwellreprintitforyou,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
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
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: MyColors.primaryColor,
                            onPressed: () {
                              // String id = provider.product["detail"]["ii"].toString();
                              // MemotiDbProvider.db.getCreationswithid(id).then((value) {
                              //   print("photobook creation list");
                              //   print(value);
                              //   print(value.length);
                              //   if(value.length>0){
                              //     provider.creationsingleprojectList = value;
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(builder: (context) => CreationSingleProductList()),);
                              //   }else{
                              provider.artistApiCall = false;
                              // provider.isGooglemediaitemGet = false;
                              if (provider.isGoogleLoggedIn) {
                                provider.listGoogleMediaItem = [];
                                provider.isgoogleLoading = false;
                                provider.listmediaItem("");
                              }
                              //provider.googleSignIn();
                              provider.setTab(0);
                              provider.fromcanvasdetail = true;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NewphotoselectionPage("canvas")),
                              );
                              // }

                              // });
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

// ignore: must_be_immutable
class CanvasSizeSelectionsPage extends StatelessWidget {
  List imageList;
  BuildContext contextmain;
  // ignore: non_constant_identifier_names
  int creation_id;
  String categorytype;

  CanvasSizeSelectionsPage(
      this.imageList, this.contextmain, this.creation_id, this.categorytype);

  @override
  Widget build(BuildContext context) {
    return CanvasSizeSelectionPage(
        imageList, contextmain, creation_id, categorytype);
  }
}

// ignore: must_be_immutable
class CanvasSizeSelectionPage extends StatefulWidget {
  List imageList;
  BuildContext contextmain;
  // ignore: non_constant_identifier_names
  int creation_id;
  String categorytype;

  CanvasSizeSelectionPage(
      this.imageList, this.contextmain, this.creation_id, this.categorytype);
  @override
  _CanvasSizeSelectionPage createState() => _CanvasSizeSelectionPage(
      this.imageList, this.contextmain, this.creation_id, this.categorytype);
}

class _CanvasSizeSelectionPage extends State<CanvasSizeSelectionPage> {
  List imageList;
  BuildContext contextmain;
  // ignore: non_constant_identifier_names
  int creation_id;
  String categorytype;
  _CanvasSizeSelectionPage(
      this.imageList, this.contextmain, this.creation_id, this.categorytype);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    PaintingBinding.instance!.imageCache?.clear();
    PaintingBinding.instance!.imageCache?.clearLiveImages();
    super.dispose();
  }

  final GlobalKey _globalKey = GlobalKey();
  final GlobalKey<ExtendedImageEditorState> editorKey =
  GlobalKey<ExtendedImageEditorState>();

  //ExtendedImageCropLayerCornerPainter _cornerPainter;

  Widget withoutAppBar1() {
    return AppBar(
      backgroundColor: Colors.black.withOpacity(0.8),
      leading: Icon(
        Icons.arrow_back,
        color: Colors.black.withOpacity(0.8),
      ),
    );
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
            provider.closedImageFilterCanvas();
          } else if (provider.istextFormatting == 1) {
            provider.closedtextformatting();
          } else if (provider.istextFormatting == 3) {
            provider.cloedimagetextediting();
          }
        },
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: provider.istextFormatting != 3
          ? InkWell(
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
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      )
          : Container(),
      actions: provider.istextFormatting == 3
          ? <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: provider.istextFormatting == 3
                ? Container()
                : SizedBox(
                width: 80.0,
                child: IconButton(
                  icon: Text(
                    Languages.of(contextmain)!.Save,
                    style:
                    TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onPressed: () {
                    provider.removeIMage();
                    provider.closedTextEditor();
                    provider
                        .updateCanvasImage(provider.texteditIMage);
                  },
                ))),
      ]
          : null,
    );
  }

  Widget mainAppBar(BuildContext context, NavigationProvider provider) {
    return AppBar(
      backgroundColor: MyColors.primaryColor,
      // Back button
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          print(categorytype);
          if (categorytype != "cart") {
            provider.addcreation(context);
          } else if (categorytype == "cart") {
            // provider.gototabs();
            Navigator.of(context, rootNavigator: true).pop();
            // Navigator.pop(context, false);
            // Navigator.of(context).pop();
          } else {
            Navigator.of(context, rootNavigator: true).pop(context);
            // Navigator.pop(context, false);
            // Navigator.of(context).pop();
          }
        },
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        Languages.of(contextmain)!.Canvas,
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),
      ),
    );
  }

  int count = 0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    if (count == 0) {
      count++;
      provider.addCanvasData(imageList, contextmain, creation_id, categorytype);
      //provider.selected_image = imageList[0].thumbDataWithSize;
    }
    // print("provider.selcted_image_base64");
    // print(provider.selcted_image_base64);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: provider.istextFormatting == 0
              ? mainAppBar(context, provider)
              : withoutAppBar(context, provider)),
      body: Stack(
        children: [
          Container(
            child: !provider.imageupdate
                ? Container()
                : provider.type == "phone"
                ? ExtendedImage.file(
              new File(provider.updateimagepath),
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
                      break;
                    }
                  case LoadState.completed:
                    provider.checkImageState("complete");
                    break;
                  case LoadState.failed:
                    provider.checkImageState("failed");
                    break;
                }
                return null;
              },
              initEditorConfigHandler: (state) {
                return EditorConfig(
                    maxScale: 8.0,
                    cropRectPadding: const EdgeInsets.all(0.0),
                    hitTestSize: 20.0,
                    initCropRectType: InitCropRectType.layoutRect,
                    cropAspectRatio:
                    provider.width / provider.height);
              },
            )
                : ExtendedImage.network(
              provider.updateimagepath,
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
                      break;
                    }
                  case LoadState.completed:
                    provider.checkImageState("complete");
                    break;
                  case LoadState.failed:
                    provider.checkImageState("failed");
                    break;
                }
                return null;
              },
              initEditorConfigHandler: (state) {
                return EditorConfig(
                    maxScale: 8.0,
                    cropRectPadding: const EdgeInsets.all(0.0),
                    hitTestSize: 20.0,
                    initCropRectType: InitCropRectType.layoutRect,
                    cropAspectRatio:
                    provider.width / provider.height);
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: double.infinity,
                      color: HexColor("F0F0F2"),
                      child: Center(
                        child: Container(
                          child: Stack(
                            children: [
                              Container(
                                child: Card(
                                  elevation: 7,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: provider.width,
                                    height: provider.height,
                                    color: HexColor("D5D6D8"),
                                  ),
                                ),
                              ),
                              Container(

                                child: Text (
                                  provider.price + ' \u{20AC}',
                                  style: TextStyle(
                                    color: MyColors.textColor,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                      )),
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
                        bool isSelected =
                        provider.dimensions[index]["isSelected"];
                        String size =
                        provider.dimensions[index]["sizeInString"];
                        String price =
                        double.parse(provider.dimensions[index]["price"])
                            .toStringAsFixed(2);
                        return GestureDetector(
                            onTap: () => provider.changeCanvasDimension(index),
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    width: 120,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: isSelected
                                            ? MyColors.primaryColor
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
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
                  drawLine(context),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 16.0),
                    child: Container(
                      height: 45.0,
                      width: MediaQuery.of(context).size.width * 1.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: MyColors.primaryColor,
                        onPressed: () {
                          print("cgvhghjk");
                          if (categorytype == "cart") {
                            print("2222222");
                            MemotiDbProvider.db.removecart(provider.cartIndex1);
                          }
                          if (creation_id != -1) {
                            print("233333333333");
                            MemotiDbProvider.db.removecreationItem(creation_id);
                          }
                          print("44444444444444444");
                          provider.addToCart(contextmain, context);
                        },
                        child: provider.boolerror
                            ? Text("error! Try again",
                            style: TextStyle(
                                color: Colors.white, fontSize: 14))
                            : provider.addcart
                            ? CircularProgressIndicator(
                          valueColor:
                          new AlwaysStoppedAnimation<Color>(
                              Colors.white),
                        )
                            : Text(
                          // "",
                            Languages.of(contextmain)!.AddtoCart,
                            style: TextStyle(
                                color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  )
                ],
              ),
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
          )
        ],
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
                                child: provider.selcted_image_type == "phone"
                                    ? Image.file(
                                  new File(provider.selcted_image),
                                  fit: BoxFit.cover,
                                )
                                    : provider.selcted_image_type == "memoti"
                                    ? CachedNetworkImage(
                                  imageUrl: provider.selcted_image,
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
                                /*Image.network(
                                            provider.selcted_image,
                                            fit: BoxFit.cover,
                                          )*/
                                    : CachedNetworkImage(
                                  imageUrl: provider.selcted_image +
                                      "=w400-h400-c",
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
                                /* Image.network(
                                            provider.selcted_image +
                                                "=w400-h400c",
                                            fit: BoxFit.cover,
                                          ),*/
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

  Widget drawLine(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0.0),
      child: Container(
        height: 1.0,
        width: MediaQuery.of(context).size.width * 1.0,
        color: Colors.grey,
      ),
    );
  }

  Widget getSubHeader(String subheadTitle) {
    return Text(
      subheadTitle,
      style: TextStyle(
          color: MyColors.textColor, fontWeight: FontWeight.w600, fontSize: 16),
    );
  }

  // ignore: non_constant_identifier_names
  Widget AfterImageTextEdit(BuildContext contextmain,
      NavigationProvider provider, BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  margin: EdgeInsets.fromLTRB(20, 12, 20, 0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: MemoryImage(
                          provider.texteditIMage,
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                //imageFilterFirstWidget(provider, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageFilterWidget(BuildContext contextmain,
      NavigationProvider provider, BuildContext context) {
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageFilterFirstWidget(
      NavigationProvider provider, BuildContext context) {
    return Stack(
      children: [
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

  Future<void> convertImageToCropImage(NavigationProvider provider) async {
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

    provider.updateCanvasImage(result!);
    print("heheh" + result.toString());
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
    print("heheh" + result.toString());
  }

  void flip() {
    editorKey.currentState!.flip();
  }

  void rotate(bool right) {
    editorKey.currentState!.rotate(right: right);
  }

  void convertWidgetToImage(NavigationProvider provider) async {
    RenderRepaintBoundary? repaintBoundary =
    _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
    ui.Image boxImage = await repaintBoundary!.toImage(pixelRatio: 1);
    ByteData? byteData =
    await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8list = byteData!.buffer.asUint8List();
    provider.updateCanvasImage(uint8list);
    print("heheh" + uint8list.toString());
  }

  // ignore: non_constant_identifier_names
  Widget ImageFilterfourthWidegt(
      NavigationProvider provider, BuildContext context) {
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
          child: Text(Languages.of(contextmain)!.Done,
              style: TextStyle(
                  letterSpacing: 2,
                  wordSpacing: 2,
                  color: Colors.white,
                  fontSize: 18)),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ImagecropfourthWidegt(
      NavigationProvider provider, BuildContext context) {
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
          child: Text(Languages.of(contextmain)!.Done,
              style: TextStyle(
                  letterSpacing: 2,
                  wordSpacing: 2,
                  color: Colors.white,
                  fontSize: 18)),
        ),
      ),
    );
  }

  Widget imageSecondWidget(
      contextmain, NavigationProvider provider, BuildContext context) {
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
}

Widget imageFilterThirdWidget(BuildContext contextmain,
    NavigationProvider provider, BuildContext context) {
  List<ImageFilterModel> list = provider.filterList;
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
          return FilterItemList(provider, index, context, list[index], 'phone',
              list[index].name, list[index].isSelected, list[index].filter);
          // return Container();
        }),
  );
}

Widget imageFilterThirdWidgetUrl(BuildContext contextmain,
    NavigationProvider provider, BuildContext context) {
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

Widget imagerotateThirdWidget(
    BuildContext contextmain,
    NavigationProvider provider,
    BuildContext context,
    GlobalKey<ExtendedImageEditorState> editorKey) {
  return Container(
    margin: EdgeInsets.fromLTRB(12, 8, 12, 0),
    height: 100,
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
                  onPressed: () => editorKey.currentState.rotate(right: false),48

                  z
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
                              // provider.changeEditTextPostion(value)
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

              /*  SizedBox(
                height: 16,
              ),
              fourthWidegt(contextmain, provider, context),*/
            ],
          ),
        ),
      ),
    ),
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
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => NewPhotoSelction(contextmain, minPhoto, maxPhoto,
            "", "", "", "", "", "canvascustomization")),
  );

  if (result != null) {
    imageList = result;
    provider.replaceImage(imageList[0]);
  }
}

Widget fourthWidegt(BuildContext contextmain, NavigationProvider provider,
    BuildContext context) {
  return Container(
    padding: EdgeInsets.fromLTRB(0.0, 36.0, 0.0, 0.0),
    child: Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width * 1.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: MyColors.primaryColor,
        onPressed: () => provider.closedtextformatting(),
        child: Text(Languages.of(contextmain)!.Done,
            style: TextStyle(
                letterSpacing: 2,
                wordSpacing: 2,
                color: Colors.white,
                fontSize: 18)),
      ),
    ),
  );
}

Widget thirdWidget(BuildContext contextmain, NavigationProvider provider,
    BuildContext context) {
  return Container(
      child: Column(
        children: [
          //   Container(
          //     padding: EdgeInsets.only(left: 10),
          //     color: Colors.white,
          //     child: DropdownButton<String>(
          //     hint: Text(
          //       "Choose Text Position",
          //       style: TextStyle(
          //           fontSize: 6.0,
          //           fontWeight: FontWeight.bold,
          //           color: MyColors.textColor),
          //     ),
          //     dropdownColor: Colors.white,
          //     isExpanded: true,
          //     value: provider.selectedTextindex,
          //     onChanged: (String newValue) {
          //       print(newValue);
          //     },
          //     items: <String>["Top Left", "Top Center", "Top Right", "Center Left", "Center", "Center Right", "Bottom Left", "Bottom Center", "Bottom Right"]
          //         .map<DropdownMenuItem<String>>((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: Text(value),
          //       );
          //     }).toList(),
          //   ),
          // ),
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
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: provider.colortList.length,
        itemBuilder: (BuildContext ctx, int index) {
          return case2(what, {
            "text":
            TextColorItem(provider, index, ctx, provider.colortList[index]),
            "bg": BGColorItem(provider, index, ctx, provider.colortList[index]),
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
              onTap: () => provider.changeTextFormatSelectedTabColor(1),
              child: Container(
                child: Column(
                  children: [
                    Icon(
                      Icons.color_lens_sharp,
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
              onTap: () => provider.changeTextFormatSelectedTabColor(2),
              child: Container(
                child: Column(
                  children: [
                    Icon(
                      Icons.format_color_fill,
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

class TextColorItem extends StatelessWidget {
  final provider;
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
  final provider;
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
      // GestureDetector(
      //   onTap: () => provider.changeFilter(index),
      //   child: Container(
      //     margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
      //     child: Column(
      //       children: [
      //         Container(
      //           height: 80,
      //           width: 100,
      //           padding: EdgeInsets.fromLTRB(2, 2, 2, 4),
      //           child: Card(
      //             child: Container(
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(12),
      //                 border: Border.all(
      //                   width: 1,
      //                   color: isSelected ? Colors.white : Colors.grey,
      //                 ),
      //               ),
      //               child: ColorFiltered(
      //                 child: Image.file(
      //               new File(model.assetImage),
      //                   width: 80,
      //                   fit: BoxFit.cover,
      //                 ),
      //                 colorFilter: ColorFilter.matrix(filter),
      //               ),
      //             ),
      //           ),
      //         ),
      //         Text(
      //           name,
      //           style: TextStyle(color: Colors.white, fontSize: 14),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
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
                      /* Image.network(
                              imageUrl,
                              width: 80,
                              fit: BoxFit.cover,
                            )*/
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
                      /*Image.network(
                              imageUrl + "=w160-h160-c",
                              width: 80,
                              fit: BoxFit.cover,
                            ),*/
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

class CanvasAfterImageSelectionPage extends StatelessWidget {

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

  CanvasAfterImageSelectionPage(
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
    return InnerCanvasAfterImageSelectionPage(
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


class InnerCanvasAfterImageSelectionPage extends StatelessWidget {
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

  InnerCanvasAfterImageSelectionPage(
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




/*class DimensionItem extends StatelessWidget {
  final provider;
  int index;
  BuildContext context;
  DimensiomnModel dimension;

  DimensionItem(this.provider, this.index, this.context, this.dimension);

  @override
  Widget build(BuildContext context) {
    bool isSelected = dimension.isSelected;
    String size = dimension.sizeInString;
    String price = dimension.price;
    debugPrint("isSelected " + isSelected.toString());
    debugPrint("price " + price.toString());
    return GestureDetector(
        onTap: () => provider.changeDimension(index),
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                    color:
                    isSelected ? MyColors.primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:
                        isSelected ? MyColors.primaryColor : Colors.black,
                        width: 2,
                        style: BorderStyle.solid)),
                child: Text(
                  size,
                  style: TextStyle(
                      color: isSelected ? Colors.white : MyColors.textColor,
                      fontSize: 16),
                ),
              ),
              Text(
                price + ' \u{20AC}',
                style: TextStyle(
                    color: MyColors.textColor, fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ));
  }
}*/

/*class CanvasTypeItem extends StatelessWidget {
  final provider;
  int index;
  BuildContext context;
  CanvasType canvasType;

  CanvasTypeItem(this.provider, this.index, this.context, this.canvasType);

  @override
  Widget build(BuildContext context) {
    String assetImage = canvasType.assetImage;
    String name = canvasType.name;
    bool isSelected = canvasType.isSelected;
    debugPrint("isSelected " + isSelected.toString());
    return GestureDetector(
      onTap: () {
        provider.changeCanvasType(index);
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
              margin: EdgeInsets.only(left: 6),
              height: 74.0,
              child: Image.asset(
                assetImage,
                fit: BoxFit.cover,
              )),
          Icon(
            isSelected ? Icons.check_circle : null,
            color: MyColors.primaryColor,
          ),
        ],
      ),
    );
  }
}

class ThicknessItem extends StatelessWidget {
  final provider;
  int index;
  BuildContext context;
  CanvasThickness canvasThickness;

  ThicknessItem(this.provider, this.index, this.context, this.canvasThickness);

  @override
  Widget build(BuildContext context) {
    String name = canvasThickness.name;
    String sizeThickness = canvasThickness.sizeThickness;
    bool isSelected = canvasThickness.isSelected;
    debugPrint("isSelected " + isSelected.toString());
    return GestureDetector(
      onTap: () => provider.chnageThickness(index),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 120,
        height: 50,
        decoration: BoxDecoration(
            color: isSelected ? MyColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: isSelected ? MyColors.primaryColor : Colors.black,
                width: 2,
                style: BorderStyle.solid)),
        child: Center(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              sizeThickness + "cm",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : MyColors.textColor,
                  fontSize: 20),
            ),
          ),
        ), */ /*Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                sizeThickness,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : MyColors.textColor,
                    fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                name,
                style: TextStyle(
                    color: isSelected ? Colors.white : MyColors.textColor,
                    fontSize: 13,
                    height: 1.5),
              ),
            ),
          ],
        ),*/ /*
      ),
    );
  }
}

class ColorItem extends StatelessWidget {
  final provider;
  int index;
  BuildContext context;
  CustomColor1 customColor;

  ColorItem(this.provider, this.index, this.context, this.customColor);

  @override
  Widget build(BuildContext context) {
    bool isSelected = customColor.isSelected;
    Color itemColor = HexColor(customColor.color);
    return GestureDetector(
      onTap: () => provider.changeColor(index),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: itemColor,
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: isSelected ? MyColors.primaryColor : Colors.transparent,
          ),
        ),
      ),
    );
  }
}*/

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

