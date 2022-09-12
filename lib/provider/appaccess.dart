library my_prj.globals;

import 'dart:async';
import 'dart:io' as io;
// ignore: avoid_web_libraries_in_flutter
import 'package:async/async.dart';
import 'package:camera/camera.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'dart:ui';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_editor/image_editor.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/rendering.dart';
import 'package:camerawesome/models/orientations.dart';
import 'package:memotiapp/pages/account.dart';
import 'package:memotiapp/pages/products/newphotoselection.dart';
import 'package:path/path.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:memotiapp/pages/address.dart';
import 'package:memotiapp/pages/home.dart';
import 'package:memotiapp/pages/login.dart';
import 'package:memotiapp/pages/notfound.dart';
import 'package:memotiapp/pages/products/calendar.dart';
import 'package:memotiapp/pages/products/canvas.dart';
import 'package:memotiapp/pages/products/photobook.dart';
import 'package:memotiapp/pages/products/poster.dart';
import 'package:memotiapp/pages/tabs.dart';
import 'package:memotiapp/provider/statics.dart';
import 'package:memotiapp/pages/selectcategory.dart';
import 'package:memotiapp/provider/database.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import 'package:memotiapp/localization/language/languages.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
// import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:image/image.dart' as imgUtils;
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_insta/flutter_insta.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
// import 'package:flutter_stripe/flutter_stripe.dart';

class Constants {
  const Constants._();

  static GlobalKey pickerKey = GlobalKey();

  static SortPathDelegate sortPathDelegate = SortPathDelegate.common;

  static const int defaultGridThumbSize = 200;
}

class NavigationProvider with ChangeNotifier {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int _currentIndex = 0;
  var currentNavigation = "tabs";
  dynamic previousNavigation = [];
  dynamic theme;
  int previousNo = 0;
  var timer;
  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  bool connected = false;

  changeTabpagePosition(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Widget get getNavigation {
    if (currentNavigation == "tabs") {
      return TabsPage();
    } else if (currentNavigation == "splash1") {
      return SelectcategoryPage();
    } else if (currentNavigation == "home") {
      return HomePage();
    } else if (currentNavigation == "poster") {
      return PosterPage();
    } else if (currentNavigation == "photobook") {
      return PhotobookPage();
    } else if (currentNavigation == "canvas") {
      return CanvasPage();
    } else if (currentNavigation == "calendar") {
      return CalendarPage();
    } else {
      return NotfoundPage();
    }
  }

  void updateNavigation(String navigation) {
    // print(navigation);
    // if (navigation != "back") {
    //   previousNo = previousNavigation.length;
    //   if (previousNavigation.contains(currentNavigation)) {
    //   } else {
    //     previousNavigation.add(currentNavigation);
    //   }
    //   currentNavigation = navigation;
    //   print(currentNavigation);
    //   notifyListeners();
    // } else {
    //       currentNavigation = previousNavigation[previousNavigation.length - 1];
    //       previousNavigation.removeLast();
    //       previousNo = previousNavigation.length - 1;
    //       notifyListeners();
    // }
  }

  getnavigation() {
    return currentNavigation;
  }

  bool get checkconnectivity => connected;

  listneconnectivity() async {
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.mobile) {
    //   connected = true;
    //   notifyListeners();
    // } else if (connectivityResult == ConnectivityResult.wifi) {
    //   connected = true;
    //   notifyListeners();
    // } else {
    //   connected = false;
    //   notifyListeners();
    // }
    // final subscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) {
    //   // Got a new connectivity status!
    //   // print(result);
    //   switch (result) {
    //     case ConnectivityResult.wifi:
    //       connected = true;
    //       notifyListeners();
    //       break;
    //     case ConnectivityResult.mobile:
    //       connected = true;
    //       notifyListeners();
    //       break;
    //     case ConnectivityResult.none:
    //       connected = false;
    //       notifyListeners();
    //       break;
    //     default:
    //       break;
    //   }
    // });
  }

  /////////////////////////
///////PhotoEditing//////////////
////////////////////////

  int istextFormattingnew = 0;
  int selectedimageFilterTabindexnew = 0;
  int selectedimagepostionindexnew = 0;
  String imageQulaityColornew = "00ffffff";
  int selcted_pagePositionnew = 0;
  String selcted_image_typenew = "";
  String selcted_image_urlnew = "";
  String selcted_image_base64new = "";
  String whichImageShownew = "original";
  Offset textPostion = Offset(0.0, 0.0);
  Size imagesize = Size.zero;
  double dragboxwidth = 100;
  double dragboxheight = 10;
  String seletedImageurinew = "";
  String seletedImagebase64 = "";
  String? selectedlowIMageurinew = '';
  String selected_product_type = "";
  bool isLayoutCirclenew = false;
  bool isCroppednew = false;
  List<double> selected_filternew = NOFILTER;

  Future<void> replaceImage(imageEntity) async {
    //String color = getImageDpiColor(imageEntity.size);
    // imageQulaityColor = color;
    seletedImageurinew = imageEntity["fileuriPath"];
    selcted_image_urlnew = imageEntity["url_image"];
    selcted_image_typenew = imageEntity["image_type"];
    selectedlowIMageurinew = imageEntity["lowresofileuriPath"];
    seletedImagebase64 = imageEntity["base64"];
    selcted_image_base64new = imageEntity["base64"];
    // seletedImagebase64 = imageEntity["lowresofileuriPath"];
    //selectedlowIMageuri = imageEntity["isCropped"];
    whichImageShownew = "original";

    if (selcted_image_typenew != null) {
      if (selcted_image_typenew == "memoti" ||
          selcted_image_typenew == "google") {
        addFilterDataUrlnew();
      } else {
        addFilterDataNew();
      }
    }
    /*  _getItems[_selcted_pagePosition]["imageModel"].fileuriPath[_selcted_imagePostion] = imageEntity.fileuriPath;
    _getItems[_selcted_pagePosition]["imageModel"].iscroppeds[_selcted_imagePostion] = imageEntity.isCropped;
    _getItems[_selcted_pagePosition]["imageModel"].fileuriPathlowreso[_selcted_imagePostion] = imageEntity.lowresofileuriPath;
    _getItems[_selcted_pagePosition]["imageModel"].imageType[_selcted_imagePostion] = imageEntity.image_type;
    _getItems[_selcted_pagePosition]["imageModel"].imageUrl[_selcted_imagePostion] = imageEntity.url_image;
    _getItems[_selcted_pagePosition]["imageModel"].imageQualityColor[_selcted_imagePostion] = color;
    int imagePosition = 0;
    if(_selcted_image_type != null){
      if(_selcted_image_type == "memoti" || _selcted_image_type == "google" ){
        for(int i = 0;i<mainImageList.length;i++) {
          if (_selcted_image_url == mainImageList[i].url_image) {
            imagePosition = i;
            if(mainImageList[i].count.split(",").length>2){
              List<String> counts = mainImageList[i].count.split(",");
              for(int j = 0;j<counts.length;i++){
                if(counts[j]==_selcted_pagePosition.toString()){
                  counts.removeAt(j);
                  counts.removeAt(j);
                  mainImageList[i].count = counts.join(",");
                  break;
                }
                j = j+1;
              }

              imageEntity.count = _selcted_pagePosition.toString()+","+_selcted_imagepos.toString();
              mainImageList.add(imageEntity);
            }
            else{
              mainImageList.removeAt(imagePosition);
              imageEntity.count = _selcted_pagePosition.toString()+","+_selcted_imagepos.toString();
              mainImageList.insert(imagePosition, imageEntity);
            }
            break;
          }
        }
      }
      else{
        for(int i = 0;i<mainImageList.length;i++) {
          if (_seletedImageuri == mainImageList[i].fileuriPath) {
            imagePosition = i;
            print("mainImageList[i].count");
            print(mainImageList[imagePosition].count);
            print(mainImageList[imagePosition].count.split(",").length);
            if(mainImageList[imagePosition].count.split(",").length>2){
              List<String> counts = mainImageList[imagePosition].count.split(",");
              for(int j = 0;j<counts.length;i++){
                if(counts[j]==_selcted_pagePosition.toString()){
                  counts.removeAt(j);
                  counts.removeAt(j);
                  print(counts.toString());
                  print(imagePosition.toString());
                  print(i.toString());
                  mainImageList[imagePosition].count = counts.join(",");
                  break;
                }
                j = j+1;
              }

              imageEntity.count = _selcted_pagePosition.toString()+","+_selcted_imagepos.toString();
              mainImageList.add(imageEntity);
            }
            else{
              mainImageList.removeAt(imagePosition);
              imageEntity.count = _selcted_pagePosition.toString()+","+_selcted_imagepos.toString();
              mainImageList.insert(imagePosition, imageEntity);
            }
            break;
          }
        }
      }
    }
    if (_selcted_image_type != null) {
      if(_selcted_image_type == "memoti" || _selcted_image_type == "google" ){
        addFilterDataUrl();
      }
      else{
        addFilterData();
      }
    }*/
    notifyListeners();
  }

  // Update image after returning
  Future<void> updatePhotobookImage(Uint8List byte_image) async {
    var lowresoFile = await writeToFile(
        byte_image,
        "image_" + /*DateTime.now().toString().substring(0,20)*/ DateTime.now()
                .microsecond
                .toString() +
            ".jpg");
    _getItems[selcted_pagePositionnew]["imageModel"]
            .fileuriPathlowreso[selectedimagepostionindexnew] =
        lowresoFile.uri.path;
    _getItems[selcted_pagePositionnew]["imageModel"]
        .iscroppeds[selectedimagepostionindexnew] = "true";
    _getItems[selcted_pagePositionnew]["imageModel"]
            .base64[selectedimagepostionindexnew] =
        await converttobase64bytes(lowresoFile.uri.path);
    //_getItems[selcted_pagePositionnew]["imageModel"].aspectRatio[selectedimagepostionindexnew] = selectedaspectRatio;
    int imagePosition = 0;

    if (whichImageShownew == "original") {
      if (selcted_image_typenew == "phone") {
        // print("_seletedImageuri - "+seletedImageurinew.toString());
        for (int i = 0; i < mainImageList.length; i++) {
          if (seletedImageurinew == mainImageList[i]["fileuriPath"]) {
            // print("mainImageList[i]._seletedImageuri - "+mainImageList[i]["fileuriPath"].toString());
            imagePosition = i;
            mainImageList[i]["isCropped"] = "true";
            //mainImageList[i]["aspectRatio"] = selectedaspectRatio;
            mainImageList[i]["lowresofileuriPath"] = lowresoFile.uri.path;
            mainImageList[i]["base64"] =
                await converttobase64bytes(lowresoFile.uri.path);
            break;
          }
        }
      } else {
        // print("_selcted_image_url - "+selcted_image_urlnew.toString());
        // print("_selcted_image_url - "+selcted_image_urlnew.toString());
        for (int i = 0; i < mainImageList.length; i++) {
          if (selcted_image_urlnew == mainImageList[i]["url_image"]) {
            mainImageList[i]["isCropped"] = "true";
            //mainImageList[i]["aspectRatio"] = selectedaspectRatio;
            mainImageList[i]["lowresofileuriPath"] = lowresoFile.uri.path;
            mainImageList[i]["base64"] =
                await converttobase64bytes(lowresoFile.uri.path);
            break;
          }
        }
      }
      seletedImageurinew = lowresoFile.uri.path;
      selcted_image_urlnew = "";
      seletedImageurinew = "phone";
    } else {
      // print("selectedlowIMageuri - "+selectedlowIMageuri.toString());
      for (int i = 0; i < mainImageList.length; i++) {
        if (selectedlowIMageuri == mainImageList[i]["lowresofileuriPath"]) {
          // print("mainImageList[i].lowresofileuriPath - "+mainImageList[i]["lowresofileuriPath"].toString());
          imagePosition = i;
          mainImageList[i]["isCropped"] = "true";
          mainImageList[i]["aspectRatio"] = selectedaspectRatio;
          mainImageList[i]["lowresofileuriPath"] = lowresoFile.uri.path;
          mainImageList[i]["base64"] =
              await converttobase64bytes(lowresoFile.uri.path);
          break;
        }
      }
      selectedlowIMageurinew = lowresoFile.uri.path;
      selcted_image_urlnew = "";
      selcted_image_typenew = "phone";
    }
    notifyListeners();
  }

  Future<void> updateCanvasImage(Uint8List byte_image) async {
    io.File lowresoFile = await writeToFile(
        byte_image, "image_" + DateTime.now().microsecond.toString() + ".jpg");

    var decodedImage = await decodeImageFromList(lowresoFile.readAsBytesSync());
    //_selcted_image = image;
    imageQulaityColornew = getImageDpiColor(Size(
        double.parse(decodedImage.width.toString()),
        double.parse(decodedImage.height.toString())));
    imageList[0]["lowresofileuriPath"] = lowresoFile.uri.path;
    imageList[0]["base64"] = await converttobase64bytes(lowresoFile.uri.path);
    //imageList[0].fileuriPath = lowresoFile.uri.path;
    imageList[0]["isCropped"] = "true";
    selectedlowIMageurinew = lowresoFile.uri.path;
    selcted_image_base64 = imageList[0]["base64"];
    whichImageShownew = "crop";
    //selcted_image = lowresoFile.uri.path;
    //selcted_image_type = "phone";
    notifyListeners();
  }

  Future<void> updatePosterImage(Uint8List byte_image) async {
    io.File lowresoFile = await writeToFile(
        byte_image,
        "image_" + /*DateTime.now().toString().substring(0,20)*/ DateTime.now()
                .microsecond
                .toString() +
            ".jpg");

    var decodedImage = await decodeImageFromList(lowresoFile.readAsBytesSync());
    selectedlowIMageuri = lowresoFile.uri.path;
    whichImageShow = "crop";
    imageList[selectedimagepostionindexnew]["isCropped"] = "true";
    imageList[selectedimagepostionindexnew]["lowresofileuriPath"] =
        lowresoFile.uri.path;
    imageList[selectedimagepostionindexnew]["base64"] =
        await converttobase64bytes(lowresoFile.uri.path);
    selectedlowIMageurinew = lowresoFile.uri.path;
    whichImageShownew = "crop";

    notifyListeners();
  }

  setphotobookpagePostion(int page_pos) {
    selcted_pagePositionnew = page_pos;
  }

  openImageEdit(
      String base64,
      bool isCropped,
      String selected_Image_type,
      String image_url,
      String image_uri,
      String image_low_uri,
      String product_type,
      bool isLayoutCircle,
      int image_postion) async {
    isCroppednew = isCropped;
    selcted_image_typenew = selected_Image_type;
    selcted_image_urlnew = image_url;
    seletedImageurinew = image_uri;
    selcted_image_base64new = base64;
    selectedlowIMageurinew = image_low_uri;
    selected_product_type = product_type;
    isLayoutCirclenew = isLayoutCircle;
    selectedimagepostionindexnew = image_postion;
    // if(isCroppednew){
    //   istextFormattingnew = 3;
    //   addOtherData();
    // }else{
    print("selcted_image_typenew");
    print(selcted_image_typenew);
    whichImageShownew = "original";
    if (selcted_image_typenew != null) {
      if (selcted_image_typenew == "memoti") {
        addFilterDataUrlnew();
        Size size = await _calculateImageDimension(selcted_image_urlnew);
        imageQulaityColornew = getImageDpiColornew(size);
      } else if (selcted_image_typenew == "facebook") {
        addFilterDataUrlnew();
        Size size = await _calculateImageDimension(selcted_image_urlnew);
        imageQulaityColornew = getImageDpiColornew(size);
      } else if (selcted_image_typenew == "instagram") {
        addFilterDataUrlnew();
        Size size = await _calculateImageDimension(selcted_image_urlnew);
        imageQulaityColornew = getImageDpiColornew(size);
      } else if (selcted_image_typenew == "google") {
        Size size = await _calculateImageDimension(
            selcted_image_urlnew + "=w400-h400-c");
        imageQulaityColornew = getImageDpiColornew(size);
        addFilterDataUrlnew();
      } else {
        // print(seletedImageurinew);
        io.File image = new io.File(seletedImageurinew);
        var decodedImage =
            await decodeImageFromList(base64Decode(selcted_image_base64new));
        imageQulaityColornew = getImageDpiColornew(Size(
            double.parse(decodedImage.width.toString()),
            double.parse(decodedImage.height.toString())));
        addFilterDataNew();
      }
    }
    istextFormattingnew = 2;
    addOtherData();
    // }
  }

  setImageSelectionnew(String whichimage) async {
    whichImageShownew = whichimage;
    _filterList = [];
    _filterListUrl = [];
    istextFormattingnew = 2;
    if (whichImageShownew == "original") {
      if (selcted_image_typenew != null) {
        if (selcted_image_typenew == "memoti") {
          addFilterDataUrlnew();
          Size size = await _calculateImageDimension(selcted_image_urlnew);
          imageQulaityColornew = getImageDpiColornew(size);
        } else if (selcted_image_typenew == "facebook") {
          addFilterDataUrlnew();
          Size size = await _calculateImageDimension(selcted_image_urlnew);
          imageQulaityColornew = getImageDpiColornew(size);
        } else if (selcted_image_typenew == "instagram") {
          addFilterDataUrlnew();
          Size size = await _calculateImageDimension(selcted_image_urlnew);
          imageQulaityColornew = getImageDpiColornew(size);
        } else if (selcted_image_typenew == "google") {
          Size size = await _calculateImageDimension(
              selcted_image_urlnew + "=w400-h400-c");
          imageQulaityColornew = getImageDpiColornew(size);
          addFilterDataUrlnew();
        } else {
          io.File image = new io.File(
              seletedImageurinew); // Or any other way to get a io.File instance.
          var decodedImage = await decodeImageFromList(image.readAsBytesSync());
          // print(decodedImage.width);
          // print(decodedImage.height);
          imageQulaityColornew = getImageDpiColornew(Size(
              double.parse(decodedImage.width.toString()),
              double.parse(decodedImage.height.toString())));

          addFilterDataNew();
        }
      }
    } else {
      selcted_image_typenew = "phone";
      io.File image = new io.File(
          selectedlowIMageurinew!); // Or any other way to get a io.File instance.
      var decodedImage = await decodeImageFromList(image.readAsBytesSync());
      // print(decodedImage.width);
      // print(decodedImage.height);
      imageQulaityColornew = getImageDpiColornew(Size(
          double.parse(decodedImage.width.toString()),
          double.parse(decodedImage.height.toString())));
      addFilterDataNew();
    }
  }

  opentextformattingnew() {
    textEditingController.text == "";
    istextFormattingnew = 1;
    notifyListeners();
  }

  changeImageFilterSelectedTabColornew(int postion) {
    if (postion == 3) {
      opentextformattingnew();
    } else {
      selectedimageFilterTabindexnew = postion;
      notifyListeners();
    }
  }

  closedImageFilternew() {
    istextFormattingnew = 0;
    selectedimageFilterTabindexnew = 0;
    /*selectedaspectRatio = ratio;
    ratio = "";*/
    selected_filternew = NOFILTER;
    for (int i = 0; i < _filterList.length; i++) {
      _filterList[i].isSelected = false;
    }
    notifyListeners();
  }

  Uint8List? originaltextEditIMagenew = null;
  bool isoriginaltextEditIMagenew = false;

  final GlobalKey _editglobalKey = GlobalKey();
  GlobalKey get editglobalKey => _editglobalKey;
  convertWidgetToImage(BuildContext context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    print("currentFocus.hasPrimaryFocus");
    print(currentFocus.hasPrimaryFocus);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    RenderRepaintBoundary? repaintBoundary = _editglobalKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;
    ui.Image boxImage = await repaintBoundary!.toImage(pixelRatio: 3.0);
    ByteData? byteData =
        await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8list = byteData!.buffer.asUint8List();
    return uint8list;
  }

  closedtextformattingnew(BuildContext context) async {
    istextFormattingnew = 2;
    if (textEditingController.text == "") {
      originaltextEditIMagenew = null;
      isoriginaltextEditIMagenew = false;
      currenttextColor = Colors.black;
      currentBGColor = Colors.white;
      _selectedtextFormatTabindex = 0;
      _selectedcolorindex = 0;
      selectedFontSizeindex = 10;
      selectededitTextPosition = 0;
      _selectedFontKey = _customFontList[0].fontName;
      selectedfontpath = _customFontList[0].fontspath;
      _selectedFontindex = 0;
      textEditingController = TextEditingController();
      Navigator.pop(context, null);
    } else {
      Offset textoffset = Offset.zero;
      int width, height;
      var image;
      selectedfontpath = _customFontList[_selectedFontindex].fontspath;
      io.File fontFile =
          await getFileFromAssets(selectedfontpath.split("-app/")[1]);
      print("hhhhhhhhhhhhhhh");
      final String fontName = await FontManager.registerFont(fontFile);
      if (whichImageShownew == "original") {
        image = originaltextEditIMagenew;
        var decodedImage = await decodeImageFromList(originaltextEditIMagenew!);
        width = decodedImage.width;
        height = decodedImage.height;
      } else {
        image = io.File(selectedlowIMageurinew!);
        var decodedImage = await decodeImageFromList(image.readAsBytesSync());
        width = decodedImage.width;
        height = decodedImage.height;
      }

      double xtime = imagesize.width / 1000;
      double xt = 0.001;
      double xtt = 0.001;
      int xpos = 0;

      double ytime = imagesize.height / 1000;
      double yt = 0.001;
      double ytt = 0.001;
      int ypos = 0;

      for (int i = 1; i < 1001; i++) {
        if (textPostion.dx > xt) {
          xt = xt + xtime;
        } else {
          xpos = i;
          break;
        }
      }
      if (xpos > 850) {
        xtt = xtt * 850;
      } else {
        xtt = xtt * xpos;
        xtt = xtt + 0.01;
      }

      for (int i = 1; i < 1001; i++) {
        if (textPostion.dy > yt) {
          yt = yt + ytime;
        } else {
          ypos = i;
          break;
        }
      }
      if (ypos > 850) {
        ytt = ytt * 850;
      } else {
        ytt = ytt * ypos;
        ytt = ytt + 0.01;
      }
      textoffset = Offset(xtt, ytt);

      final textOption = AddTextOption();
      textOption.addText(
        EditorText(
            offset: Offset(
                width * textoffset.dx, height.toDouble() * textoffset.dy),
            text: textEditingController.text,
            fontSizePx: selectedFontSizeindex * 3,
            textColor: currenttextColor,
            fontName: fontName),
      );
      print("run4");
      ImageEditorOption option = ImageEditorOption();
      option = ImageEditorOption();
      option.addOption(textOption);

      if (whichImageShownew != "original") {
        // final result = await ImageEditor.editFileImage(file: image, imageEditorOption: option,);
        final result = await convertWidgetToImage(context);
        // print(result);
        Navigator.pop(context, result);
      } else {
        // final result = await ImageEditor.editImage(image: image, imageEditorOption: option);
        final result = await convertWidgetToImage(context);
        // print(result);
        Navigator.pop(context, result);
      }
      originaltextEditIMagenew = null;
      isoriginaltextEditIMagenew = false;
      print("run5");
      currenttextColor = Colors.black;
      currentBGColor = Colors.white;
      _selectedtextFormatTabindex = 0;
      _selectedcolorindex = 0;
      selectedFontSizeindex = 10;
      selectededitTextPosition = 0;

      _selectedFontKey = _customFontList[0].fontName;
      selectedfontpath = _customFontList[0].fontspath;
      _selectedFontindex = 0;
      textEditingController = TextEditingController();
    }
  }

  changeFilternew(int index) {
    print("changeFilter");
    for (int i = 0; i < _filterList.length; i++) {
      if (i == index) {
        selected_filternew = _filterList[i].filter;
        _filterList[i].isSelected = true;
      } else {
        _filterList[i].isSelected = false;
      }
    }
    notifyListeners();
  }

  changeFilterUrlnew(int index) {
    print("changeFilter");
    for (int i = 0; i < _filterListUrl.length; i++) {
      if (i == index) {
        selected_filternew = _filterListUrl[i].filter;
        _filterListUrl[i].isSelected = true;
      } else {
        _filterListUrl[i].isSelected = false;
      }
    }
    notifyListeners();
  }

  void addFilterDataUrlnew() {
    print("seletedImagebase64");
    print(selcted_image_base64new);
    _filterListUrl.clear();
    _filterListUrl.add(new ImageFilterModelUrl(
        seletedImageurinew,
        selcted_image_urlnew,
        selectedlowIMageurinew!,
        "NO FILTER",
        NOFILTER,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        seletedImageurinew,
        selcted_image_urlnew,
        selectedlowIMageurinew!,
        "SEPIA",
        SEPIA_MATRIX,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        seletedImageurinew,
        selcted_image_urlnew,
        selectedlowIMageurinew!,
        "GREYSCALE",
        GREYSCALE_MATRIX,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        seletedImageurinew,
        selcted_image_urlnew,
        selectedlowIMageurinew!,
        "VINTAGE",
        VINTAGE_MATRIX,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        seletedImageurinew,
        selcted_image_urlnew,
        selectedlowIMageurinew!,
        "SWEET",
        SWEET_MATRIX,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        seletedImageurinew,
        selcted_image_urlnew,
        selectedlowIMageurinew!,
        "MILK",
        MILK,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        seletedImageurinew,
        selcted_image_urlnew,
        selectedlowIMageurinew!,
        "SEPIUM",
        SEPIUM,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        seletedImageurinew,
        selcted_image_urlnew,
        selectedlowIMageurinew!,
        "COLD LIFE",
        COLDLIFE,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        seletedImageurinew,
        selcted_image_urlnew,
        selectedlowIMageurinew!,
        "OLD TIME",
        OLDTIME,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        seletedImageurinew,
        selcted_image_urlnew,
        selectedlowIMageurinew!,
        "BLACK & WHITE",
        BLACKANDWHITE,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        seletedImageurinew,
        selcted_image_urlnew,
        selectedlowIMageurinew!,
        "CYAN",
        CYAN,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        seletedImageurinew,
        selcted_image_urlnew,
        selectedlowIMageurinew!,
        "YELLOW",
        YELLOW,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        seletedImageurinew,
        selcted_image_urlnew,
        selectedlowIMageurinew!,
        "PURPLE",
        PURPLE,
        false,
        selcted_image_base64new));
    notifyListeners();
  }

  void addFilterDataNew() {
    print("adding filter list data");
    String uri = "";
    if (whichImageShownew == "original") {
      print("original");
      uri = seletedImageurinew;
    } else {
      print("crop");
      uri = selectedlowIMageurinew!;
    }
    // print(uri);
    _filterList.clear();
    _filterList.add(new ImageFilterModel(
        uri, "NO FILTER", NOFILTER, false, selcted_image_base64new));
    _filterList.add(new ImageFilterModel(
        uri, "SEPIA", SEPIA_MATRIX, false, selcted_image_base64new));
    _filterList.add(new ImageFilterModel(
        uri, "GREYSCALE", GREYSCALE_MATRIX, false, selcted_image_base64new));
    _filterList.add(new ImageFilterModel(
        uri, "VINTAGE", VINTAGE_MATRIX, false, selcted_image_base64new));
    _filterList.add(new ImageFilterModel(
        uri, "SWEET", SWEET_MATRIX, false, selcted_image_base64new));
    _filterList.add(new ImageFilterModel(
        uri, "MILK", MILK, false, selcted_image_base64new));
    _filterList.add(new ImageFilterModel(
        uri, "SEPIUM", SEPIUM, false, selcted_image_base64new));
    _filterList.add(new ImageFilterModel(
        uri, "COLD LIFE", COLDLIFE, false, selcted_image_base64new));
    _filterList.add(new ImageFilterModel(
        uri, "OLD TIME", OLDTIME, false, selcted_image_base64new));
    _filterList.add(new ImageFilterModel(
        uri, "BLACK & WHITE", BLACKANDWHITE, false, selcted_image_base64new));
    _filterList.add(new ImageFilterModel(
        uri, "CYAN", CYAN, false, selcted_image_base64new));
    _filterList.add(new ImageFilterModel(
        uri, "YELLOW", YELLOW, false, selcted_image_base64new));
    _filterList.add(new ImageFilterModel(
        uri, "PURPLE", PURPLE, false, selcted_image_base64new));
    print("added filter list data");
    notifyListeners();
  }

/////////////////////////
///////API//////////////
////////////////////////

  static const BASE_URL =
      "https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/";
  // static const BASE_URL = "https://u0tgn0ty69.execute-api.eu-central-1.amazonaws.com/default/memoti/";
  Future<Object> Postcall(url, dynamic body) async {
    print(Uri.parse('${BASE_URL}' + url));
    final response =
        await http.post(Uri.parse('${BASE_URL}' + url), body: body);
    print(response);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Object> Getcall(url) async {
    print(Uri.parse('${BASE_URL}' + url));
    final response = await http.get(Uri.parse('${BASE_URL}' + url));
    print("response.statusCode");
    print(response.statusCode);
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      return jsonEncode(jsonDecode(body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Object> Getcalls(url) async {
    // print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      // print(response.statusCode);
      // print(response.reasonPhrase);
      return Null;
    }
  }

/////////////////////
//////Home///////////
/////////////////////

  bool oncecall = false;
  dynamic datumList = [];
  dynamic _selectedproduct;
  dynamic get selectedproduct => _selectedproduct;
  dynamic datumLists() {
    return datumList;
  }

  setProduct(product) {
    _selectedproduct = product;
    notifyListeners();
  }

  getIsLoggedIN() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String userId = prefs.getString(UiData.user_id) != null
        ? prefs.getString(UiData.user_id)
        : "";
    print("user_id - ");
    // print(prefs.getString(UiData.user_id));
    if (userId != "") {
      _isloggedIn = true;
    }
    name = prefs.getString(UiData.name) ?? "";
    email = prefs.getString(UiData.email) ?? "";
    image = prefs.getString(UiData.picture) ?? "";
    user_ids = prefs.getString(UiData.user_id) ?? "";
    token = prefs.getString(UiData.token) ?? "";
    address = prefs.getString(UiData.address) ?? "";
    // print("isLoggedIn - "+_isloggedIn.toString());
    notifyListeners();
  }

  fetchAllData() {
    oncecall = true;
    Getcall("mobile/inventory/fetch/all/data").then((dynamic data) {
      print("data");
      if (json.decode(data)['status'] == 'success') {
        datumList = json.decode(data)["data"];
        notifyListeners();
      } else {
        notifyListeners();
      }
    });
  }

  /////////////////
  ///Creations////
  ////////////////
  List creationList = [];
  List creationsingleprojectList = [];
  deleteCreation(int id) async {
    // Temp
    MemotiDbProvider.db.removecreationItem(id).then((value) async {
      creationList = [];
      getAllCreationproduct();
    });
  }

  deleteSingleProjectCreation(int index) async {
    _busy = true;
    String pp_id = creationsingleprojectList[index]["product_id"].toString();
    int id = int.parse(creationsingleprojectList[index]["id"].toString());

    // Temp
    MemotiDbProvider.db.removecreationItem(id).then((value) async {
      creationsingleprojectList = [];
      MemotiDbProvider.db.getCreationswithid(pp_id).then((value) {
        creationsingleprojectList = value;
        notifyListeners();
      });
      notifyListeners();
    });
  }

  getAllCreationproduct() async {
    _busy = true;
    print("iiii");
    // Temp
    MemotiDbProvider.db.getTableCountForcreation().then((value) {
      // print("count  -"+value.toString());
      if (value > 0) {
        MemotiDbProvider.db.getAllCreations().then((value) {
          creationList = value;
          _busy = false;
          notifyListeners();
        });
      } else {
        creationList = [];
        _empty = true;
        _busy = false;
        notifyListeners();
      }
      _check = true;
      // print("jjjj");
      notifyListeners();
    });
  }

  void gocreationCUstomizationPage(BuildContext contextmain,
      BuildContext context, int index, String where) async {
    late String categoryType;
    List mainList = [];
    // print(where);
    if (where == "creations") {
      mainList = creationList;
    } else {
      mainList = creationsingleprojectList;
    }
    // print(mainList.length);
    startprogressbar();

    //print(cartList[index]["product_name"].toString().trim());
    //setCartIndex(creationList[index]["id"]);
    switch (mainList[index]["categorytype"]) {
      case "poster":
        {
          // List imageList = [];
          if (json.decode(mainList[index]["images"])['mainImageList'] != null) {
            // imageList = new List.empty();
            List iamgeList = List.empty(growable: true);
            json
                .decode(mainList[index]["images"])['mainImageList']
                .forEach((v) {
              imageList.add(v);
            });
          }
          /* for(int i = 0;i<imageList.length;i++){
          if(imageList[i].image_type=="phone"){
            print("id - "+imageList[i].uintid);
            await MemotiDbProvider.db.getpicture(int.parse(imageList[i].uintid)).then((value) => imageList[i].uint8list = value);
          }
        }*/
          startprogressbar();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PosterAfterImageSelectionPage(
                      mainList[index]["id"],
                      "creation",
                      contextmain,
                      imageList,
                      int.parse(mainList[index]["max_photo"]),
                      int.parse(mainList[index]["min_photo"]),
                      mainList[index]["product_id"],
                      mainList[index]["product_price"],
                      mainList[index]["selectedSize"],
                      mainList[index]["product_name"],
                      mainList[index]["slovaktitle"])));
          break;
        }
      case "canvas":
        {
          // List imageList = [];
          if (json.decode(mainList[index]["productItem"])['product_item'] !=
              null) {
            dynamic data =
                json.decode(mainList[index]["productItem"])['product_item'];
            // print(data["product"]);
            if (data["product"] != null && data["product"].length != null) {
              product = data["product"][0];
            }
            /*    canvasselectedcolor = data["selectedcolor"];
          canvasselectedThickness = data["selectedThickness"];
          canvasselectedBorder = data["selectedborder"];*/
            canvasselectedSize = data["selectedSizes"];
            fromcanvasdetail = false;
          }
          if (json.decode(mainList[index]["images"])['mainImageList'] != null) {
            List imageList = List.empty(growable: true);
            json
                .decode(mainList[index]["images"])['mainImageList']
                .forEach((v) {
              imageList.add(v);
            });
          }
          startprogressbar();
          // print(imageList);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CanvasSizeSelectionPage(imageList,
                      contextmain, mainList[index]["id"], "creation")));
          break;
        }
      case "photobook":
        {
          List list = [];
          // List imageList = [];
          // List itemList = [];

          if (json.decode(mainList[index]["images"])['mainImageList'] != null) {
            // imageList = new List.empty();
            List imageList = List.empty(growable: true);
            json
                .decode(mainList[index]["images"])['mainImageList']
                .forEach((v) {
              imageList.add(v);
            });
          }
          for (int i = 0; i < imageList.length; i++) {
            if (imageList[i]["image_type"] == "phone") {
              // print(imageList[i]["uintid"]);
              // Temp
              // await MemotiDbProvider.db.getpicture(int.parse(imageList[i]["uintid"])).then((value) => imageList[i]["uint8list"] = value);
              // list.add(imageList[i]);
            }
          }
          if (json.decode(mainList[index]["productItem"])['product_item'] !=
              null) {
            // print(json.decode(mainList[index]["productItem"])['product_item']);
            // itemList = new List.empty();
            List itemList = List.empty(growable: true);
            json
                .decode(mainList[index]["productItem"])['product_item']
                .forEach((v) {
              // print(v.toString());
              itemList.add(v);
            });
          }
          print("1");
          List<String> imageQualityColor = [];
          List<Uint8List> uINtimagelist = [];
          List<String> uintid = [];
          List<String> imageType = [];
          List<String> iscropped = [];
          List<String> aspectRatioo = [];
          List<String> imagefileuripath = [];
          List<String> imagefileuripathlowreso = [];
          List<String> imageUrl = [];

          for (int i = 0; i < itemList.length; i++) {
            for (int j = 0;
                j < itemList[i]["imageModel"]["uint8listid"].length;
                j++) {
              for (int k = 0; k < list.length; k++) {
                // print("2wwww");
                // print(list[k]["uintid"]);
                // print(itemList[i]["imageModel"]["uint8listid"][j]);
                if (itemList[i]["imageModel"]["uint8listid"][j] ==
                    list[k]["uintid"]) {
                  print("3wwww");
                  // itemList[i]["imageModel"]["uint8list"][j] = list[k]["uint8list"];
                  // print(list[k]["uint8list"]);
                  //itemList[i]["imageModel"]["uint8list"][j] = list[k]["uint8list"];
                }
              }
            }
          }
          List itemlistup = [];
          // print(itemList);
          for (int i = 0; i < itemList.length; i++) {
            // print(itemList[i]["imageModel"]);
            if (i == 0) {
              itemlistup.add({
                "layout_id": itemList[i]["layout_id"],
                "isSelected": true,
                "imageModel": ImageModel.fromJson(itemList[i]["imageModel"]),
                "categoryType": "cart"
              });
            } else {
              itemlistup.add({
                "layout_id": itemList[i]["layout_id"],
                "isSelected": false,
                "imageModel": ImageModel.fromJson(itemList[i]["imageModel"]),
                "categoryType": "cart"
              });
            }
          }
          startprogressbar();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PhotobookCustomizationPage(
                      contextmain,
                      imageList,
                      itemlistup,
                      "creation",
                      int.parse(mainList[index]["max_photo"]),
                      int.parse(mainList[index]["min_photo"]),
                      mainList[index]["product_id"],
                      mainList[index]["product_price"],
                      mainList[index]["selectedSize"],
                      mainList[index]["product_name"],
                      mainList[index]["slovaktitle"],
                      mainList[index]["id"])));
          break;
        }
    }

    // startprogressbar();{
    // print(cartList[index]["product_name"].toString().trim());
    // setCartIndex(index);
    // switch(cartList[index]["product_type"]){

    //   case "poster":{
    //     List<AlbumWithMedia> imageList = [];
    //     List images = _cartList[index]["images"];
    //     setCartIndex(index);
    //     for(int i =0 ;i<images.length;i++){
    //       print("i"+i.toString());
    //       print(images[i]);
    //       await  _calculateImageDimension("https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //           images[i]).then((value) {

    //         imageList.add(new AlbumWithMedia((10000 + i).toString(), images[i],
    //             new DateTime.now(),
    //             new io.File("a.txt").uri.path,
    //             new io.File("a.txt").uri.path,
    //             new Uint8List(0), "",
    //             value,
    //             "memoti",
    //             "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //                 images[i],
    //             "1",
    //             "false",
    //             "",
    //             false));

    //         if(images.length-1 == i){
    //           startprogressbar();
    //           Navigator.push( context, MaterialPageRoute(builder: (context) => PosterAfterImageSelectionPage(-1,"cart",contextmain,imageList,int.parse(_cartList[index]["max_photo"]),int.parse(_cartList[index]["min_photo"]),_cartList[index]["product_id"],_cartList[index]["product_prices"],
    //               _cartList[index]["selectedSizes"],_cartList[index]["product_names"],_cartList[index]["slovaktitle"])));

    //         }
    //       });
    //     }
    //     break;
    //   }

    //   case "canvas":{
    //     List<AlbumWithMedia> imageList = [];
    //     List images = _cartList[index]["images"];
    //     setCartIndex(index);
    //     for(int i =0 ;i<images.length;i++){
    //       print("i"+i.toString());
    //       print(images[i]);
    //       await  _calculateImageDimension("https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //           images[i]).then((value) {

    //         imageList.add(new AlbumWithMedia((10000 + i).toString(), images[i],
    //             new DateTime.now(),
    //             new io.File("a.txt").uri.path,
    //             new io.File("a.txt").uri.path,
    //             new Uint8List(0), "",
    //             value,
    //             "memoti",
    //             "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //                 images[i],
    //             "1",
    //             "false",
    //             "",
    //             false));

    //         if(images.length-1 == i){
    //           setcanvasProduct(_cartList[index]["product"]);
    //           canvasselectedcolor = _cartList[index]["selectedcolor"];
    //           canvasselectedThickness = _cartList[index]["selectedThickness"];
    //           canvasselectedBorder = _cartList[index]["selectedborder"];
    //           canvasselectedSize = _cartList[index]["selectedSizes"  ];
    //           fromcanvasdetail = false;
    //           startprogressbar();
    //           Navigator.push( context, MaterialPageRoute(builder: (context) => CanvasSizeSelectionPage(imageList,contextmain,-1,"cart")));

    //         }
    //       });
    //     }
    //     break;
    //   }
    //   case "calendar":{

    //     if(cartList[index]["product_names"].toString().trim()=="Poster"){
    //       List<AlbumWithMedia> imageList = [];
    //       String calendarDate  = _cartList[index]["calendarDate"];
    //       List images = _cartList[index]["images"];
    //       DateTime dateTime = DateFormat("MMMM , yyyy").parse(calendarDate);
    //       setCalendarDate(dateTime);

    //       for(int i =0 ;i<images.length;i++){
    //         print("i"+i.toString());
    //         print(images[i]);
    //         await  _calculateImageDimension("https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //             images[i]).then((value) {

    //           imageList.add(new AlbumWithMedia((10000 + i).toString(), images[i],
    //               new DateTime.now(),
    //               new io.File("a.txt").uri.path,
    //               new io.File("a.txt").uri.path,
    //               new Uint8List(0), "",
    //               value,
    //               "memoti",
    //               "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //                   images[i],
    //               "1",
    //               "false",
    //               "",
    //               false));

    //           if(images.length-1 == i){
    //             startprogressbar();
    //             Navigator.push( context, MaterialPageRoute(builder: (context) => CalendarPosterPreviewPage(-1,"cart",contextmain, imageList ,int.parse(_cartList[index]["max_photo"]),int.parse(_cartList[index]["min_photo"]),_cartList[index]["product_id"],_cartList[index]["product_prices"],
    //                 _cartList[index]["selectedSizes"],_cartList[index]["product_names"],_cartList[index]["slovaktitle"])));

    //           }
    //         });
    //       }
    //     }else{
    //       List<AlbumWithMedia> imageList = [];
    //       String calendarDate  = _cartList[index]["calendarDate"];
    //       List images = _cartList[index]["images"];
    //       for(int i =0 ;i<images.length;i++){
    //         print("i"+i.toString());
    //         print(images[i]);
    //         await  _calculateImageDimension("https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //             images[i]).then((value) {

    //           imageList.add(new AlbumWithMedia(
    //               (10000 + i).toString(),
    //               images[i],
    //               new DateTime.now(),
    //               new io.File("a.txt").uri.path,
    //               new io.File("a.txt").uri.path,
    //               new Uint8List(0), "",
    //               value,
    //               "memoti",
    //               "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //                   images[i],
    //               "1",
    //               "false",
    //               "",
    //               false));

    //           if(images.length-1 == i){
    //             preparecalenderList(imageList,calendarDate,contextmain,context,index);
    //           }
    //         });
    //       }
    //     }
    //     break;
    //   }
    //   case "photobook":{
    //     String width = _cartList[index]["selectedSizes"].split("x")[0];
    //     String height = _cartList[index]["selectedSizes"].split("x")[1].split("cm")[0];
    //     selected_width = double.parse(width);
    //     selected_height = double.parse(height);
    //     List<AlbumWithMedia> imageList = [];
    //     List<PhotoBookCustomModel> itemList = [];
    //     List images = _cartList[index]["images"];
    //     List layoutid = _cartList[index]["layout_id"];

    //     print(images.length);
    //     for(int i =0 ;i<images.length;i++){
    //       print("i"+i.toString());
    //       //print(images[i]);
    //       await  _calculateImageDimension("https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //           images[i]).then((value) {

    //         imageList.add(new AlbumWithMedia(
    //             (10000 + i).toString(),
    //             images[i],
    //             new DateTime.now(),
    //             new io.File("a.txt").uri.path,
    //             new io.File("a.txt").uri.path,
    //             new Uint8List(0), "",
    //             value,
    //             "memoti",
    //             "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //                 images[i],
    //             "1",
    //             "false",
    //             "",
    //             false));

    //         if(images.length-1 == i){
    //           setitemlist(contextmain,imageList,layoutid,itemList,index,context);
    //         }
    //       });
    //     }
    //     break;
    //   }
    // }
  }

  /////////////////
  ///////Cart//////
  ////////////////
  bool _showstripe = false;
  bool get showstripe => _showstripe;
  bool _empty = false;
  bool apierror = false;
  bool get empty => _empty;
  bool _check = false;
  bool get check => _check;
  int count = 0;
  String totalprice = "0";
  List _cartList = [];
  late int max_photo;
  late int min_photo;
  late String product_id;
  List get cartList => _cartList;
  bool calledcart = false;
  List localCartList = [];

  getAllLocalCartproduct() async {
    calledcart = true;
    //_busy = true;
    print("iiii");
    // Temp
    MemotiDbProvider.db.getTableCountForCart().then((value1) {
      // print("count  -"+value1.toString());
      if (value1 > 0) {
        localCartList.length != null;
        localCartList.length > 0;
        MemotiDbProvider.db.getAllCart().then((value) {
          print("localCartList.length - " + value.length.toString());
          print(localCartList.length);
          print(value.toString());
          // print(value.reversed);
          localCartList = value.reversed.toList();
          if (value.length > 0) {
            _empty = false;
            localCartList = value.reversed.toList();
            updatePrice();
          } else {
            _empty = true;
            notifyListeners();
          }
        });
      } else {
        _empty = true;
      }
      _check = true;
      updatePrice();
      // print("jjjj");
      //notifyListeners();
    });
  }

  getAllCartproduct(contextmain, context) async {
    calledcart = true;
    print("get cart");
    // SharedPreferences prefs  = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String userId = prefs.getString(UiData.user_id) ?? "";
    if (userId == "") {
      //calledcart = true;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      name = prefs.getString(UiData.name) ?? "";
      email = prefs.getString(UiData.email) ?? "";
      image = prefs.getString(UiData.picture) ?? "";
      user_ids = prefs.getString(UiData.user_id) ?? "";
      token = prefs.getString(UiData.token) ?? "";
      address = prefs.getString(UiData.address) ?? "";
      notifyListeners();
      dynamic data = {"customer_id": user_ids};
      String body = json.encode(data);
      var url = Uri.parse(
          'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/inventory/list/product/to/cart');
      http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      notifyListeners();
      print(body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(json.decode(response.body)["data"]);
        Map<String, dynamic> map =
            json.decode(utf8.decode(response.bodyBytes))["data"];
        if (map != null && map.isNotEmpty) {
          _cartList.clear();
          _cartList =
              json.decode(utf8.decode(response.bodyBytes))["data"]["cartItems"];
          if (_cartList.length > 0) {
            // print(json.decode(utf8.decode(response.bodyBytes))["data"]["cartItems"][0]["product_names"]);
            // print(json.decode(utf8.decode(response.bodyBytes))["data"]["cartItems"][0]["slovaktitle"]);
            // print(response.body);
            updatePrice();
          } else {
            _empty = true;
          }

          notifyListeners();
        } else {
          _empty = true;
          notifyListeners();
        }
      } else {
        apierror = true;
        notifyListeners();
        throw Exception('Failed to load album');
      }
    }
  }

  getAllCartproduct1(contextmain, context) {
    apierror = false;
    getAllCartproduct(contextmain, context);
    notifyListeners();
  }

  changeCount(String count, bool isincrease, int index) {
    int intCount = int.parse(count);
    if (!isincrease) {
      if (intCount == 1) {
        // Temp
        print("MemotiDbProvider.db.removecart");
        MemotiDbProvider.db
            .removecart(localCartList[index]["id"])
            .then((value) {
          localCartList.removeAt(index);
          print("localCartList - +" + localCartList.length.toString());
          if (localCartList.length == 0) {
            _empty = true;
            notifyListeners();
          }
          updatePrice();
          notifyListeners();
        });
      } else {
        print("MemotiDbProvider.db.updateCart");
        print(intCount);
        intCount = intCount - 1;
        Map<String, dynamic> map = {
          "categorytype": localCartList[index]["categorytype"],
          "id": localCartList[index]["id"],
          "images": localCartList[index]["images"],
          "productItem": localCartList[index]["productItem"],
          "max_photo": localCartList[index]["max_photo"],
          "selectedSize": localCartList[index]["selectedSize"],
          "min_photo": localCartList[index]["min_photo"],
          "product_id": localCartList[index]["product_id"],
          "product_price": localCartList[index]["product_price"],
          "product_name": localCartList[index]["product_name"],
          "slovaktitle": localCartList[index]["slovaktitle"],
          "lasteditdate": localCartList[index]["lasteditdate"],
          "pdfUrl": localCartList[index]["pdfUrl"],
          "count": intCount.toString(),
          "order_status": localCartList[index]["order_status"],
        };
        localCartList.removeAt(index);
        localCartList.insert(index, map);
        // Temp
        MemotiDbProvider.db.updateCart(localCartList[index]);
        updatePrice();
        notifyListeners();
      }
    } else {
      intCount = intCount + 1;
      print("MemotiDbProvider.db.updateCart");
      print(intCount);
      /*_cartList[index]["count"] = intCount.toString();
      print(_cartList[index]["count"]);
      updatecart(_cartList);*/
      //localCartList[index]["count"] = i`ntCount.toString();
      Map<String, dynamic> map = {
        "categorytype": localCartList[index]["categorytype"],
        "id": localCartList[index]["id"],
        "images": localCartList[index]["images"],
        "productItem": localCartList[index]["productItem"],
        "max_photo": localCartList[index]["max_photo"],
        "selectedSize": localCartList[index]["selectedSize"],
        "min_photo": localCartList[index]["min_photo"],
        "product_id": localCartList[index]["product_id"],
        "product_price": localCartList[index]["product_price"],
        "product_name": localCartList[index]["product_name"],
        "slovaktitle": localCartList[index]["slovaktitle"],
        "lasteditdate": localCartList[index]["lasteditdate"],
        "pdfUrl": localCartList[index]["pdfUrl"],
        "count": intCount.toString(),
        "order_status": localCartList[index]["order_status"],
      };
      localCartList.removeAt(index);
      localCartList.insert(index, map);
      // Temp
      MemotiDbProvider.db.updateCart(localCartList[index]);
      updatePrice();
      notifyListeners();
    }
    /*  int intCount = int.parse(count);
    print(_cartList[index]["count"]);
    if(!isincrease){
      if(intCount==1){
        _cartList.removeAt(index);
        updatecart(_cartList);
      }else{
        intCount = intCount-1;
        _cartList[index]["count"] = intCount.toString();
        print(_cartList[index]["count"]);
        updatecart(_cartList);
      }
    }else{
      intCount = intCount+1;
      _cartList[index]["count"] = intCount.toString();
      print(_cartList[index]["count"]);
      updatecart(_cartList);
    }*/
  }

  deleteItem(int index) {
    _cartList.removeAt(index);
    updatecart(_cartList);
  }

  deleteLocalCartItem(int index, int id) {
    print("localCartListlength - +" + localCartList.length.toString());
    // Temp
    MemotiDbProvider.db.removecart(id).then((value) {
      localCartList.removeAt(index);
      print("localCartListlength - +" + localCartList.length.toString());
      if (localCartList.length == 0) {
        _empty = true;
        notifyListeners();
      }
      notifyListeners();
      //list.removeAt(index);
    });
  }

  checkaddress(contextmain, context, price) async {
    startprogressbar();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user_id = preferences.get(UiData.user_id) ?? "";
    if (user_id == "") {
      print("1");
      startprogressbar();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      name = preferences.get(UiData.name) ?? "";
      email = preferences.get(UiData.email) ?? "";
      image = preferences.get(UiData.picture) ?? "";
      user_ids = preferences.get(UiData.user_id) ?? "";
      token = preferences.get(UiData.token) ?? "";
      address = preferences.get(UiData.address) ?? "";
      //notifyListeners();
      print("2");
      fetchAddress(contextmain, token, context, price);
    }
  }

  dynamic pricesummary;
  dynamic get getpricesummary => pricesummary;
  setpricesummary(pricesummarys) {
    print(pricesummarys);
    pricesummary = {"price": pricesummarys};
  }

  gototabs() {
    currentIndex = 2;
    notifyListeners();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TabsPage()));
  }

  fetchAddress(contextmain, String token, context, price) async {
    print(token);
    Map data = {
      "token": token,
    };
    String body = json.encode(data);
    var url = Uri.parse(
        'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/user/login/get/address');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    // print(jsonDecode(response.body)["data"][0]["address"]);
    setpricesummary(price);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["data"].length > 0) {
        if (jsonDecode(response.body)["data"][0] != null &&
            jsonDecode(response.body)["data"][0]["address"] != null) {
          if (jsonDecode(response.body)["data"][0]["address"].length > 0) {
            for (var x = 0;
                x < jsonDecode(response.body)["data"][0]["address"].length;
                x++) {
              var ee = jsonDecode(response.body)["data"][0]["address"][x];
              if (x == 0) {
                _addresses.add({
                  "title": ee["title"],
                  "address": ee["address"],
                  "cityRegion": ee["cityRegion"],
                  "postCode": ee["postCode"],
                  "Country": ee["Country"],
                  "isSelected": true,
                  "pi": jsonDecode(response.body)["data"][0]["pi"],
                  "pt": jsonDecode(response.body)["data"][0]["pt"]
                });
              } else {
                _addresses.add({
                  "title": ee["title"],
                  "address": ee["address"],
                  "cityRegion": ee["cityRegion"],
                  "postCode": ee["postCode"],
                  "Country": ee["Country"],
                  "isSelected": false,
                  "pi": jsonDecode(response.body)["data"][0]["pi"],
                  "pt": jsonDecode(response.body)["data"][0]["pt"]
                });
              }
              if (jsonDecode(response.body)["data"][0]["address"].length - 1 ==
                  x) {
                startprogressbar();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddressListPage(contextmain, token, "cart")));
                //notifyListeners();
              }
            }
          } else {
            startprogressbar();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddAddressPage(contextmain, token, "cart")));
          }
        } else {
          startprogressbar();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddAddressPage(contextmain, token, "cart")));
        }
      } else {
        startprogressbar();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddAddressPage(contextmain, token, "cart")));
      }
    } else {
      print("hey");
    }
  }

  updatecart(List<dynamic> cartList) async {
    print(cartList);
    dynamic data = {
      "customer_id": user_ids,
      "items": cartList,
      "product_names": "product_names",
      "selectedSizes": "selectedSizes",
      "product_prices": "product_prices"
    };
    String body = json.encode(data);
    print(body);
    var url = Uri.parse(
        'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/inventory/add/product/to/cart');

    http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    // print(response.body);
    getAllCartproduct2();
  }

  getAllCartproduct2() async {
    startprogressbar();
    dynamic data = {"customer_id": user_ids};

    String body = json.encode(data);
    var url = Uri.parse(
        'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/inventory/list/product/to/cart');
    http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    if (response.statusCode == 200) {
      print(json.decode(utf8.decode(response.bodyBytes))["data"]);
      Map<String, dynamic> map =
          json.decode(utf8.decode(response.bodyBytes))["data"];
      if (map != null && map.isNotEmpty) {
        _cartList.clear();
        _cartList =
            json.decode(utf8.decode(response.bodyBytes))["data"]["cartItems"];
        if (_cartList.length > 0) {
        } else {
          _empty = true;
        }
        updatePrice();
        notifyListeners();
      } else {
        _empty = true;
        notifyListeners();
      }
    } else {
      apierror = true;
      notifyListeners();
      throw Exception('Failed to load album');
    }
    startprogressbar();
    notifyListeners();
  }

  bool imageprocessing = false;
  startprogressbar() {
    imageprocessing = !imageprocessing;
    notifyListeners();
  }

  void updatePrice() {
    double itp = 0;
    for (int i = 0; i < localCartList.length; i++) {
      // print("price  - -- "+ localCartList[i]["product_price"].toString());
      // print("localCartList -- count");
      print(localCartList[i]["count"].toString().replaceAll("€", ""));
      String p =
          localCartList[i]["product_price"].toString().replaceAll("€", "");
      String c = localCartList[i]["count"].toString();
      if (c[0].isNotEmpty && c[0] != null) ;
      double ic = double.parse(c);

      // if (c.isNotEmpty && c != null);
      if (p.isNotEmpty && p != null) ;
      double ip = double.parse(p);

      double it = ic * ip;
      itp = itp + it;
    }
    totalprice = itp.toStringAsFixed(2);
    notifyListeners();
  }

  changeLayout(int index) {
    // print("selected layout_id" + _getLayout[index]["_layout_id"]);
    print("_getLayout");
    print(_getLayout);
    print(_getItems);
    String layoutId = _getItems[_selectedIndex]["layout_id"];
    // print("layoutId layout_id = " +layoutId.toString());
    _getItems[_selectedIndex]["layout_id"] = _getLayout[index]["_layout_id"];
    for (int i = 0; i < _getLayout.length; i++) {
      if (i == index) {
        _getLayout[i]["_isSelected"] = true;
      } else {
        _getLayout[i]["_isSelected"] = false;
      }
    }
    int pagepostion = _selectedIndex;
    int count = 0;
    int usedImageCount = 0;
    int imagePstion = 0;
    if (layoutId == "2") {
      // print(_getItems[pagepostion]["imageModel"].imageType.length);
      for (int i = 2;
          i < _getItems[pagepostion]["imageModel"].imageType.length;
          i++) {
        if (_getItems[pagepostion]["imageModel"].imageType[i] != "") {
          if (_getItems[pagepostion]["imageModel"].imageType[i] == "phone") {
            for (int j = 0; j < mainImageList.length; j++) {
              if (_getItems[pagepostion]["imageModel"].fileuriPath[i] ==
                  mainImageList[j]["fileuriPath"]) {
                // print(" mainImageList[j].count - "+ mainImageList[j]["count"]);
                List<String> counuts = mainImageList[j]["count"].split(",");
                // print("counuts.length - "+counuts.length.toString());
                for (int k = 0; k < counuts.length; k++) {
                  print(k);
                  if (pagepostion == int.parse(counuts[k])) {
                    counuts.removeAt(k);
                    counuts.removeAt(k);
                    break;
                  }
                  k = k + 1;
                }
                mainImageList[j]["count"] = counuts.join(",");
              } else {
                print("k");
              }
            }
          } else {
            for (int j = 0; j < mainImageList.length; j++) {
              if (_getItems[pagepostion]["imageModel"].imageUrl[i] ==
                  mainImageList[j]["url_image"]) {
                // print(" mainImageList[j].count - "+ mainImageList[j]["count"]);
                List<String> counuts = mainImageList[j]["count"].split(",");
                // print("counuts.length - "+counuts.length.toString());
                for (int k = 0; k < counuts.length; k++) {
                  print(k);
                  if (pagepostion == int.parse(counuts[k])) {
                    counuts.removeAt(k);
                    counuts.removeAt(k);
                  }
                  k = k + 1;
                }
                // print("counuts.length - "+counuts.length.toString());
                mainImageList[j]["count"] = counuts.join(",");
              }
            }
          }
        }
        // print(i);
        print("fgfdfgf");
      }
      _getItems[pagepostion]["imageModel"].imageType.removeRange(2, 4);
      _getItems[pagepostion]["imageModel"].uint8listid.removeRange(2, 4);
      _getItems[pagepostion]["imageModel"].uint8list.removeRange(2, 4);
      _getItems[pagepostion]["imageModel"].imageUrl.removeRange(2, 4);
      _getItems[pagepostion]["imageModel"].fileuriPath.removeRange(2, 4);
      _getItems[pagepostion]["imageModel"].base64.removeRange(2, 4);
      _getItems[pagepostion]["imageModel"].imageQualityColor.removeRange(2, 4);
      _getItems[pagepostion]["imageModel"].fileuriPathlowreso.removeRange(2, 4);
      _getItems[pagepostion]["imageModel"].iscroppeds.removeRange(2, 4);
      _getItems[pagepostion]["imageModel"].aspectRatio.removeRange(2, 4);
    } else {
      // print(_getItems[pagepostion]["imageModel"].imageType.length);
      if (_getItems[pagepostion]["layout_id"] == "2") {
        for (int i = 0; i < 2; i++) {
          _getItems[pagepostion]["imageModel"].uint8listid.add("");
          _getItems[pagepostion]["imageModel"].uint8list.add(Uint8List(0));
          _getItems[pagepostion]["imageModel"].imageType.add("");
          _getItems[pagepostion]["imageModel"].imageUrl.add("");
          _getItems[pagepostion]["imageModel"].fileuriPath.add("");
          _getItems[pagepostion]["imageModel"].base64.add("");
          _getItems[pagepostion]["imageModel"].imageQualityColor.add("");
          _getItems[pagepostion]["imageModel"].fileuriPathlowreso.add("");
          _getItems[pagepostion]["imageModel"].iscroppeds.add("");
          _getItems[pagepostion]["imageModel"].aspectRatio.add("");
        }
      } else {}
    }
    notifyListeners();
  }

  addItemafterPhotoSelect(String layoutId) {
    // print("pooooooooooooooo");
    // print("selected_layout_id - "+layoutId);
    List<String> imageType = [];
    List<String> iscropped = [];
    List<String> aspectionRatio = [];
    List<String> imageUrl = [];
    List<String> imagefileuripath = [];
    List<String> imagefileuripathlowreso = [];
    List<String> imageQualityColor = [];
    List<String> base64 = [];
    List<Uint8List> uINtimagelist = [];
    List<String> uintid = [];
    int length = 0;
    // print("layout_id");
    // print(layoutId);
    switch (layoutId) {
      case "1":
        {
          length = 2;
          break;
        }
      case "2":
        {
          length = 4;
          break;
        }
      case "3":
        {
          length = 2;
          break;
        }
    }
    for (int i = 0; i < length; i++) {
      iscropped.add("");
      aspectionRatio.add("");
      imagefileuripathlowreso.add(io.File("abc.txt").uri.path);
      imagefileuripath.add(io.File("abc.txt").uri.path);
      imageType.add("");
      uINtimagelist.add(new Uint8List(0));
      base64.add("");
      uintid.add("");
      imageUrl.add("");
      imageQualityColor.add(getImageDpiColor(Size(0.0, 0.0)));
    }
    // print("_getItems.length - " + imageQualityColor.length.toString());
    ImageModel imageModel = new ImageModel(
        uINtimagelist,
        uintid,
        imageType,
        imageUrl,
        imagefileuripath,
        imagefileuripathlowreso,
        iscropped,
        aspectionRatio,
        imageQualityColor,
        base64);
    _getItems.add({
      "layout_id": layoutId,
      "isSelected": false,
      "imageModel": imageModel,
      "categoryType": categoryType
    });
    starting_page_count = _getItems.length;
    // print("getItems.length - " + starting_page_count.toString());
    notifyListeners();
  }

  late String canvasselectedSize;
  void goCUstomizationPage(
      BuildContext contextmain, BuildContext context, int index) async {
    // print(localCart
    // List.length);
    print(localCartList[index]['id']);
    startprogressbar();
    //print(cartList[index]["product_name"].toString().trim());

    MemotiDbProvider.db.getsingleCart(localCartList[index]["id"].toString()).then((value) async {
      // print(jsonDecode(value[0]["images"])["mainImageList"]);
      //       jsonDecode(value[0]["images"])['mainImageList']
      //           .forEach((v) {
      //         print(v);
      //       });
      // stopProgress();


    setCartIndex(localCartList[index]["id"]);
    switch (localCartList[index]["categorytype"]) {
      case "poster":
        {
          // List imageList = [];
          if (json.decode(value[0]["images"])['mainImageList'] !=
              null) {
            // imageList = new List.empty();
            List imageList = List.empty(growable: true);
            json
                .decode(value[0]["images"])['mainImageList']
                .forEach((v) {
              imageList.add(v);
            });
          }
          /* for(int i = 0;i<imageList.length;i++){
          if(imageList[i].image_type=="phone"){
            print("id - "+imageList[i].uintid);
            await MemotiDbProvider.db.getpicture(int.parse(imageList[i].uintid)).then((value) => imageList[i].uint8list = value);
          }
        }*/
          startprogressbar();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PosterAfterImageSelectionPage(
                      localCartList[index]["id"],
                      "cart",
                      contextmain,
                      imageList,
                      int.parse(localCartList[index]["max_photo"]),
                      int.parse(localCartList[index]["min_photo"]),
                      localCartList[index]["product_id"],
                      localCartList[index]["product_price"],
                      localCartList[index]["selectedSize"],
                      localCartList[index]["product_name"],
                      localCartList[index]["slovaktitle"])));
          break;
        }
      case "canvas":
        {
          // List imageList = [];
          if (json.decode(
                  localCartList[index]["productItem"])['product_item'] !=
              null) {
            // print(json.decode(localCartList[index]["productItem"])['product_item']);
            dynamic data = json
                .decode(localCartList[index]["productItem"])['product_item'];
            print("data");
            print(data);
            product = data["product"][0];
            /*    canvasselectedcolor = data["selectedcolor"];
          canvasselectedThickness = data["selectedThickness"];
          canvasselectedBorder = data["selectedborder"]; */
            canvasselectedSize = data["selectedSizes"];
            fromcanvasdetail = false;
          }
          if (json.decode(value[0]["images"])['mainImageList'] !=
              null) {
            // imagelist = new List.empty();
            List imageList = List.empty(growable: true);
            json
                .decode(value[0]["images"])['mainImageList']
                .forEach((v) {
              imageList.add(v);
            });
          }
          startprogressbar();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CanvasAfterImageSelectionPage(
                      creation_id!,
                      categoryType,
                      contextmain,
                      imageList,
                      max_photo,
                      min_photo,
                      product_id,
                      product_price,
                      selectedSize,
                      product_name,
                      slovaktitle)));
          // Navigator.push( context, MaterialPageRoute(builder: (context) => CanvasSizeSelectionPage(imageList,contextmain,-2,"cart")));

          break;
        }
      case "photobook":
        {
          List list = [];
          List imageList = [];
          // List itemList = [];

          if (json.decode(value[0]["images"])['mainImageList'] !=
              null) {
            // imageList = new List.empty();
            // List imageList = List.empty(growable: true);
            json
                .decode(value[0]["images"])['mainImageList']
                .forEach((v) {
              imageList.add(v);
              print('v v v v v v');
              print(v['id']);
            });
          }
          for(int i = 0;i<imageList.length;i++){
             if(imageList[i]["image_type"]=="phone"){
               print('imageList[i]["uintid"]');
               print(imageList[i]["uintid"]);
               if(imageList[i]["uintid"]!=null && imageList[i]["uintid"]!=''){
                await MemotiDbProvider.db.getpicture(int.parse(imageList[i]["uintid"])).then((value) => imageList[i]["uint8list"] = value);
                list.add(imageList[i]);
               }
             }
           };
           List itemList = List.empty(growable: true);
          if (json.decode(
                  localCartList[index]["productItem"])['product_item'] !=
              null) {
            // print(json.decode(localCartList[index]["productItem"])['product_item']);
            itemList = [];
            print(json
                .decode(localCartList[index]["productItem"])['product_item'].length);
                // return;
            // json.decode(localCartList[index]["productItem"])['product_item'].forEach((v) {
              for(var x = 0; x<json
                .decode(localCartList[index]["productItem"])['product_item'].length; x++){
              // print(v.toString());
              itemList.add(json
                .decode(localCartList[index]["productItem"])['product_item'][x]);
            };
          }
          print("1");
          List<String> imageQualityColor = [];
          List<Uint8List> uINtimagelist = [];
          List<String> uintid = [];
          List<String> imageType = [];
          List<String> iscropped = [];
          List<String> aspectRatioo = [];
          List<String> imagefileuripath = [];
          List<String> imagefileuripathlowreso = [];
          List<String> imageUrl = [];

          for(int i = 0;i<itemList.length;i++){
            for(int j = 0;j<itemList[i]["imageModel"]["uint8listid"].length;j++){
              for(int k = 0;k<list.length;k++){
                // print("2wwww");
                // print(list[k]["uintid"]);
                // print(itemList[i]["imageModel"]["uint8listid"][j]);
                if(itemList[i]["imageModel"]["uint8listid"][j]==list[k]["uintid"]){
                  // print("3wwww");
                  // print(list[k]["uint8list"]);
                  itemList[i]["imageModel"]["uint8list"][j] = list[k]["uint8list"];
                }
              }
            }
          }
          List itemlistup = [];
          // print(itemList);
          for (int i = 0; i < itemList.length; i++) {
            // print(itemList[i]["imageModel"]);
            if (i == 0) {
              itemlistup.add({
                "layout_id": itemList[i]["layout_id"],
                "isSelected": true,
                "imageModel": ImageModel.fromJson(itemList[i]["imageModel"]),
                "categoryType": "cart"
              });
            } else {
              itemlistup.add({
                "layout_id": itemList[i]["layout_id"],
                "isSelected": false,
                "imageModel": ImageModel.fromJson(itemList[i]["imageModel"]),
                "categoryType": "cart"
              });
            }
            /*   List<Uint8List> ll = [];
          for(int o = 0;o<itemList[i]["imageModel"]["uint8list"].length;o++){
            ll.add(itemList[i]["imageModel"]["uint8list"][o]);
          }
          uINtimagelist.addAll(*/ /*itemList[i]["imageModel"]["uint8list"]*/ /*ll);
          iscropped.addAll(itemList[i]["imageModel"]["iscroppeds"]);
          imageType.addAll(itemList[i]["imageModel"]["imageType"]);
          imageQualityColor.addAll(itemList[i]["imageModel"]["imageQualityColor"]);
          imageUrl.addAll(itemList[i]["imageModel"]["imageUrl"]);
          imagefileuripath.addAll(itemList[i]["imageModel"]["fileuriPath"]);
          imagefileuripathlowreso.addAll(itemList[i]["imageModel"]["fileuriPathlowreso"]);
          aspectRatioo.addAll(itemList[i]["imageModel"]["aspectRatio"]);
          uintid.addAll(itemList[i]["imageModel"]["uint8listid"]);*/
            /*    if(i==0){
            itemlistup.add({"layout_id":itemList[i]["layout_id"], "isSelected":true, "imageModel":ImageModel(uINtimagelist,uintid,imageType, imageUrl, imagefileuripath, imagefileuripathlowreso, iscropped,aspectRatioo,imageQualityColor), "categoryType":"cart"});
          }else{
            itemlistup.add({"layout_id":itemList[i]["layout_id"], "isSelected":false, "imageModel":ImageModel(uINtimagelist,uintid,imageType, imageUrl, imagefileuripath, imagefileuripathlowreso, iscropped,aspectRatioo,imageQualityColor), "categoryType":"cart"});

          }*/
          }
          startprogressbar();

          // print("itemList.length - "+itemList.length.toString());
          // print("mainimagelist.length - "+imageList.length.toString());
          // print(localCartList[index]["id"]);
          // print(json.decode(localCartList[index]["productItem"])['product_item'].length);
          // print(itemList.length);
          // print(itemlistup);
        // print(json.decode(value[0]["images"])['mainImageList']);
        print('imageList');
        print(imageList);
        // return;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PhotobookCustomizationPage(
                      contextmain,
                      imageList,
                      itemlistup,
                      "cart",
                      int.parse(localCartList[index]["max_photo"]),
                      int.parse(localCartList[index]["min_photo"]),
                      localCartList[index]["product_id"],
                      localCartList[index]["product_price"],
                      localCartList[index]["selectedSize"],
                      localCartList[index]["product_name"],
                      localCartList[index]["slovaktitle"],
                      localCartList[index]["id"])));
          break;
        }
    }

    });
    // startprogressbar();{
    // print(cartList[index]["product_name"].toString().trim());
    // setCartIndex(index);
    // switch(cartList[index]["product_type"]){

    //   case "poster":{
    //     List<AlbumWithMedia> imageList = [];
    //     List images = _cartList[index]["images"];
    //     setCartIndex(index);
    //     for(int i =0 ;i<images.length;i++){money_or_batter_array
    //       print("i"+i.toString());
    //       print(images[i]);
    //       await  _calculateImageDimension("https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //           images[i]).then((value) {

    //         imageList.add(new AlbumWithMedia((10000 + i).toString(), images[i],
    //             new DateTime.now(),
    //             new io.File("a.txt").uri.path,
    //             new io.File("a.txt").uri.path,
    //             new Uint8List(0), "",
    //             value,
    //             "memoti",
    //             "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //                 images[i],
    //             "1",
    //             "false",
    //             "",
    //             false));

    //         if(images.length-1 == i){
    //           startprogressbar();
    //           Navigator.push( context, MaterialPageRoute(builder: (context) => PosterAfterImageSelectionPage(-1,"cart",contextmain,imageList,int.parse(_cartList[index]["max_photo"]),int.parse(_cartList[index]["min_photo"]),_cartList[index]["product_id"],_cartList[index]["product_prices"],
    //               _cartList[index]["selectedSizes"],_cartList[index]["product_names"],_cartList[index]["slovaktitle"])));

    //         }
    //       });
    //     }
    //     break;
    //   }

    //   case "canvas":{
    //     List<AlbumWithMedia> imageList = [];
    //     List images = _cartList[index]["images"];
    //     setCartIndex(index);
    //     for(int i =0 ;i<images.length;i++){
    //       print("i"+i.toString());
    //       print(images[i]);
    //       await  _calculateImageDimension("https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //           images[i]).then((value) {

    //         imageList.add(new AlbumWithMedia((10000 + i).toString(), images[i],
    //             new DateTime.now(),
    //             new io.File("a.txt").uri.path,
    //             new io.File("a.txt").uri.path,
    //             new Uint8List(0), "",
    //             value,
    //             "memoti",
    //             "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //                 images[i],
    //             "1",
    //             "false",
    //             "",
    //             false));

    //         if(images.length-1 == i){
    //           setcanvasProduct(_cartList[index]["product"]);
    //           canvasselectedcolor = _cartList[index]["selectedcolor"];
    //           canvasselectedThickness = _cartList[index]["selectedThickness"];
    //           canvasselectedBorder = _cartList[index]["selectedborder"];
    //           canvasselectedSize = _cartList[index]["selectedSizes"];
    //           fromcanvasdetail = false;
    //           startprogressbar();
    //           Navigator.push( context, MaterialPageRoute(builder: (context) => CanvasSizeSelectionPage(imageList,contextmain,-1,"cart")));

    //         }
    //       });
    //     }
    //     break;
    //   }
    //   case "calendar":{

    //     if(cartList[index]["product_names"].toString().trim()=="Poster"){
    //       List<AlbumWithMedia> imageList = [];
    //       String calendarDate  = _cartList[index]["calendarDate"];
    //       List images = _cartList[index]["images"];
    //       DateTime dateTime = DateFormat("MMMM , yyyy").parse(calendarDate);
    //       setCalendarDate(dateTime);

    //       for(int i =0 ;i<images.length;i++){
    //         print("i"+i.toString());
    //         print(images[i]);
    //         await  _calculateImageDimension("https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //             images[i]).then((value) {

    //           imageList.add(new AlbumWithMedia((10000 + i).toString(), images[i],
    //               new DateTime.now(),
    //               new io.File("a.txt").uri.path,
    //               new io.File("a.txt").uri.path,
    //               new Uint8List(0), "",
    //               value,
    //               "memoti",
    //               "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //                   images[i],
    //               "1",
    //               "false",
    //               "",
    //               false));

    //           if(images.length-1 == i){
    //             startprogressbar();
    //             Navigator.push( context, MaterialPageRoute(builder: (context) => CalendarPosterPreviewPage(-1,"cart",contextmain, imageList ,int.parse(_cartList[index]["max_photo"]),int.parse(_cartList[index]["min_photo"]),_cartList[index]["product_id"],_cartList[index]["product_prices"],
    //                 _cartList[index]["selectedSizes"],_cartList[index]["product_names"],_cartList[index]["slovaktitle"])));

    //           }
    //         });
    //       }
    //     }else{
    //       List<AlbumWithMedia> imageList = [];
    //       String calendarDate  = _cartList[index]["calendarDate"];
    //       List images = _cartList[index]["images"];
    //       for(int i =0 ;i<images.length;i++){
    //         print("i"+i.toString());
    //         print(images[i]);
    //         await  _calculateImageDimension("https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //             images[i]).then((value) {

    //           imageList.add(new AlbumWithMedia(
    //               (10000 + i).toString(),
    //               images[i],
    //               new DateTime.now(),
    //               new io.File("a.txt").uri.path,
    //               new io.File("a.txt").uri.path,
    //               new Uint8List(0), "",
    //               value,
    //               "memoti",
    //               "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //                   images[i],
    //               "1",
    //               "false",
    //               "",
    //               false));

    //           if(images.length-1 == i){
    //             preparecalenderList(imageList,calendarDate,contextmain,context,index);
    //           }
    //         });
    //       }
    //     }
    //     break;
    //   }
    //   case "photobook":{
    //     String width = _cartList[index]["selectedSizes"].split("x")[0];
    //     String height = _cartList[index]["selectedSizes"].split("x")[1].split("cm")[0];
    //     selected_width = double.parse(width);
    //     selected_height = double.parse(height);
    //     List<AlbumWithMedia> imageList = [];
    //     List<PhotoBookCustomModel> itemList = [];
    //     List images = _cartList[index]["images"];
    //     List layoutid = _cartList[index]["layout_id"];

    //     print(images.length);
    //     for(int i =0 ;i<images.length;i++){
    //       print("i"+i.toString());
    //       //print(images[i]);
    //       await  _calculateImageDimension("https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //           images[i]).then((value) {

    //         imageList.add(new AlbumWithMedia(
    //             (10000 + i).toString(),
    //             images[i],
    //             new DateTime.now(),
    //             new io.File("a.txt").uri.path,
    //             new io.File("a.txt").uri.path,
    //             new Uint8List(0), "",
    //             value,
    //             "memoti",
    //             "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
    //                 images[i],
    //             "1",
    //             "false",
    //             "",
    //             false));

    //         if(images.length-1 == i){
    //           setitemlist(contextmain,imageList,layoutid,itemList,index,context);
    //         }
    //       });
    //     }
    //     break;
    //   }
    // }
  }

  void setitemlist(BuildContext contextmain, imageList, List<dynamic> layoutid,
      itemList, int index, BuildContext context) {
    // int ii = 0;
    // int page_pos = 0;
    // print(imageList.length);
    // for(int i = 0; i<layoutid.length;i++){
    //   print("layoutid - "+layoutid[i]);

    //   List<String> isCropped = [];
    //   List<String> aspectRatio = [];
    //   List<String> imageType = [];
    //   List<String> imageUrl = [];
    //   List<String> imagefileuripath = [];
    //   List<String> imagefileuripathlowreso = [];
    //   List<String> imageQualityColor = [];
    //   List<Uint8List> uINtimagelist = [];
    //   List<String> uintid = [];

    //   switch(layoutid[i].toString()){
    //     case "1":{
    //       if(ii<imageList.length){
    //         imageType.add(imageList[ii].image_type);
    //         uINtimagelist.add(imageList[ii].uint8list);
    //         uintid.add(imageList[ii].uintid);
    //         isCropped.add(imageList[ii].isCropped);
    //         aspectRatio.add(imageList[ii].aspectRatio);
    //         imageUrl.add(imageList[ii].url_image);
    //         imagefileuripath.add(imageList[ii].lowresofileuriPath);
    //         imagefileuripathlowreso.add(imageList[ii].fileuriPath);
    //         imageQualityColor.add(getImageDpiColor(imageList[ii].size));
    //         imageList[ii].count = page_pos.toString()+","+"0";
    //       }

    //       ii = ii+1;

    //       if(ii<imageList.length){
    //         uINtimagelist.add(imageList[ii].uint8list);
    //         uintid.add(imageList[ii].uintid);
    //         imageType.add(imageList[ii].image_type);
    //         imageUrl.add(imageList[ii].url_image);
    //         isCropped.add(imageList[ii].isCropped);
    //         aspectRatio.add(imageList[ii].aspectRatio);
    //         imagefileuripath.add(imageList[ii].lowresofileuriPath);
    //         imagefileuripathlowreso.add(imageList[ii].fileuriPath);
    //         imageQualityColor.add(getImageDpiColor(imageList[ii].size));
    //         imageList[ii].count = page_pos.toString()+","+"1";
    //       }

    //       ii = ii+1;
    //       break;
    //     }
    //     case "2":{
    //       print("ii - "+ii.toString());

    //       if(ii<imageList.length){
    //         uINtimagelist.add(imageList[ii].uint8list);
    //         uintid.add(imageList[ii].uintid);
    //         imageType.add(imageList[ii].image_type);
    //         isCropped.add(imageList[ii].isCropped);
    //         aspectRatio.add(imageList[ii].aspectRatio);
    //         imageUrl.add(imageList[ii].url_image);
    //         imagefileuripath.add(imageList[ii].lowresofileuriPath);
    //         imagefileuripathlowreso.add(imageList[ii].fileuriPath);
    //         imageQualityColor.add(getImageDpiColor(imageList[ii].size));
    //         imageList[ii].count = page_pos.toString()+","+"0";
    //       }

    //       ii = ii+1;
    //       print("ii - "+ii.toString());
    //       if(ii<imageList.length){
    //         uINtimagelist.add(imageList[ii].uint8list);
    //         uintid.add(imageList[ii].uintid);
    //         imageUrl.add(imageList[ii].url_image);
    //         imageType.add(imageList[ii].image_type);
    //         isCropped.add(imageList[ii].isCropped);
    //         aspectRatio.add(imageList[ii].aspectRatio);
    //         imagefileuripath.add(imageList[ii].lowresofileuriPath);
    //         imagefileuripathlowreso.add(imageList[ii].fileuriPath);
    //         imageQualityColor.add(getImageDpiColor(imageList[ii].size));
    //         imageList[ii].count = page_pos.toString()+","+"1";
    //       }

    //       ii = ii+1;
    //       print("ii - "+ii.toString());
    //       if(ii<imageList.length){
    //         uINtimagelist.add(imageList[ii].uint8list);
    //         uintid.add(imageList[ii].uintid);
    //         isCropped.add(imageList[ii].isCropped);
    //         aspectRatio.add(imageList[ii].aspectRatio);
    //         imageType.add(imageList[ii].image_type);
    //         imageUrl.add(imageList[ii].url_image);
    //         imagefileuripath.add(imageList[ii].lowresofileuriPath);
    //         imagefileuripathlowreso.add(imageList[ii].fileuriPath);
    //         imageQualityColor.add(getImageDpiColor(imageList[ii].size));
    //         imageList[ii].count = page_pos.toString()+","+"2";
    //       }

    //       ii = ii+1;
    //       print("ii - "+ii.toString());
    //       if(ii<imageList.length){
    //         uINtimagelist.add(imageList[ii].uint8list);
    //         uintid.add(imageList[ii].uintid);
    //         imageType.add(imageList[ii].image_type);
    //         imageUrl.add(imageList[ii].url_image);
    //         isCropped.add(imageList[ii].isCropped);

    //         aspectRatio.add(imageList[ii].aspectRatio);
    //         imagefileuripath.add(imageList[ii].lowresofileuriPath);
    //         imagefileuripathlowreso.add(imageList[ii].fileuriPath);
    //         imageQualityColor.add(getImageDpiColor(imageList[ii].size));
    //         imageList[ii].count = page_pos.toString()+","+"3";
    //       }

    //       ii = ii+1;
    //       print("ii - "+ii.toString());
    //       break;
    //     }
    //     case "3":{
    //       if(ii<imageList.length){
    //         imageType.add(imageList[ii].image_type);
    //         imageUrl.add(imageList[ii].url_image);
    //         uINtimagelist.add(imageList[ii].uint8list);
    //         uintid.add(imageList[ii].uintid);
    //         aspectRatio.add(imageList[ii].aspectRatio);
    //         isCropped.add(imageList[ii].isCropped);
    //         imagefileuripath.add(imageList[ii].lowresofileuriPath);
    //         imagefileuripathlowreso.add(imageList[ii].fileuriPath);
    //         imageQualityColor.add(getImageDpiColor(imageList[ii].size));
    //         imageList[ii].count = page_pos.toString()+","+"0";
    //       }
    //       ii = ii+1;
    //       if(ii<imageList.length){
    //         imageType.add(imageList[ii].image_type);
    //         imageUrl.add(imageList[ii].url_image);
    //         uINtimagelist.add(imageList[ii].uint8list);
    //         uintid.add(imageList[ii].uintid);
    //         isCropped.add(imageList[ii].isCropped);
    //         aspectRatio.add(imageList[ii].aspectRatio);
    //         imagefileuripath.add(imageList[ii].lowresofileuriPath);
    //         imagefileuripathlowreso.add(imageList[ii].fileuriPath);
    //         imageQualityColor.add(getImageDpiColor(imageList[ii].size));
    //         imageList[ii].count = page_pos.toString()+","+"1";
    //       }
    //       ii = ii+1;
    //       break;
    //     }
    //   }
    //   page_pos = page_pos+1;
    //   ImageModel imageModel = new ImageModel(uINtimagelist,uintid,imageType, imageUrl,imagefileuripath, imagefileuripathlowreso,isCropped,aspectRatio, imageQualityColor);
    //   itemList.add(PhotoBookCustomModel(layoutid[i].toString(), false, imageModel, "Photobook"));
    // }
    // for(int i = 0;i<itemList.length;i++){
    //   print("length - "+itemList[i]["imageModel"].imageUrl.length.toString());
    // }
    // Map<String, String> map = new HashMap<String, String>();
    // for(int i = 0;i<imageList.length;i++){
    //   print("i - "+i.toString());
    //   print("imageList[i].url_image - "+imageList[i].url_image);
    //   print("imageList[i].count - "+imageList[i].count);
    //   if(!map.containsKey(imageList[i].url_image)){
    //    map.putIfAbsent(imageList[i].url_image, () => imageList[i].count);
    //   }else{
    //     print("i update - "+i.toString());
    //     print(imageList[i].url_image);
    //     map.update(imageList[i].url_image, (value) => value+","+imageList[i].count);

    //     print("i update2 - "+i.toString());
    //   }
    // }
    // int length = map.length;
    // print(length);
    // print(imageList.length);
    // imageList.removeRange(length, imageList.length);
    // for(int i = 0;i<imageList.length;i++){
    //   imageList[i].count = map[imageList[i].url_image];
    // }
    // print(imageList.length);

    // startprogressbar();
    // setCartIndex(index);
    // print(_cartList[index]["selectedSize"]);
    // Navigator.push( context, MaterialPageRoute(builder: (context) => PhotobookCustomizationPage(contextmain,imageList, itemList, "cart",
    //     int.parse(_cartList[index]["max_photo"]),int.parse(_cartList[index]["min_photo"]),_cartList[index]["product_id"],_cartList[index]["product_prices"],
    //     _cartList[index]["selectedSizes"],_cartList[index]["product_names"],_cartList[index]["slovaktitle"],-1)));
  }
  late int cartIndex;
  setCartIndex(index) {
    cartIndex = index;
  }

  static const String _graphApiEndpoint = 'https://graph.facebook.com/v3.1';
  getFacebookPhoto() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(UiData.facebook_token);
    String user_id = prefs.getString(UiData.user_id);
    var url = Uri.parse(
        "https://graph.facebook.com/${user_id}/photos?fields=height,width&access_token=${token}");
    final graphResponse = await http.get(url);

    Map<String, dynamic> profile = jsonDecode(graphResponse.body);
    print(profile.toString());
  }

  Future<AlbumPaging?> fetchAlbums([String? nextUrl]) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(UiData.facebook_token) ?? "";
    String user_id = prefs.getString(UiData.facebook_user_id) ?? "";
    print(token);
    print(user_id);
    if (token != "" && user_id != "") {
    } else {
      facebook_login(context);
    }
    // getFacebookPhoto();
    // return null;
    //String permsiurl = "https://graph.facebook.com/v11.0/${user_id}/albums";
    // String permsiurl = "https://graph.facebook.com/v11.0/${user_id}/photos?access_token=${token}";
    // String permsiurl = "https://graph.facebook.com/v12.0/${user_id}/photos/uploaded";
    String permsiurl = "https://graph.facebook.com/v2.12/me?fields=albums";
    String url = nextUrl ??
        '$_graphApiEndpoint/me/albums?fields=cover_photo{source},id,name,count&format=json';
    http.Response response = await http
        .get(Uri.parse(permsiurl), headers: {'Authorization': 'Bearer $token'});
    Map<String, dynamic> body = json.decode(response.body);
    print("albums  -  " + token);
    print("albums  -  " + body.toString());
    print("response.statusCode  -  " + response.statusCode.toString());

    if (response.statusCode != 200) {
      throw GraphApiException(body['error']['message'].toString());
    }
    print(body);
    // return AlbumPaging.fromJson(body);
  }

  //////////////
  ///Account////
  //////////////
  void _showToast(BuildContext context, String error) {
    print("showtoasterror");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  }

  bool firstapirun = false;
  bool _busy = false;
  bool get busy => _busy;
  bool _isloggedIn = false;
  bool get IsloggedIn => _isloggedIn;
  // final FacebookLogin facebookSignIn = new FacebookLogin();
  final facebookSignIn = FacebookLogin();
  Future facebook_logins(context) async {
    print('open fb');
    await facebookSignIn.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
      FacebookPermission.userPhotos ,
    ]);
    await _updateLoginInfo();
  }
  Future<void> _updateLoginInfo() async {
    final token = await facebookSignIn.accessToken;
    FacebookUserProfile? profile;
    String? email;
    String? imageUrl;

    if (token != null) {
      profile = await facebookSignIn.getUserProfile();
      if (token.permissions.contains(FacebookPermission.email.name)) {
        email = await facebookSignIn.getUserEmail();
      }
      imageUrl = await facebookSignIn.getProfileImageUrl(width: 100);
    }
    print(token);
    print(profile);
    print(email);
    print(imageUrl);
  }

  Future facebook_login(context) async {
    // final result = await facebookSignIn.logIn(['email', 'public_profile', 'user_photos']);
    // _showToast(context, "result: ${result.status.toString()}");
    // _showToast(context, "result status: ${result.toString()}");
    // switch (result.status) {
    //   case FacebookLoginStatus.loggedIn:
    //     final SharedPreferences prefs = await _prefs;
    //     final FacebookAccessToken accessToken = result.accessToken;

    //     final permissionResponse = await http.get(Uri.parse(
    //         'https://graph.facebook.com/v8.0/me/permissions?access_token=${accessToken.token}'));
    //     print("permissionResponse");
    //     print(permissionResponse.body);
    //     // _showToast(context, "permission response: ${permissionResponse.body.toString()}");
    //     final graphResponse = await http.get(Uri.parse(
    //         'https://graph.facebook.com/v8.0/me?fields=name,first_name,last_name,email,user_photos,user_friends,public_profile,picture.height(200)&access_token=${accessToken.token}'));
    //     // _showToast(context, "response: ${graphResponse.body.toString()}");

    //     Map<dynamic, dynamic> profile = jsonDecode(graphResponse.body);
    //     print(profile.toString());

    //     if (profile.containsKey("email")) {
    //       if (profile["email"] == "" || profile["email"] == null) {

    //         _busy = false;
    //         notifyListeners();
    //         _showToast(
    //             context,
    //             "Facebook email is not verified. So we are not able login. Please try another way. email :-" +
    //                 profile["email"]);
    //       } else {
    //         print("picture" + profile["picture"]["data"]["url"].toString());
    //         fblogin(profile, accessToken.token);
    //         prefs.setString(UiData.picture, profile["picture"]["data"]["url"]);
    //         prefs.setString(UiData.facebook_token, accessToken.token);
    //         prefs.setString(UiData.facebook_user_id, accessToken.userId);
    //         _busy = false;
    //         notifyListeners();
    //       }
    //     } else {
    //       _busy = false;
    //       notifyListeners();
    //       _showToast(context,
    //           "Facebook email is not verified.So we are not able login.Please try another way.");
    //     }

    //     break;
    //   case FacebookLoginStatus.cancelledByUser:
    //     _showToast(context, 'Login cancelled by the user.');
    //     print('Login cancelled by the user.');
    //     break;
    //   case FacebookLoginStatus.error:
    //     _showToast(
    //         context,
    //         'Something went wrong with the login process.\n'
    //         'Here\'s the error Facebook gave us: ${result.errorMessage}');
    //     print('Something went wrong with the login process.\n'
    //         'Here\'s the error Facebook gave us: ${result.errorMessage}');
    //     break;
    // }
  }

  fblogin(profile, token) async {
    // print(token);
    // print(profile["name"]);
    // print(profile["email"]);
    // print(profile["picture"]["data"]["url"]); 9il-, m

    // print(profile["id"]);
    dynamic data = {
      "token": token,
      "title": profile["name"],
      "email": profile["email"],
      "picture": profile["picture"]["data"]["url"],
      "id": profile["id"],
      "situation": "Active",
      "address": []
    };
    String body = json.encode(data);
    print(body);
    http.Response response = await http.post(
        Uri.parse(
            'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/people/fb/login/user/people'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    if (response.statusCode == 200) {
      print(json.decode(response.body)["data"]);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;

      Map<dynamic, dynamic> responseData = jsonDecode(response.body);
      var token = responseData["token"];
      var status = responseData["status"];
      int code = responseData["code"];
      if (status == "success") {
        print(responseData);
        Map<dynamic, dynamic> dataObject = responseData["data"];
        name = dataObject["title"];
        email = dataObject["email"];
        var mobile = dataObject["mobile"];
        var password = responseData["password"];
        var situation = responseData["situation"];
        var pi = dataObject["pi"].toString();
        address = "";
        if (dataObject["address"] != null) {
          address = dataObject["address"].toString();
        }
        print("email - " + email);
        print("pi - " + pi);
        prefs.setString(UiData.user_id, pi);
        prefs.setString(UiData.email, email);
        prefs.setString(UiData.token, token);
        prefs.setString(UiData.name, name);
        prefs.setString(UiData.address, address);
        // getuserId();
      } else {}
    } else {
      throw Exception('Failed to load album');
    }
  }

  var name, email, image, user_ids, token, address;
  get a_name => name;
  get a_email => email;
  get a_image => image;
  get a_user_ids => user_ids;
  get a_token => token;
  get a_address => address;

  getemail() async {
    final SharedPreferences prefs = await _prefs;
    String email = prefs.getString(UiData.email) ?? "";
    return email;
  }

  getuserId() async {
    final SharedPreferences prefs = await _prefs;
    String userId = prefs.getString(UiData.user_id) ?? "";
    if (userId == "") {
      _busy = false;
      _isloggedIn = false;
      notifyListeners();
    } else {
      _busy = false;
      _isloggedIn = true;
      name = prefs.getString(UiData.name) ?? "";
      email = prefs.getString(UiData.email) ?? "";
      image = prefs.getString(UiData.picture) ?? "";
      user_ids = prefs.getString(UiData.user_id) ?? "";
      token = prefs.getString(UiData.token) ?? "";
      address = prefs.getString(UiData.address) ?? "";
      notifyListeners();
    }
  }

//////////////
  ///Payment Method
//////////////

  String apiResponse = "";
  bool showProgress = false;
  List cards = [];

  bool fetchcard = true;

  bool card = true;
  bool cod = false;
  dynamic cardDetail;
  dynamic get getcardDetail => cardDetail;
  late String cashdelprice;
  String get cashPrice => cashdelprice;

  setcardDetail(card) {
    cardDetail = card;
  }

  setCashondeleveryPrice(card) {
    cashdelprice = card;
  }

  fetchAllDatacards() async {
    fetchcard = false;
    startProgress();
    // notifyListeners();
    cards = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String customer_id = preferences.get(UiData.user_id) ?? "";
    token = preferences.get(UiData.token) ?? "";
    Map data = {
      "customer_id": customer_id,
    };
    String body = json.encode(data);
    var url = Uri.parse(
        'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/cardlisting');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
        body: body);
    print("List of cards");
    print(response.body);
    if (response.statusCode == 200) {
      List ll = [];
      ll = json.decode(response.body)["data"];
      if (ll.length > 0) {
        apiResponse = "responsesuccess";
        for (int i = 0; i < ll.length; i++) {
          var ee = ll[i]["cardDetail"];
          if (i == 0) {
            cards.add({
              "cardHolderName": ee["cardHolderName"],
              "expiryDate": ee["expiryDate"],
              "cvvCode": ee["cvvCode"],
              "cardNumber": ee["cardNumber"],
              "ii": ll[i]["ii"],
              "isSelected": true
            });
          } else {
            cards.add({
              "cardHolderName": ee["cardHolderName"],
              "expiryDate": ee["expiryDate"],
              "cvvCode": ee["cvvCode"],
              "cardNumber": ee["cardNumber"],
              "ii": ll[i]["ii"],
              "isSelected": false
            });
          }
        }
      } else {
        apiResponse = "nodata";
      }
    } else {
      apiResponse = "apierror";
    }

    notifyListeners();
    fetchCashonDelChareApiData();
  }

  String cash_on_deleviery_price = "";
  fetchCashonDelChareApiData() async {
    var url = Uri.parse(
        'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/inventory/codfees/');
    final response = await http.get(url);
    stopProgress();
    if (response.statusCode == 200) {
      // print(response.body);
      Map<String, dynamic> map = json.decode(utf8.decode(response.bodyBytes));
      cash_on_deleviery_price = map["data"]["Items"][0]["price"];
      cash_on_deleviery_price =
          double.parse(cash_on_deleviery_price).toStringAsFixed(2);
      notifyListeners();
    }
  }

  int radioValue = 0;
  int choise = 0;
  handleRadioValueChange(int value) {
    print(value);
    radioValue = value;
    switch (radioValue) {
      case 0:
        {
          break;
        }
      case 1:
        {
          break;
        }
    }
    notifyListeners();
  }

  changecard(int index) {
    print(cards.length);
    print(index);
    for (int i = 0; i < cards.length; i++) {
      print(i);
      if (i == index) {
        cards[i]["isSelected"] = true;
      } else {
        cards[i]["isSelected"] = false;
      }
    }
    notifyListeners();
  }

  deleteCard(int index, String cardId) async {
    cards.removeAt(index);
    print(cardId);
    print(index);
    dynamic data = {"cardid": cardId};
    String body = json.encode(data);
    print(body);
    print(token);
    var url = Uri.parse(
        'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/deletecard');
    http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": token,
        },
        body: body);
    // print(response.body);
    notifyListeners();
  }

  startProgress() {
    showProgress = true;
    //notifyListeners();
  }

  stopProgress() {
    showProgress = false;
    notifyListeners();
  }

  void setcheckbox(bool value, String what) {
    switch (what) {
      case "cod":
        {
          if (value) {
            cod = true;
            card = false;
          } else {
            cod = false;
            card = true;
          }
          break;
        }
      case "card":
        {
          if (value) {
            cod = false;
            card = true;
          } else {
            cod = true;
            card = false;
          }
          break;
        }
    }
    notifyListeners();
  }

  //////////////
////Order Deatil/////
/////////////
  bool waiting = false;
  bool success = false;
  bool agree = false;
  bool firstcall = false;
  List items = [];
  String total_price = "";
  List pdfItems = [];
  List<String> uri = [];
  late Map dddata;
  TextEditingController cvvController = TextEditingController();
  bool pdfGenrated = false;
  bool submitCLick = false;

  void setcheckboxOrderDeatail(bool value) {
    print(value);
    agree = value;
    notifyListeners();
  }

  void closedwaiting() {
    waiting = false;
    notifyListeners();
  }

  void setforwaiting() {
    waiting = true;
    notifyListeners();
  }

  changeShippigPrice() {
    String ship_price = getshippingDetail["price"].toString();
    String tot_price = getpricesummary["price"];
    double price = double.parse(ship_price);
    double pp = double.parse(tot_price);
    double ppp = price + pp;
    if (!card) {
      ppp = ppp + double.parse(cashPrice);
    }
    total_price = ppp.toStringAsFixed(2);
  }

  late String user_id;
  bool pdfuploadng = false;

  pdfuploading() {
    return pdfuploadng;
  }

  Future<void> initOrderDeatail(bool card, BuildContext context) async {
    this.card = card;
    firstcall = true;
    pdfuploadng = true;
    changeShippigPrice();
    cartList.clear();
    pdfItems.clear();
    uri.clear();
/*    StripePayment.setOptions(
      //StripeOptions(publishableKey: "pk_test_51GxtPhGXrIPXXF3qyLJfrZKWSlSIq6iQNCD2XiyGAimnCvv2kE9cmgCIMcO3uzId0LS2vRKL7XHiAfoklrL5YEKU00GM0wkpdR",
        StripeOptions(
            publishableKey:
            "pk_test_51HzceuEwF66xBR4clyYKhf4KnccDrC2D9fWn0NpeIC2iHwfWjbe9NKDpJtANbZh2wZCyNFvL7A8rV9QzJv2LmbO100DBX1Uia4",
            merchantId: "Test",
            androidPayMode: 'test'));*/
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.get(UiData.user_id) ?? "";
    token = preferences.get(UiData.token) ?? "";
    // Temp
    MemotiDbProvider.db.getAllCart().then((value) async {
      localCartList = value;
      for (int i = 0; i < value.length; i++) {
        String? categorytype = "";
        String selectedSizes = "";
        String order_status = "";
        String min_photo = "";
        String product_id = "";
        String count = "";
        String pdfUrl = "";
        String slovaktitle = "";
        String product_price = "";
        String max_photo = "";
        if (value[i]["categorytype"] != null) {
          categorytype = value[i]["categorytype"];
        }
        if (value[i]["selectedSizes"] != null) {
          selectedSizes = value[i]["selectedSizes"];
        }
        if (value[i]["order_status"] != null) {
          order_status = value[i]["order_status"];
        }
        if (value[i]["min_photo"] != null) {
          min_photo = value[i]["min_photo"];
        }
        if (value[i]["product_id"] != null) {
          product_id = value[i]["product_id"];
        }
        if (value[i]["count"] != null) {
          count = value[i]["count"];
        }
        if (value[i]["pdfUrl"] != null) {
          pdfUrl = value[i]["pdfUrl"];
        }
        if (value[i]["slovaktitle"] != null) {
          slovaktitle = value[i]["slovaktitle"];
        }
        if (value[i]["product_price"] != null) {
          product_price = value[i]["product_price"];
        }
        if (value[i]["max_photo"] != null) {
          max_photo = value[i]["max_photo"];
        }
        cartList.add({
          "product_type": categorytype,
          "selectedSizes": selectedSize,
          "min_photo": min_photo,
          "product_names": product_name,
          "product_id": product_id,
          "count": count,
          "pdf_url": pdfUrl,
          "slovaktitle": slovaktitle,
          "product_prices": product_price,
          "max_photo": max_photo,
          "local_cart_id": value[i]["id"],
        });
      }
      dynamic data = {
        "customer_id": user_id,
        "items": cartList,
        "product_names": "",
        "selectedSizes": "",
        "product_prices": ""
      };
      String body = json.encode(data);
      print('BODY - ' + body.toString());
      var url = Uri.parse(
          "https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/inventory/add/product/to/cart");

      http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);

      pdfuploadng = false;
      notifyListeners();
      // print(response.body);

      getCartlist();
    });

    notifyListeners();
  }

  getCartlist() async {
    dynamic data = {"customer_id": user_id};
    String body = json.encode(data);
    var url = Uri.parse(
        "https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/inventory/list/product/to/cart");

    http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    print(body);
    print(response.statusCode);
    pdfuploadng = false;
    _cartList =
        json.decode(utf8.decode(response.bodyBytes))["data"]["cartItems"];
    dddata = json.decode(utf8.decode(response.bodyBytes))["data"];
    print("cartlist - = " + _cartList.length.toString());
    print("dddata - = " + dddata.toString());
  }

/////////////////////////
////Shipping address/////
/////////////////////////

  // bool firstcall = false;
  bool dataGet = false;

  //List items = [];

  Future<void> init() async {
    items = [];
    firstcall = true;
    final response = await http.get(Uri.parse(
        'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/inventory/shippingmethod'));
    if (response.statusCode == 200) {
      // print(response.body);
      List ll = [];
      Map<String, dynamic> map = json.decode(utf8.decode(response.bodyBytes));
      ll = map["data"]["Items"];
      if (ll.length > 0) {
        apiResponse = "responsesuccess";
        for (int i = 0; i < ll.length; i++) {
          var ee = ll[i];
          items.add({
            "ii": ee["ii"],
            "commission_rate": ee["commission_rate"],
            "price": ee["price"],
            "it": ee["it"],
            "title": ee["title"],
            "itsdefault": ee["itsdefault"].toString(),
            "slovak": ee["slovak"]
          });

          /*if(i==0){
            items.add({"ii":ee["ii"], "commission_rate":ee["commission_rate"], "price":ee["price"], "it":ee["it"], "title":ee["title"], "itsdefault":ee["itsdefault"]});
          }else{
            items.add({"ii":ee["ii"], "commission_rate":ee["commission_rate"], "price":ee["price"], "it":ee["it"], "title":ee["title"], "isSelected":false});
          }*/
        }
      } else {
        apiResponse = "nodata";
      }
    } else {
      apiResponse = "apierror";
    }
    notifyListeners();
  }

  dynamic shippingDetail;
  dynamic get getshippingDetail => shippingDetail;
  setShippingDetail(shipping) {
    shippingDetail = shipping;
  }

  changeShippingAddress(int index) {
    print(items.length);
    print(index);
    for (int i = 0; i < items.length; i++) {
      print(i);
      if (i == index) {
        items[i]["itsdefault"] = "true";
      } else {
        items[i]["itsdefault"] = "false";
      }
    }
    notifyListeners();
  }

//////////////
////Order/////
/////////////
  var orderDataitem = null;
  late String shipment_charges;
  late String discount;
  //String total_price;
  late BuildContext contextmain;
  var ii;
  var currency;
  var payment_method;
  var customer_id;
  var orderid;

  addDataTocart(context) async {
    print(ordercarModel[0]["cartItems"]);
    // return;
    if (ordercarModel.length > 0) {
      for (int i = 0; i < ordercarModel[0]["cartItems"].length; i++) {
        var aa = ordercarModel[0]["cartItems"][i]["images"];
        var pp = ordercarModel[0]["cartItems"][i]["productItem"];
        if (aa != null) {
        } else {
          aa == "";
        }
        if (pp != null) {
        } else {
          pp == "";
        }
        // Map<String, dynamic>  map = {
        //   "categorytype":ordercarModel[0]["cartItems"][i]["product_type"],
        //   // "id":ordercarModel[0]["cartItems"][i]["id"],
        //   "images":aa,
        //   "productItem":pp,
        //   "selectedSize":ordercarModel[0]["cartItems"][i]["selectedSizes"],
        //   "max_photo":ordercarModel[0]["cartItems"][i]["max_photo"],
        //   "min_photo":ordercarModel[0]["cartItems"][i]["min_photo"],
        //   "product_id":ordercarModel[0]["cartItems"][i]["product_id"],
        //   "product_price":ordercarModel[0]["cartItems"][i]["product_prices"],
        //   "product_name":ordercarModel[0]["cartItems"][i]["product_names"],
        //   "slovaktitle":ordercarModel[0]["cartItems"][i]["slovaktitle"],
        //   // "lasteditdate":ordercarModel[0]["cartItems"][i]["lasteditdate"],
        //   "pdfUrl":ordercarModel[0]["cartItems"][i]["pdf_url"],
        //   "count":ordercarModel[0]["cartItems"][i]["count"],
        //   "order_status":"pending",
        // };
        // ordercarModel.removeAt(i);
        // ordercarModel.insert(i, map);
        print(ordercarModel[0]["cartItems"][i]);
        // print("ordercarModel");
        // print(ordercarModel[i]["order_status"]);
        /*ordercarModel[i]["order_status"] = "pending";*/
        // Temp
        MemotiDbProvider.db
            .insertCart(
                ordercarModel[0]["cartItems"][i]["product_type"],
                aa,
                ordercarModel[0]["cartItems"][i]["images"]["mainImageList"][0]["base64"],
                pp,
                ordercarModel[0]["cartItems"][i]["max_photo"],
                ordercarModel[0]["cartItems"][i]["min_photo"],
                ordercarModel[0]["cartItems"][i]["product_id"],
                ordercarModel[0]["cartItems"][i]["product_prices"],
                ordercarModel[0]["cartItems"][i]["selectedSizes"],
                ordercarModel[0]["cartItems"][i]["product_names"],
                ordercarModel[0]["cartItems"][i]["slovaktitle"],
                ordercarModel[0]["cartItems"][i]["pdf_url"],
                ordercarModel[0]["cartItems"][i]["count"],
                "pending")
            .then((value) {
          // changeTabpagePosition(2);
          // Navigator.push( context, MaterialPageRoute(builder: (context) => TabsPage()));
        });
        /*MemotiDbProvider.db.updateCart(ordercarModel[i]).then((value) {
        });*/
      }
    } else {
      print("wsftgyhujikl");
    }
    print(cartlist);
    dynamic data = {
      "customer_id": customer_id,
      "items": cartlist,
      "product_names": "product_names",
      "selectedSizes": "selectedSizes",
      "product_prices": "product_prices"
    };
    String body = json.encode(data);
    print(body);
    var url = Uri.parse(
        "https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/inventory/add/product/to/cart");

    http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    print(response.body);
    if (response.statusCode == 200) {
      // Navigator.push( context, MaterialPageRoute(builder: (context) => TabsPage()));
      getAllLocalCartproduct();
      Future.delayed(Duration(milliseconds: 500), () {
        checkaddress(context, context, totalprice);
      });
    } else {
      notifyListeners();
      throw Exception('Failed to load album');
    }
  }

  List<String> ordersummaryimageList = [];
  List ordercarModel = [];

  void setDataorder(orderDataitem) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.get(UiData.token) ?? "";
    this.orderDataitem = orderDataitem;
    itemList = orderDataitem["cartItems"];
    shipment_charges =
        double.parse(orderDataitem["shipment_charges"]["price"].toString())
            .toStringAsFixed(2);

    ordersummaryimageList = [];
    ordercarModel = [];
    print("orderDataitem");
    print(orderDataitem);
    discount =
        double.parse(orderDataitem["discount"].toString()).toStringAsFixed(2);
    double itp = 0;
    ordercarModel.add(orderDataitem);
    for (int i = 0; i < itemList.length; i++) {
      int local_cart_id = itemList[i]["local_cart_id"];
      if (local_cart_id != null) {
        // Temp
        // List lll = await MemotiDbProvider.db.getAllCartItemwithId(local_cart_id);
        // // print("value.length");
        // // print(lll.length);
        // if(lll.length>0){
        //   ordercarModel.add(lll[0]);
        //   ordersummaryimageList.add(json.decode(lll[0]["images"])['mainImageList'][0]["lowresofileuriPath"]);
        // }
      }
      String p =
          itemList[i]["product_prices"].toString().replaceAll("€", "").trim();
      String c = itemList[i]["count"];
      if (p == "" || p == null) {
        p = "0";
      }
      if (c == "" || c == null) {
        c = "0";
      }
      double ic = double.parse(c);
      double ip = double.parse(p);
      double it = ic * ip;
      itp = itp + it;
    }

    double int_ship_price =
        double.parse(orderDataitem["shipment_charges"]["price"].toString());
    print(itp);
    print(int_ship_price);
    itp = itp + int_ship_price;
    //total_price = double.parse(itp.toString()).toStringAsFixed(2);
    total_price = (double.parse(orderDataitem["price"].toString()) / 100)
        .toStringAsFixed(2);
    print(double.parse(orderDataitem["price"].toString()));

    ii = orderDataitem["ii"];
    currency = orderDataitem["currency"];
    payment_method = orderDataitem["payment_method"];
    customer_id = orderDataitem["customer_id"];
    orderid = orderDataitem["orderid"];
/*    print(orderDataitem["cartItems"]);
    dynamic data = {
      "customer_id": customer_id
    };
    String body = json.encode(data);
    var url = Uri.parse("https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/inventory/list/product/to/cart");

    http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body
    );
    print(body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(json.decode(response.body)["data"]);
      Map<String,dynamic> map = json.decode(response.body)["data"];
      if(map!=null && map.isNotEmpty){
        cartlist = json.decode(response.body)["data"]["cartItems"];
        print("cartlist - = " + cartlist.length.toString());
      }
    }
    cartlist.addAll(itemList);*/
    notifyListeners();
  }

  List _orders = [];
  List get orders => _orders;
  List ordersData = [];
  bool iswating = true;
  bool isOrderListEmpty = true;
  bool soethingWentWrong = false;
  addorderItem() async {
    iswating = true;
    firstapirun = true;
    ordersData.clear();
    _orders.clear();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user_id = preferences.get(UiData.user_id) ?? "";
    String token = preferences.get(UiData.token) ?? "";
    dynamic data = {"customer_id": user_id};
    String body = json.encode(data);
    var url = Uri.parse(
        "https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/orderlisting");

    http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    print("respone = " + response.body.toString());
    if (json.decode(response.body)["status"] == "success") {
      soethingWentWrong = false;
      ordersData = json.decode(utf8.decode(response.bodyBytes))["data"];

      if (ordersData.isNotEmpty) {
        isOrderListEmpty = false;
        for (int i = 0; i < ordersData.length; i++) {
          var order_status = ordersData[i]["order_status"].toString();
          var ii = ordersData[i]["ii"].toString();
          var pdf_url;
          var createdate = ordersData[i]["created_date"];
          var pp = ordersData[i]["price"].toString();
          var shipment_charges = ordersData[i]["shipment_charges"]["price"];
          var discount = ordersData[i]["discount"];

          print(i);
          List cartItems = ordersData[i]["cartItems"];
          List<String> name = [];
          String imagepath = "";
          List<String> slovaktitle = [];
          double addprice = 0;
          if (ordersData[i]["cartItems"].length > 0) {
            int local_cart_id = ordersData[i]["cartItems"][0]["local_cart_id"];
            if (local_cart_id != null) {
              // Temp
              List lll =
                  await MemotiDbProvider.db.getAllCartItemwithId(local_cart_id);
              print("value.length");
              print(lll.length);
              if (lll.length > 0) {
                print("json.decode(lll");
                // print(json.decode(lll[0]["images"])['mainImageList'][0]);
                // imagepath = json.decode(lll[0]["images"])['mainImageList'][0]
                //     ["lowresofileuriPath"];
                // print("imagepath");
                // print(imagepath);
              }
            }
          }
          for (int j = 0; j < cartItems.length; j++) {
            name.add(cartItems[j]["product_names"]);
            print(cartItems[j]["product_names"]);
            print(j);
            slovaktitle.add(cartItems[j]["slovaktitle"]);
            String price = cartItems[j]["product_prices"]
                .toString()
                .replaceAll("€", "")
                .trim();
            String count = cartItems[j]["count"];
            if (count == "" || count == null) {
              count = "0";
            }
            if (price == "" || price == null) {
              price = "0";
            }
            double ic = double.parse(count);
            double ip = double.parse(price);
            double it = ic * ip;
            addprice = it + addprice;

            pdf_url = cartItems[j]["pdf_url"].toString();
          }

          double intShipprice = double.parse(shipment_charges.toString());
          addprice = addprice + intShipprice;
          String names = name.join(', ');
          String slovaktitles = slovaktitle.join(', ');
          String price = addprice.toString();
          print(pdf_url);
          _orders.add({
            "ii": ii,
            "title": names,
            "slovaktitles": slovaktitles,
            "price": (double.parse(pp) / 100).toStringAsFixed(2) + ' \u{20AC}',
            "status": "Delievered",
            //"image":"https://memotiapp.s3.eu-central-1.amazonaws.com/"+"imageurl",
            "image": imagepath,
            "pdf_url": pdf_url,
            "createddate": createdate,
            "openingpdf": false,
          });
        }

        Comparator datecompare = (a, b) =>
            intl.DateFormat("E MMM dd yyyy hh:mm:ss")
                .parse(a["createddate"].split("GMT")[0])
                .compareTo(intl.DateFormat("E MMM dd yyyy hh:mm:ss")
                    .parse(b["createddate"].split("GMT")[0]));
        _orders.sort(datecompare);
        _orders = _orders.reversed.toList();
        print("id - " + _orders[0]["ii"]);
        ordersData = ordersData.reversed.toList();
      } else {
        print("hey");
        isOrderListEmpty = true;
      }
    } else {
      soethingWentWrong = true;
    }
    iswating = false;
    notifyListeners();
  }

  logout() async {
    _busy = true;
    notifyListeners();
    final SharedPreferences prefs = await _prefs;
    await prefs.clear();
    _busy = false;
    getuserId();
    notifyListeners();
  }

//////////////
////Login/////
//////////////

  String status = "";
  String msg = "";
  IconData dialog_icon = Icons.check_circle_sharp;
  void closedDialogl() {
    status = "";
    notifyListeners();
  }

  loginUser(
      BuildContext context, String emails, String password, signup) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    Map data = {
      "email": emails,
      "password": password,
      "pt": "customer",
    };
    _busy = true;
    notifyListeners();
    print("map" + data.toString());
    String body = json.encode(data);
    print("body" + body.toString());
    var url = Uri.parse(
        "https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/user/login/auth");

    http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    print("response.statusCode - " + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("login success " + response.body.toString());
      Map<String, dynamic> responseData = jsonDecode(response.body);
      String status1 = responseData["status"];
      if (status1 == "success") {
        String token = responseData["token"];

        int code = responseData["code"];
        Map<String, dynamic> dataObject = responseData["data"];
        name = dataObject["title"];
        email = dataObject["email"];
        String mobile = dataObject["mobile"];
        String password = responseData["password"];
        String situation = responseData["situation"];
        String pi = dataObject["pi"].toString();
        address = "";

        if (dataObject["address"] != null) {
          address = dataObject["address"].toString();
        }
        print("email - " + email);
        print("pi - " + pi);
        prefs.setString('user_id', pi);
        prefs.setString(UiData.email, email);
        prefs.setString(UiData.token, token);
        prefs.setString(UiData.name, name);
        prefs.setString(UiData.address, address);
        Future.delayed(Duration(milliseconds: 5000), () {
          print('prefs.getString(UiData.user_id)');
          print(prefs.getString(UiData.user_id));
        });
        print("1pi - " + pi);
        status = "true";
        print(" 2pi - " + pi);
        print("3pi - " + pi);
        if (signup) {
          dialog_icon = Icons.check_circle_sharp;
          msg = Languages.of(context)!.SignupSuccessfullyNowcreateyourmemories;
          _showDialog = true;
        } else {
          dialog_icon = Icons.thumb_up;
          msg = Languages.of(context)!.ThanksforLoginNowcreateyourmemories;
        }
        print("4pi - " + pi);
        _isloggedIn = true;
      } else {
        if (signup) {
          dialog_icon = Icons.arrow_drop_down_circle;
          msg = Languages.of(context)!
              .FaceSomeissuepleaseTrytologinwiththissameemailaddress;
          _showDialog = true;
        } else {
          dialog_icon = Icons.arrow_drop_down_circle;
          msg = Languages.of(context)!.PLeaseEnterValidEmailAddressAndPassowrd;
        }
        status = "false";
      }
      _busy = false;
      notifyListeners();
    } else {
      dialog_icon = Icons.arrow_drop_down_circle;
      msg = Languages.of(context)!
          .FacingtheissueinregisteringtheuserPleasetryagainwithloginwithsameemailaddress;
      print(response.body.toString());
      status = "false";
      _busy = false;
      notifyListeners();
    }
  }

////////////////
////Signup/////
///////////////

  bool _registered = false;
  bool get registered => _registered;
  bool _showDialog = false;
  bool get showDialogs => _showDialog;
  void closedDialog() {
    _showDialog = false;
    notifyListeners();
  }

  registerUser(String fName, String lName, String email, String phoneNumber,
      String password, BuildContext context, BuildContext contextmain) async {
    _busy = true;
    notifyListeners();
    Map data = {
      "title": fName + " " + lName,
      "email": email,
      "password": password,
      "situation": "Active",
      "mobile": phoneNumber,
    };
    print("map" + data.toString());
    String body = json.encode(data);
    print("testing");
    print("body" + body.toString());
    var url = Uri.parse(
        "https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/people/customer");

    http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    print("response.statusCode - " + response.statusCode.toString());
    if (response.statusCode == 200) {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      print(response.body.toString());
      Map<String, dynamic> responseData = jsonDecode(response.body);
      int code = responseData["code"];
      String status = responseData["status"];
      String message = responseData["message"];
      if (status == "success") {
        _registered = true;
        loginUser(context, email, password, true);
      } else {
        dialog_icon = Icons.arrow_drop_down_circle;
        /*controller.clear();*/
        _showDialog = true;
        msg = message;
        _registered = false;
        _busy = false;
        notifyListeners();
      }
    } else {
      dialog_icon = Icons.arrow_drop_down_circle;
      _showDialog = true;
      msg = Languages.of(contextmain)!.faceSomeIssuepleasetryagain;
      print(response.body.toString());
      _registered = false;
      _busy = false;
      notifyListeners();
    }
  }

////////////////
////Address/////
///////////////

  List _addresses = [];
  List get addresses => _addresses;
  bool _fetchaddress = true;
  bool get fetchaddress => _fetchaddress;
  addData(String token) {
    fetchAllDataaddress(token);
  }

  gotopage(contextmain, context) {
    for (var x = 0; x < addresses.length; x++) {
      if (addresses[x]["isSelected"]) {
        setaddress(addresses[x]);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CardListPage("cart")));
      }
    }
  }

  fetchAllDataaddress(String token) async {
    _fetchaddress = false;
    _addresses = [];
    Map data = {
      "token": token,
    };
    String body = json.encode(data);
    var url = Uri.parse(
        'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/user/login/get/address');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["data"].length > 0) {
        if (jsonDecode(response.body)["data"][0] != null) {
          for (var x = 0;
              x < jsonDecode(response.body)["data"][0]["address"].length;
              x++) {
            // print(response.body);
            var ee = jsonDecode(response.body)["data"][0]["address"][x];
            if (x == 0) {
              _addresses.add({
                "title": ee["title"],
                "address": ee["address"],
                "cityRegion": ee["cityRegion"],
                "postCode": ee["postCode"],
                "Country": ee["Country"],
                "PhoneNumber": ee["PhoneNumber"],
                "isSelected": true,
                "pi": jsonDecode(response.body)["data"][0]["pi"],
                "pt": jsonDecode(response.body)["data"][0]["pt"]
              });
            } else {
              _addresses.add({
                "title": ee["title"],
                "address": ee["address"],
                "cityRegion": ee["cityRegion"],
                "postCode": ee["postCode"],
                "Country": ee["Country"],
                "PhoneNumber": ee["PhoneNumber"],
                "isSelected": false,
                "pi": jsonDecode(response.body)["data"][0]["pi"],
                "pt": jsonDecode(response.body)["data"][0]["pt"]
              });
            }
            if (jsonDecode(response.body)["data"][0]["address"].length - 1 ==
                x) {
              notifyListeners();
            }
          }

          notifyListeners();
        }
      }
    } else {}
  }

  changeAddress(int index) {
    for (int i = 0; i < _addresses.length; i++) {
      if (i == index) {
        _addresses[i]["isSelected"] = true;
      } else {
        _addresses[i]["isSelected"] = false;
      }
    }
    notifyListeners();
  }

  deleteaddress(index, token, context, pi, pt) async {
    _addresses.removeAt(index);
    notifyListeners();
    Map<String, dynamic> data = {
      "token": token,
      "address": addresses,
      "pi": pi,
      "pt": pt,
    };
    print(data.toString());
    print("data.toString()");
    String body = json.encode(data);
    print(body.toString());
    var url = Uri.parse(
        'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/user/login/edit/address');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.statusCode);
    } else {}
  }

  saveaddress(String where, String token, context) async {
    if (isValid) {
      _fetchaddress = true;
      Map data = {
        "token": token,
        "address": {
          "title": edtname.value,
          "Country": edtcity.value + "--Slovensko",
          "address": edtAddress.value,
          "cityRegion": edtCityStreet.value,
          "postCode": edtPostCode.value,
          "PhoneNumber": edtPhoneNumber.value,
          "postCode": edtPostCode.value
        }
      };
      String body = json.encode(data);
      print(body);
      var url = Uri.parse(
          'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/user/login/get/address');
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      if (response.statusCode == 200) {
        switch (where) {
          case "order":
            {
              break;
            }
          case "cart":
            {
              Navigator.pop(context);
              Navigator.pop(context);
              print(token);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddressListPage(context, token, "cart")),
              );
              break;
            }
          case "account":
            {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddressListPage(context, token, "account")),
              );
              break;
            }
        }
      } else {
        print("drftgyhu");
      }
    } else {
      print("drftgyhu");
    }
    notifyListeners();
  }

  dynamic selectedaddress;
  dynamic get getselectedaddress => selectedaddress;
  setaddress(address) {
    selectedaddress = address;
  }

  final List<String> _dropdownValues = [
    "Home",
    "Office",
    "Others",
  ];
  final List<String> _country = [
    "Slovensko",
    "India",
    "Uk",
  ];

  ValidationItem _edtAddress = ValidationItem('', '');
  ValidationItem _edtname = ValidationItem('', '');
  ValidationItem _edtcity = ValidationItem('', '');
  ValidationItem _edtCityStreet = ValidationItem('', '');
  ValidationItem _edtPostCode = ValidationItem('', '');
  ValidationItem _edtPhoneNumber = ValidationItem('', '');

  late String _addresstype;
  String? _addresscountry;

  List<String> get getAddressType => _dropdownValues;
  List<String> get getCountry => _country;
  List<String> get country => _country;
  String get addresstype => _addresstype;
  String? get addresscountry => _addresscountry;
  ValidationItem get edtAddress => _edtAddress;
  ValidationItem get edtname => _edtname;
  ValidationItem get edtcity => _edtcity;
  ValidationItem get edtCityStreet => _edtCityStreet;
  ValidationItem get edtPostCode => _edtPostCode;
  ValidationItem get edtPhoneNumber => _edtPhoneNumber;

  bool firstCall = false;
  late int index;
  bool get isValid {
    if (_edtname.value != null /*&& _addresscountry != null*/ &&
        _edtCityStreet.value != null &&
        _edtAddress.value != null &&
        _edtPostCode.value != null &&
        _edtPhoneNumber != null) {
      return true;
    } else {
      return false;
    }
  }

  setData(address, index, addresses) async {
    print("eee");
    firstCall = true;
    this.address = address;
    this.index = index;
    final SharedPreferences prefs = await _prefs;
    token = prefs.getString(UiData.token) ?? "";
    changeedtName(address["title"]);
    changedEmail(address["address"]);
    changeedCity(address["Country"].toString().split('--')[0]);
    changeedtCityStreet(address["cityRegion"]);
    changeedtpPostCode(address["postCode"]);
    print(address["PhoneNumber"]);
    if (address["PhoneNumber"] != null) {
      changeedtpPhoneNumber(address["PhoneNumber"]);
    }
    notifyListeners();
  }

  editaddress(contextmain, context, String where) async {
    firstCall = false;
    print(edtname.value);
    print(edtcity.value);
    print(edtAddress.value);
    print(index);
    print(address);

    addresses[index]["title"] = edtname.value;
    addresses[index]["Country"] = edtcity.value + "--Slovensko";
    addresses[index]["address"] = edtAddress.value;
    addresses[index]["cityRegion"] = edtCityStreet.value;
    addresses[index]["postCode"] = edtPostCode.value;
    addresses[index]["PhoneNumber"] = edtPhoneNumber.value;
    addresses[index]["pt"] = "customer";
    addresses[index]["pi"] = addresses[index]["pi"];
    addresses[index]["isSelected"] = addresses[index]["isSelected"];
    notifyListeners();
    Map<String, dynamic> data = {
      "token": token,
      "address": addresses,
      "pi": addresses[index]["pi"],
      "pt": addresses[index]["pt"],
    };
    print(data.toString());
    print("data.toString()");
    String body = json.encode(data);
    print(body.toString());
    var url = Uri.parse(
        'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/user/login/edit/address');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // print(response.body);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AddressListPage(contextmain, a_token, "account")),
      );
    } else {}
  }

  void changedEmail(String value) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      _edtAddress = ValidationItem(value, '');
    } else {
      _edtAddress = ValidationItem('', "Must be at valid email address");
    }
    notifyListeners();
  }

  void changeedtName(String value) {
    if (value.length >= 3) {
      _edtname = ValidationItem(value, '');
    } else {
      _edtname = ValidationItem('', "Must be at least 3 characters");
    }
    notifyListeners();
  }

  void changeedCity(String value) {
    if (value.length >= 3) {
      _edtcity = ValidationItem(value, '');
    } else {
      _edtcity = ValidationItem('', "Must be at least 3 characters");
    }
    notifyListeners();
  }

  void changeedtCityStreet(String value) {
    if (value.length >= 3) {
      _edtCityStreet = ValidationItem(value, '');
    } else {
      _edtCityStreet = ValidationItem('', "Must be at least 3 characters");
    }
    notifyListeners();
  }

  void changeedtpPostCode(String value) {
    if (value.length >= 5) {
      _edtPostCode = ValidationItem(value, '');
    } else {
      _edtPostCode = ValidationItem('', "Must be at least 5 characters");
    }
    notifyListeners();
  }

  void changeedtpPhoneNumber(String value) {
    if (value.length >= 3) {
      _edtPhoneNumber = ValidationItem(value, '');
    } else {
      _edtPhoneNumber = ValidationItem('', "Must be at least 3 characters");
    }
    notifyListeners();
  }

  setaddresstype(String type) {
    _addresstype = type;
    notifyListeners();
  }

  setaddresscountry(String type) {
    _addresscountry = type;
    notifyListeners();
  }

/////////////////
////Canvas//////
////////////////
  late bool fromcanvasdetail;
  passtoProvidercanvas(dynamic producttt, String wheres) {
    product = producttt;
    print(product);
    maxPage = product["detail"]["maxpage"].toString();
    minPage = product["detail"]["minpage"].toString();
    max_photo = int.parse(product["detail"]["maxpage"].toString());
    min_photo = int.parse(product["detail"]["minpage"].toString());
    product_id = product["detail"]["ii"].toString();
    slovaktitle = product["detail"]["slovaktitle"].toString();
    product_name = product["detail"]["title"].toString();
    where = wheres;

    sizes.clear();

    for (int i = 0; i < product["detail"]["sizes"].length; i++) {
      sizes.add(product["detail"]["sizes"][i]["dimension"].toString());
    }
    minPrice = product["detail"]["sizes"][0]["perpage"];
    maxPrice = product["detail"]["sizes"][product["detail"]["sizes"].length - 1]
        ["perpage"];
    doubleminPrice = double.parse(minPrice);
    doublemaxPrice = double.parse(maxPrice);
    print(minPage);
    print(maxPage);
    doubleMinPage = double.parse(minPage);
    doubleMaxPage = double.parse(maxPage);
    totalminPrice = doubleminPrice * doubleMinPage;
    totalmaxPrice = doublemaxPrice * doubleMaxPage;
  }

  //int istextFormattingcanvas = 0;
  int selectedimageFilterTabindexCanvas = 0;
  TextEditingController textEditingControllecanvass = TextEditingController();
  Uint8List? originaltextEditIMagecanvas = null;
  bool isoriginaltextEditIMagecanvas = false;
  //String _selcted_image_typecanvas = "";
  String selectedaspectRatiocanvas = "";

  cloedimagetextediting() {
    _istextFormatting = 2;
    notifyListeners();
  }

  closedtextformattingcanvas() async {
    print("run1");
    _istextFormatting = 2;
    if (textEditingControllecanvass.text == "") {
      print("run2");
      originaltextEditIMagecanvas = null;
      isoriginaltextEditIMagecanvas = false;
      currenttextColor = Colors.black;
      currentBGColor = Colors.white;
      _selectedtextFormatTabindex = 0;
      _selectedcolorindex = 0;
      selectedFontSizeindex = 10;
      selectededitTextPosition = 0;

      _selectedFontKey = _customFontList[0].fontName;
      selectedfontpath = _customFontList[0].fontspath;
      _selectedFontindex = 0;
      textEditingControllecanvass = TextEditingController();
      notifyListeners();
    } else {
      int width, height;
      var image;
      selectedfontpath = _customFontList[_selectedFontindex].fontspath;
      io.File fontFile =
          await getFileFromAssets(selectedfontpath.split("-app/")[1]);
      print("hhhhhhhhhhhhhhh");
      //final String fontName = await getFont(GoogleFonts.poppins());
      final String fontName = await FontManager.registerFont(fontFile);
      if (whichImageShow == "original") {
        image = originaltextEditIMagecanvas;
        var decodedImage =
            await decodeImageFromList(originaltextEditIMagecanvas!);
        print(decodedImage.width);
        print(decodedImage.height);
        width = decodedImage.width;
        height = decodedImage.height;
      } else {
        image = io.File(selectedlowIMageuri!);
        var decodedImage = await decodeImageFromList(image.readAsBytesSync());
        print(decodedImage.width);
        print(decodedImage.height);
        width = decodedImage.width;
        height = decodedImage.height;
      }

      final textOption = AddTextOption();
      textOption.addText(
        EditorText(
          offset: Offset(
              width * imageTextPostionList[selectededitTextPosition].dxOffset,
              height.toDouble() *
                  imageTextPostionList[selectededitTextPosition].dyOffset),
          text: textEditingControllecanvass.text,
          fontSizePx: selectedFontSizeindex * 3,
          textColor: currenttextColor,
          fontName: fontName,
          //     .fontName,
        ),
      );
      print("run4");
      ImageEditorOption option = ImageEditorOption();
      option = ImageEditorOption();
      option.addOption(textOption);
      //textEditingController.clear();

      if (whichImageShow != "original") {
        final result = await ImageEditor.editFileImage(
          file: image,
          imageEditorOption: option,
        );
        //await updatetextimage(rimageesult);
        updateCanvasImage(result!);
      } else {
        final result = await ImageEditor.editImage(
            image: image, imageEditorOption: option);
        //await updatetextimage(result);

        updateCanvasImage(result!);
      }
      originaltextEditIMagecanvas = null;
      isoriginaltextEditIMagecanvas = false;
      print("run5");
      currenttextColor = Colors.black;
      currentBGColor = Colors.white;
      _selectedtextFormatTabindex = 0;
      _selectedcolorindex = 0;
      selectedFontSizeindex = 10;
      selectededitTextPosition = 0;

      _selectedFontKey = _customFontList[0].fontName;
      selectedfontpath = _customFontList[0].fontspath;
      _selectedFontindex = 0;
      textEditingControllecanvass = TextEditingController();
    }
  }

  closedImageFilterCanvas() {
    _istextFormatting = 0;
    selectedimageFilterTabindexCanvas = 0;
    selectedaspectRatiocanvas = ratio;
    ratio = "";
    _selected_filter = NOFILTER;
    for (int i = 0; i < _filterList.length; i++) {
      _filterList[i].isSelected = false;
    }
    notifyListeners();
  }

  closedTextEditor() {
    _istextFormatting = 2;
  }

  late Uint8List texteditIMage;

  addPostercreation(BuildContext context) {
    if (creation_id == -1) {
      getItemResponseinString().then((items) {
        print("jsonStingitems - " + items);
        getmainImageListResponseinString().then((mainimages) {
          // print("jsonStringsimageList - "+mainimages);
          //addingCreation = false;
          if (wechatIMages != null) {
            wechatIMages.clear();
            listGoogleMediaItem = [];
            memotiGalleryPhotoList = [];
            imagess.clear();
            unselectAll();
          }
          // Temp
          MemotiDbProvider.db
              .insertCreation(
                  "poster",
                  mainimages,
                  items,
                  max_photo.toString(),
                  min_photo.toString(),
                  product_id,
                  product_price,
                  selectedSize,
                  product_name,
                  slovaktitle)
              .then((value) => Navigator.pushAndRemoveUntil<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => TabsPage(),
                    ),
                    (route) =>
                        false, //if you want to disable back feature set to false
                  ));
        });
      });
    } else {
      // Temp
      MemotiDbProvider.db.removecreationItem(creation_id!).then((value) async {
        getItemResponseinString().then((items) {
          // print("jsonStingitems - "+items);
          getmainImageListResponseinString().then((mainimages) {
            // print("jsonStringsimageList - "+mainimages);
            // print("selectedSize - "+selectedSize);
            //addingCreation = false;
            notifyListeners();
            MemotiDbProvider.db
                .insertCreation(
                    "poster",
                    mainimages,
                    items,
                    max_photo.toString(),
                    min_photo.toString(),
                    product_id,
                    product_price,
                    selectedSize,
                    product_name,
                    slovaktitle)
                .then((value) => Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => TabsPage(),
                      ),
                      (route) =>
                          false, //if you want to disable back feature set to false
                    ));
          });
        });
      });
    }
  }

  addcreation(BuildContext context) {
    if (creation_id == -1) {
      getItemResponseinString().then((items) {
        // print("jsonStingitems - "+items);
        getmainImageListResponseinString().then((mainimages) {
          // print("jsonStringsimageList - "+mainimages);
          //addingCreation = false;
          notifyListeners();
          // Temp
          MemotiDbProvider.db
              .insertCreation(
                  "canvas",
                  mainimages,
                  items,
                  "1",
                  "1",
                  product["detail"]["ii"],
                  price,
                  selectedSize,
                  product["detail"]["title"],
                  product["detail"]["slovaktitle"])
              .then((value) {
            if (wechatIMages != null) {
              wechatIMages.clear();
              listGoogleMediaItem = [];
              memotiGalleryPhotoList = [];
              imagess.clear();
              unselectAll();
            }
            Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => TabsPage(),
              ),
              (route) =>
                  false, //if you want to disable back feature set to false
            );
          });
        });
      });
    } else {
      // Temp
      MemotiDbProvider.db.removecreationItem(creation_id!).then((value) async {
        getItemResponseinString().then((items) {
          // print("jsonStingitems - "+items);
          getmainImageListResponseinString().then((mainimages) {
            // print("jsonStringsimageList - "+mainimages);
            // print("selectedSize - "+selectedSize);
            //addingCreation = false;
            notifyListeners();
            MemotiDbProvider.db
                .insertCreation(
                    "canvas",
                    mainimages,
                    items,
                    "1",
                    "1",
                    product["detail"]["ii"],
                    price,
                    selectedSize,
                    product["detail"]["title"],
                    product["detail"]["slovaktitle"])
                .then((value) => Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => TabsPage(),
                      ),
                      (route) =>
                          false, //if you want to disable back feature set to false
                    ));
          });
        });
      });
    }
  }

  List<int> canvasImageList = [];
  //String  selcted_image_type = "";
  String selcted_image = "";
  String selcted_image_base64 = "";
  //int _selectedIndex = 0;

  changeCanvasDimension(int index) {
    print("edrftgyhujiybvybunim");

    for (int i = 0; i < dimensions.length; i++) {
      print(dimensions);
      if (i == index) {
        selectedSize = dimensions[i]["sizeInString"];
        print(dimensions[i]["width"]);
        print(dimensions[i]["height"]);
        price = dimensions[i]["price"] + "€";
        product_price = dimensions[i]["price"];
        width = dimensions[i]["width"] * 8;
        /* width = int.parse(dimensions[i]["width"].toString()).toDouble() * 5;*/
        height = dimensions[i]["height"] * 8;
        selected_width = dimensions[i]["width"] * 8;
        selected_height = dimensions[i]["height"] * 8;
        dimensions[i]["isSelected"] = true;
      } else {
        dimensions[i]["isSelected"] = false;
      }
    }
    // if(!fromcanvasdetail){
    //   List <int> imageList = [];
    //   imageList[0];
    //   // imageList[0]["isCropped"] = "false";
    // }
    notifyListeners();
  }

  late String categoryType;
  addCanvasData(List imageList, BuildContext contextmain, int creation_id,
      String categorytype) async {
    print("cvgbhnjm");
    // print(categoryType);
    firstCall = true;
    dimensions = [];
    this.creation_id = creation_id;
    this.imageList = imageList;
    if (categorytype == "canvas") {
      this.product = _selectedproduct[0];
    }

    this.categoryType = "canvas";
    // if (imageList.isNotEmpty)
    //   print(imageList[0]["image_type"]);
    // _selcted_image_type = imageList[0]["image_type"];
    // print(_selcted_image_type);
    // if(creation_id==-1){
    //   print("cvgbhnjm");
    //   this.imageList[0]["isCropped"] = "false";
    //   print("qwertyuiop");
    // }else{
    //   this.imageList[0]["isCropped"] = imageList[0]["isCropped"];
    //   selectedlowIMageurinew = imageList[0]["lowresofileuriPath"];
    // }
    // print("product");
    // print('imageList[0]["base64"]');
    // print(imageList[0]["fileuriPath"]);
    // print(imageList[0]["base64"]);
    // print('imageList[0]["base64"]');
    // print(selcted_image);
    // print(imageList[0]["fileuriPath"]);
    // print(this.imageList[0]["isCropped"]);
    // print(product);
    // print(product["detail"]);
    // print(product["detail"]["sizes"]);
    if (product != null && product["detail"] != null) {
      for (int i = 0; i < product["detail"]["sizes"].length; i++) {
        // print(product[0]["detail"]["sizes"][i]["perpage"]);
        // print(product[0]["detail"]["sizes"][i]["dimension"]);
        if (fromcanvasdetail) {
          if (i == 0) {
            print(product["detail"]["title"]);
            price = product["detail"]["sizes"][i]["perpage"] + "€";
            String stringwidth =
                product["detail"]["sizes"][i]["dimension"].split("x")[0];
            String stringHeight = product["detail"]["sizes"][i]["dimension"]
                .split("x")[1]
                .split("cm")[0];
            double width = double.parse(stringwidth);
            double height = double.parse(stringHeight);
            dimensions.add({
              "price": product["detail"]["sizes"][i]["perpage"],
              "sizeInString": product["detail"]["sizes"][i]["dimension"],
              "width": width,
              "height": height,
              "isSelected": true
            });
            selectedSize = dimensions[i]["sizeInString"];
            print(selectedSize);
            print("hhhhhhhhhhhhhhhhhhh");
            print(dimensions[i]["height"]);
            this.width = dimensions[i]["width"] * 8;
            this.height = dimensions[i]["height"] * 8;
            selected_width = dimensions[i]["width"] * 8;
            selected_height = dimensions[i]["height"] * 8;
            product_price = product["detail"]["sizes"][i]["perpage"];
          } else {
            String stringwidth =
                product["detail"]["sizes"][i]["dimension"].split("x")[0];
            String stringHeight = product["detail"]["sizes"][i]["dimension"]
                .split("x")[1]
                .split("cm")[0];
            double width = double.parse(stringwidth);
            double height = double.parse(stringHeight);
            print(width);
            print(height);
            String sii =
                product["detail"]["sizes"][i]["dimension"].split("x")[0];
            print(sii);
            dimensions.add({
              "price": product["detail"]["sizes"][i]["perpage"],
              "sizeInString": product["detail"]["sizes"][i]["dimension"],
              "width": width,
              "height": height,
              "isSelected": false
            });
          }
        } else {
          print("canvas size - " + canvasselectedSize);
          print("canvas dimension - " +
              product["detail"]["sizes"][i]["dimension"]);
          if (canvasselectedSize ==
              product["detail"]["sizes"][i]["dimension"]) {
            print(product["detail"]["title"]);
            price = product["detail"]["sizes"][i]["perpage"] + "€";
            String stringwidth =
                product["detail"]["sizes"][i]["dimension"].split("x")[0];
            String stringHeight = product["detail"]["sizes"][i]["dimension"]
                .split("x")[1]
                .split("cm")[0];
            double width = double.parse(stringwidth);
            double height = double.parse(stringHeight);
            dimensions.add({
              "price": product["detail"]["sizes"][i]["perpage"],
              "sizeInString": product["detail"]["sizes"][i]["dimension"],
              "width": width,
              "height": height,
              "isSelected": true
            });
            selectedSize = dimensions[i]["sizeInString"];
            print(selectedSize);
            print("hhhhhhhhhhhhhhhhhhh");
            print(dimensions[i]["height"]);
            this.width = dimensions[i]["width"] * 8;
            this.height = dimensions[i]["height"] * 8;
            selected_width = dimensions[i]["width"] * 8;
            selected_height = dimensions[i]["height"] * 8;
            product_price = product["detail"]["sizes"][i]["perpage"];
          } else {
            String stringwidth =
                product["detail"]["sizes"][i]["dimension"].split("x")[0];
            String stringHeight = product["detail"]["sizes"][i]["dimension"]
                .split("x")[1]
                .split("cm")[0];
            double width = double.parse(stringwidth);
            double height = double.parse(stringHeight);
            print(width);
            print(height);
            String sii =
                product["detail"]["sizes"][i]["dimension"].split("x")[0];
            print(sii);
            dimensions.add({
              "price": product["detail"]["sizes"][i]["perpage"],
              "sizeInString": product["detail"]["sizes"][i]["dimension"],
              "width": width,
              "height": height,
              "isSelected": false
            });
          }
        }
      }
      maxPage = product["detail"]["maxpage"].toString();
      minPage = product["detail"]["minpage"].toString();
      max_photo = int.parse(product["detail"]["maxpage"].toString());
      min_photo = int.parse(product["detail"]["minpage"].toString());
      product_id = product["detail"]["ii"].toString();
      slovaktitle = product["detail"]["slovaktitle"].toString();
      product_name = product["detail"]["title"].toString();

      switch (_selcted_image_type) {
        case "phone":
          selcted_image = imageList[0]["fileuriPath"];
          if (imageList[0]["base64"] != null && imageList[0]["base64"] != "") {
            selcted_image_base64 = imageList[0]["base64"];
          } else {
            selcted_image_base64 =
                await converttobase64bytes(imageList[0]["fileuriPath"]);
          }
          break;
        case "memoti":
          selcted_image = imageList[0]["url_image"];
          if (imageList[0]["base64"] != null && imageList[0]["base64"] != "") {
            selcted_image_base64 = imageList[0]["base64"];
          } else {
            selcted_image_base64 = await networkImageToBase64(selcted_image);
            imageList[0]["base64"] = selcted_image_base64;
          }
          break;
        case "google":
          selcted_image = imageList[0]["url_image"];
          selcted_image_base64 =
              await converttobase64bytes(imageList[0]["url_image"]);
          // selcted_image = imageList[0]["url_image"]+"=w400-h400-c";
          // selcted_image_base64 = await converttobase64bytes(imageList[0]["url_image"]+"=w400-h400-c");
          break;
        case "instagram":
          selcted_image = imageList[0]["url_image"];
          selcted_image_base64 =
              await converttobase64bytes(imageList[0]["url_image"]);
          break;
        case "facebook":
          selcted_image = imageList[0]["url_image"];
          selcted_image_base64 =
              await converttobase64bytes(imageList[0]["url_image"]);
          break;
      }
    }
    addOtherData();
    // notifyListeners();
  }

  optiontoChooseIMagecanvas() {
    _istextFormatting = 3;
    _selcted_image_type = imageList[0]["image_type"];
    selectedlowIMageuri = imageList[0]["lowresofileuriPath"];
    switch (_selcted_image_type) {
      case "phone":
        selcted_image = imageList[0]["fileuriPath"];
        break;
      case "memoti":
        selcted_image = imageList[0]["url_image"];
        break;
      case "google":
        selcted_image = imageList[0]["url_image"] + "=w400-h400-c";
        break;
    }
    notifyListeners();
  }

  openImageFiltercanvas() {
    _filterList = [];
    _filterListUrl = [];
    // if (filterList.length < 1) {
    _istextFormatting = 2;
    _selcted_image_type = imageList[0]["image_type"];
    selectedlowIMageuri = imageList[0]["lowresofileuriPath"];
    print("selected_image_type");
    print(_selcted_image_type);
    whichImageShow = "original";
    switch (_selcted_image_type) {
      case "phone":
        selcted_image = imageList[0]["fileuriPath"];
        break;
      case "memoti":
        selcted_image = imageList[0]["url_image"];
        break;
      case "google":
        selcted_image = imageList[0]["url_image"] + "=w400-h400-c";
        break;
    }
    if (_selcted_image_type != null) {
      if (_selcted_image_type == "memoti" || _selcted_image_type == "google") {
        addFilterDataUrl();
      } else {
        addFilterData(base64);
      }
    }
  }

/////////////////
////Poster//////
////////////////
  late List products;
  List imageList = [];
  //String user_id;
  List<CustomColor> colorList = [];
  String selectedFontKey = "Poppins";
  // String  selectedlowIMageuri;
  // String  whichImageShow = "original";
  int istextFormattingposter = 0;
  int imagepos = 0;
  String selcted_image_type_poster = "";
  String selcted_image_url_poster = "";
  String seletedImageuri_poster = "";
  List<ImageFilterModel> filterList_poster = [];
  List<ImageFilterModelUrl> filterListUrl_poster = [];

  Future<io.File> convertImageToCropImageFileposter() async {
    final ExtendedImageEditorState? state = cropKey.currentState;
    final Rect? rect = state!.getCropRect();
    final EditActionDetails? action = state.editAction;
    // print(state.rawImageData);
    print("state");
    final img = state.rawImageData;
    print("rawImageData" + img.toString());
    ImageEditorOption option = ImageEditorOption();

    if (action!.needCrop) option.addOption(ClipOption.fromRect(rect!));
    final result = await ImageEditor.editImageAndGetFile(
      image: img,
      imageEditorOption: option,
    );
    return result;
  }

  bool _openingpdf = false;
  bool get openingpdf => _openingpdf;
  Future<io.File> createFileOfPdfUrl(url, index, space) async {
    if (space == "outer") {
      _orders[index]["openingpdf"] = true;
    } else {
      itemList[index]["openingpdf"] = true;
    }
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    io.File file = new io.File('$dir/$filename');
    await file.writeAsBytes(bytes);
    if (space == "outer") {
      _orders[index]["openingpdf"] = false;
    } else {
      itemList[index]["openingpdf"] = false;
    }
    return file;
  }

  void openImageFilterposter(int index) {
    imageQulaityColor = getImageDpiColor(imageList[index].size);
    imagepos = index;
    whichImageShow = "original";
    selcted_image_type_poster = imageList[index].image_type;
    seletedImageuri_poster = imageList[index].fileuriPath;
    selectedlowIMageuri = imageList[index].lowresofileuriPath;
    selcted_image_url_poster = imageList[index].url_image;
    print(selcted_image_type);
    print(seletedImageuri);
    print(selcted_image_url);
    print(selected_width);
    print(selected_height);
    filterList_poster = [];
    filterListUrl_poster = [];
    istextFormattingposter = 2;
    if (selcted_image_type != null) {
      if (selcted_image_type == "memoti" || selcted_image_type == "google") {
        addFilterDataUrl();
      } else {
        addFilterData(base64);
      }
    }
  }

  Future<void> addImagetolist(List imageList) async {
    this.imageList.addAll(imageList);
    notifyListeners();
  }

  optiontoChooseIMage(int index) {
    istextFormattingposter = 3;
    imagepos = index;
    selcted_image_type_poster = imageList[index].image_type;
    selectedlowIMageuri = imageList[index].lowresofileuriPath;
    switch (selcted_image_type) {
      case "phone":
        seletedImageuri_poster = imageList[index].fileuriPath;
        break;
      case "memoti":
        selcted_image_url_poster = imageList[index].url_image;
        break;
      case "google":
        selcted_image_url_poster = imageList[index].url_image;
        break;
    }
    notifyListeners();
  }

  Future<void> addToCart(BuildContext contextmain, BuildContext context) async {
    calledcart = false;
    if (_addcart) {
      _addcart = false;
      notifyListeners();
      return;
    }
    _addcart = true;
    boolerror = false;
    notifyListeners();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    user_id = prefs.getString(UiData.user_id) ?? "";
    if (user_id == "") {
      _addcart = false;
      notifyListeners();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      notifyListeners();
      addCartDatatoSqlfiteposter(context);
    }
  }

  Future<void> addCartDatatoSqlfiteposter(context) async {
    //List images = [];
    int time = 1000;
    List<Uint8List> pdfimages = [];
    // print("imageList");
    // print(imageList[0]["base64"]);
    // return;
    for (int i = 0; i < imageList.length; i++) {
      print("imageList[i][isCropped]");
      print(imageList[i]["isCropped"]);

      if (imageList[i]["isCropped"] == "true") {
        print("2222");
        /*print(time);
        print(imageloadingstate);*/
        // Uint8List byte = await File(imageList[i]["lowresofileuriPath"]).readAsBytes();
        Uint8List byte = base64Decode(imageList[i]["base64"]);
        pdfimages.add(byte);
        if (imageList.length - 1 == i) {
          uploadimageposter(context, pdfimages);
        }
      } else {
        updateimagepath = "";
        updateimagepathbase64 = imageList[i]["fileuriPath"];
        imageupdate = true;
        if(imageList[i]["image_type"] == "phone"){
          type = "phone";
          updateimagepath = imageList[i]["fileuriPath"];
          updateimagepathbase64 = await converttobase64bytes(imageList[i]["fileuriPath"]);
        }else{
          type = "url";
          String imageUrl = "";
          if (imageList[i]["image_type"] == "google") {
            updateimagepath = imageList[i]["url_image"]+"=w400-h400-c";
            updateimagepathbase64 = await networkImageToBase64(imageList[i]["url_image"]+"=w400-h400-c");
          } else {
            updateimagepath = imageList[i]["url_image"];
            updateimagepathbase64 = await networkImageToBase64(imageList[i]["url_image"]);
          }
        }
        imageloadingstate = "";
        print("rftgyhujikol;");
        print("updateimagepath;");
        var toContinue = true;
        notifyListeners();
        time = time + 30;
        await Future.doWhile(() async {
          await Future.delayed(Duration(seconds: 1));
          print("2");
          print(time);
          print(imageloadingstate);
          if (imageloadingstate == "complete") {
            await convertImageToCropImageFileposter().then((value) async {
              imageList[i]["lowresofileuriPath"] = value.uri.path;
              selectedlowIMageuri = value.uri.path;
              imageList[i]["isCropped"] = "true";
              imageList[i]["aspectRatio"] =
                  (selected_width / selected_height).toString();
              Uint8List byte = await value.readAsBytes();
              pdfimages.add(byte);
              if (imageList.length - 1 == i) {
                imageupdate = false;
                uploadimageposter(context, pdfimages);
              }
            });
            return false;
          } else if (imageloadingstate == "failed") {
            imageList[i]["lowresofileuriPath"] = imageList[i]["fileuriPath"];
            imageList[i]["isCropped"] = "false";
            // Uint8List byte = await File(imageList[i]["fileuriPath"]).readAsBytes();
            Uint8List byte = base64Decode(imageList[i]["base64"]);
            pdfimages.add(byte);
            imageList[i]["aspectRatio"] =
                (selected_width / selected_height).toString();
            if (imageList.length - 1 == i) {
              imageupdate = false;
              print("uploadimageposter");
              uploadimageposter(context, pdfimages);
            }
            return false;
          }
          return toContinue;
        }) /*.timeout(Duration(seconds: 3), onTimeout: () {
          toContinue = false;
          print('> Timed Out');
        })*/
            ;
        /* do{
          await Future.delayed(Duration(milliseconds: time), ()  {
            print("2");
            print(time);
            print(imageloadingstate);
            // Do something
          });
        }while(imageloadingstate=="complete");*/

        /*
        int time1 = 10;
        print("2");

        /*double size = imageList[i]["size"].height+imageList[i]["size"].width;
        print(size);*/
        print("imageloadingstate");
        */ /*double size = imageList[i]["size"].height+imageList[i]["size"].width;
        print(size);*/ /*
        print(imageloadingstate);
        // return;
        if(imageloadingstate!="complete"){
          time1 = 1000;
          await Future.delayed(Duration(milliseconds: time1), ()  {print("3");});
          if(imageloadingstate!="complete"){
            time1 = 1000;
            await Future.delayed(Duration(milliseconds: time1), ()  {print("4");});
            if(imageloadingstate!="complete"){
              time1 = 1000;
              await Future.delayed(Duration(milliseconds: time1), ()  {print("5");});
              if(imageloadingstate!="complete"){
                time1 = 1000;
                await Future.delayed(Duration(milliseconds: time1), ()  {print("6");});
                if(imageloadingstate!="complete"){
                  time1 = 1000;
                  await Future.delayed(Duration(milliseconds: time1), ()  {print("7");});
                  await convertImageToCropImageFileposter().then((value) async {
                    imageList[i]["lowresofileuriPath"] = value.uri.path;
                    selectedlowIMageuri = value.uri.path;
                    imageList[i]["isCropped"] = "true";
                    imageList[i]["aspectRatio"] = (selected_width / selected_height).toString();
                    Uint8List byte = await value.readAsBytes();
                    pdfimages.add(byte);
                    if (imageList.length - 1 == i) {
                      imageupdate = false;
                      uploadimageposter(context, pdfimages);
                    }
                  });
                } else{
                  await convertImageToCropImageFileposter().then((value) async {
                    imageList[i]["lowresofileuriPath"] = value.uri.path;
                    selectedlowIMageuri = value.uri.path;
                    imageList[i]["isCropped"] = "true";
                    imageList[i]["aspectRatio"] = (selected_width / selected_height).toString();
                    Uint8List byte = await value.readAsBytes();
                    pdfimages.add(byte);
                    if (imageList.length - 1 == i) {
                      imageupdate = false;
                      uploadimageposter(context, pdfimages);
                    }
                  });
                }
              } else{
                await convertImageToCropImageFileposter().then((value) async {
                  imageList[i]["lowresofileuriPath"] = value.uri.path;
                  selectedlowIMageuri = value.uri.path;
                  imageList[i]["isCropped"] = "true";
                  imageList[i]["aspectRatio"] = (selected_width / selected_height).toString();
                  Uint8List byte = await value.readAsBytes();
                  pdfimages.add(byte);
                  if (imageList.length - 1 == i) {
                    imageupdate = false;
                    uploadimageposter(context, pdfimages);
                  }
                });
              }
            } else{
              await convertImageToCropImageFileposter().then((value) async {
                imageList[i]["lowresofileuriPath"] = value.uri.path;
                selectedlowIMageuri = value.uri.path;
                imageList[i]["isCropped"] = "true";
                imageList[i]["aspectRatio"] = (selected_width / selected_height).toString();
                Uint8List byte = await value.readAsBytes();
                pdfimages.add(byte);
                if (imageList.length - 1 == i) {
                  imageupdate = false;
                  uploadimageposter(context, pdfimages);
                }
              });
            }
          } else{
            await convertImageToCropImageFileposter().then((value) async {
              imageList[i]["lowresofileuriPath"] = value.uri.path;
              selectedlowIMageuri = value.uri.path;
              imageList[i]["isCropped"] = "true";
              imageList[i]["aspectRatio"] = (selected_width / selected_height).toString();
              Uint8List byte = await value.readAsBytes();
              pdfimages.add(byte);
              if (imageList.length - 1 == i) {
                imageupdate = false;
                uploadimageposter(context, pdfimages);
              }
            });
          }
        }else{
          await convertImageToCropImageFileposter().then((value) async {
            imageList[i]["lowresofileuriPath"] = value.uri.path;
            selectedlowIMageuri = value.uri.path;
            imageList[i]["isCropped"] = "true";
            imageList[i]["aspectRatio"] = (selected_width / selected_height).toString();
            Uint8List byte = await value.readAsBytes();
            pdfimages.add(byte);
            if (imageList.length - 1 == i) {
              imageupdate = false;
              uploadimageposter(context, pdfimages);
            }
          });
        }*/
        print("4");
      }
    }
  }

  PdfImageOrientation? orientation;
  double? dpi;
  Future<void> uploadimageposter(context, List<Uint8List> pdfimages) async {
    final pdf = pw.Document();
    if (categoryType == "canvas") {
      selected_width = width;
      selected_height = height;
    }
    print(categoryType);
    print(selected_width);
    print(selected_height);
    // return;
    for (int i = 0; i < pdfimages.length; i++) {
      final image =
          pw.MemoryImage(pdfimages[i], orientation: orientation, dpi: dpi);
      print("height1");

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat((selected_width * 2) * PdfPageFormat.cm,
              (selected_height * 2) * PdfPageFormat.cm,
              marginAll: 0.0 * PdfPageFormat.cm),
          build: (pw.Context contxt) {
            return 
              pw.Container(
                decoration: pw.BoxDecoration(
                  image: pw.DecorationImage(
                      image: image, fit: pw.BoxFit.cover),
                ),
            );
          }));
    }
    final output = await getTemporaryDirectory();
    final file =
        io.File(output.path + "/" + DateTime.now().toString() + ".pdf");
    //final io.File = io.File("example.pdf");
    ddd = await file.writeAsBytes(await pdf.save());
    var stream = new http.ByteStream(DelegatingStream.typed(ddd.openRead()));
    var length = await ddd.length();

    var uri = Uri.parse("http://3.65.87.190:5000/upload");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('photos', stream, length,
        filename: basename(ddd.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response1 = await request.send();
    print(response1.statusCode);
    print("sizzzze -" + await getFileSize(ddd, 1));
    await http.Response.fromStream(response1).then((value) async {
      String pdfUrl = json.decode(value.body)["data"]["location"];
      getItemResponseinString().then((items) {
        // print("jsonStingitems - "+items);
        getmainImageListResponseinString().then((mainimages) {
          // print("jsonStringsimageList - "+mainimages);
          //addingCreation = false;
          notifyListeners();
          // print("max_photo - "+max_photo.toString());
          // print("min_photo - "+min_photo.toString());
          // print("product_id - "+product_id.toString());
          // print("product_price - "+product_price.toString());
          // print("selectedSize - "+selectedSize.toString());
          // print("product_name - "+product_name.toString());
          // print("slovaktitle - "+slovaktitle.toString());
          // print("mainimages");
          // print(mainimages);
          // print("items");
          // print(items);
          // Temp
          MemotiDbProvider.db
              .insertCart(
                  categoryType,
                  mainimages,
                  jsonDecode(mainimages)["mainImageList"][0]["base64"],
                  items,
                  max_photo.toString(),
                  min_photo.toString(),
                  product_id,
                  product_price,
                  selectedSize,
                  product_name,
                  slovaktitle,
                  pdfUrl,
                  "1",
                  "pending")
              .then((value) {
            _addcart = false;
            boolerror = false;
            currentIndex = 2;
            notifyListeners();
            imageList = [];
            if (wechatIMages != null) {
              wechatIMages = [];
              imagess = [];
              listGoogleMediaItem = [];
              memotiGalleryPhotoList = [];
              _imageCount = 0;
              _selectedCategoryImage = [];
              images = [];
            }
            Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => TabsPage(),
              ),
              (route) =>
                  false, //if you want to disable back feature set to false
            );
          });
          /* if(cartIndex1!=null&&cartIndex1==-1){
            MemotiDbProvider.db.removecart(cartIndex1).then((value) {
              MemotiDbProvider.db.insertCart(categorytype,mainimages,items,max_photo.toString(),min_photo.toString(),product_id,product_price,selectedSize,product_name,slovaktitle,pdfUrl,"1","pending").then((value) {
                _addcart = false;
                boolerror = false;
                notifyListeners();
                imageList.clear();
                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => TabsPage(),
                  ),
                      (route) => false, //if you want to disable back feature set to false
                );
              });
            });}
          else{
          }*/
        });
      });
    });
  }

  gotoposter(contextmain) async {
    _busy = true;
    notifyListeners();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PosterAfterImageSelectionPage(
              1,
              "poster",
              contextmain,
              selectedCategoryImage,
              max_photo,
              min_photo,
              product_id,
              price,
              selectedSize,
              product_name,
              slovaktitle)),
    );
    for (var x = 0; x < selectedCategoryImage.length; x++) {
      if (selectedCategoryImage[x]["image_type"] == "memoti") {
        selectedCategoryImage[x]["base64"] =
            await networkImageToBase64(selectedCategoryImage[x]["url_image"]);
      }
      if (x == selectedCategoryImage.length - 1) {
        _busy = false;
        notifyListeners();
      }
    }
  }

  addposterOtherData(
      int creation_id,
      String categorytype,
      BuildContext contextmain,
      List imageList,
      int max_photo,
      int min_photo,
      String product_id,
      String product_price,
      String selectedSize,
      String product_name,
      String slovaktitle) async {
    this.creation_id = creation_id;
    this.imageList = imageList;
    this.categoryType = "poster";
    this.max_photo = max_photo;
    this.min_photo = min_photo;
    this.product_id = product_id;
    this.product_price = product_price;

    this.selectedSize = selectedSize;
    this.product_name = product_name;
    this.slovaktitle = slovaktitle;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String stringwidth = selectedSize.split("x")[0];
    String stringHeight = selectedSize.split("x")[1].split("cm")[0];
    selected_width = double.parse(stringwidth);
    selected_height = double.parse(stringHeight);
    width = selected_width;
    height = selected_height;
    print(selected_width);
    print(selected_height);
    user_id = prefs.getString(UiData.user_id) ?? "";
    if (creation_id == -1) {
      for (int i = 0; i < imageList.length; i++) {
        this.imageList[i]["isCropped"] = "false";
      }
    }

    _customFontList.clear();
    imageTextPostionList.clear();
    _fontList.clear();
    editTextPostionList.clear();
    fontsizeList.clear();
    _colorList.clear();
    _bgcolorList.clear();
    textEditingController.text = "";
    customFontList.add(CustomFontItem(
        "/home/vishal/AndroidStudioProjects/memoti-app/fonts/Poppins-Regular.ttf",
        "Poppins"));
    customFontList.add(CustomFontItem(
        "/home/vishal/AndroidStudioProjects/memoti-app/fonts/Quicksand-Medium.ttf",
        "Quicksand"));
    customFontList.add(CustomFontItem(
        "/home/vishal/AndroidStudioProjects/memoti-app/fonts/Raleway-Regular.ttf",
        "Raleway"));

    for (int i = 0; i < customFontList.length; i++) {
      fontList.add(DropdownMenuItem(
        child: Text(
          customFontList[i].fontName,
          style:
              TextStyle(fontSize: 15, fontFamily: customFontList[i].fontspath),
        ),
        value: i,
      ));
    }
    imageTextPostionList.add(ImageTextEditPostion("Top Left", 0.1, 0.1));
    imageTextPostionList.add(ImageTextEditPostion("Top Center", 0.5, 0.1));
    imageTextPostionList.add(ImageTextEditPostion("Top Right", 0.9, 0.1));
    imageTextPostionList.add(ImageTextEditPostion("Center Left", 0.1, 0.5));
    imageTextPostionList.add(ImageTextEditPostion("Center", 0.5, 0.5));
    imageTextPostionList.add(ImageTextEditPostion("Center Right", 0.9, 0.5));
    imageTextPostionList.add(ImageTextEditPostion("Bottom Left", 0.1, 0.8));
    imageTextPostionList.add(ImageTextEditPostion("Bottom Center", 0.5, 0.8));
    imageTextPostionList.add(ImageTextEditPostion("Bottom Right", 0.9, 0.8));
    for (int i = 0; i < imageTextPostionList.length; i++) {
      editTextPostionList.add(DropdownMenuItem(
        child: Text(
          imageTextPostionList[i].name,
          style: TextStyle(fontSize: 15, fontFamily: selectedfontpath),
        ),
        value: i,
      ));
    }
    for (int i = 10; i < 51; i++) {
      fontsizeList.add(DropdownMenuItem(
        child: Text(
          i.toString(),
          style: TextStyle(fontSize: 15, fontFamily: selectedfontpath),
        ),
        value: i,
      ));
    }

    colorList.add(new CustomColor(Colors.white, true));
    colorList.add(new CustomColor(Colors.black, true));
    colorList.add(new CustomColor(Colors.blue, true));
    colorList.add(new CustomColor(Colors.yellow, true));
    colorList.add(new CustomColor(Colors.orange, true));
    colorList.add(new CustomColor(Colors.green, true));
    colorList.add(new CustomColor(Colors.red, true));
    colorList.add(new CustomColor(Colors.brown, true));
  }

  Widget getPhotoGallery(
      BuildContext contextmain, provider, BuildContext context) {
    List list = [];
    print(artistApiCall);
    if (!artistApiCall) {
      fetchArtistList();
    }
    return Column(
      children: [
        Expanded(
          child: buildGridView(context),
        ),
      ],
    );
  }

  setposterData(List products) {
    this.products = products;
  }

  changeposterDimension(int index) {
    print("dimensions.length");
    print(dimensions.length);
    for (int i = 0; i < dimensions.length; i++) {
      if (i == index) {
        selectedSize = dimensions[i]["sizeInString"];
        price = dimensions[i]["price"];
        width = dimensions[i]["width"] * 8;
        height = dimensions[i]["height"] * 8;
        dimensions[i]["isSelected"] = true;
      } else {
        dimensions[i]["isSelected"] = false;
      }
    }

    notifyListeners();
  }

  passpostersizetoProvider(Map product) {
    dimensions = [];

    this.product = product;
    for (int i = 0; i < product["detail"]["sizes"].length; i++) {
      if (i == 0) {
        price = product["detail"]["sizes"][i]["perpage"].toString();
        String stringwidth =
            product["detail"]["sizes"][i]["dimension"].split("x")[0];
        String stringHeight = product["detail"]["sizes"][i]["dimension"]
            .split("x")[1]
            .split("cm")[0];
        double width = double.parse(stringwidth);
        double height = double.parse(stringHeight);
        dimensions.add({
          "price": product["detail"]["sizes"][i]["perpage"],
          "sizeInString": product["detail"]["sizes"][i]["dimension"],
          "width": width,
          "height": height,
          "isSelected": true
        });
        selectedSize = dimensions[i]["sizeInString"];
        this.width = dimensions[i]["width"] * 9;
        this.height = dimensions[i]["height"] * 9;
      } else {
        String stringwidth =
            product["detail"]["sizes"][i]["dimension"].split("x")[0];
        String stringHeight = product["detail"]["sizes"][i]["dimension"]
            .split("x")[1]
            .split("cm")[0];
        double width = double.parse(stringwidth);
        double height = double.parse(stringHeight);
        String sii = product["detail"]["sizes"][i]["dimension"].split("x")[0];
        // print(sii);
        dimensions.add({
          "price": product["detail"]["sizes"][i]["perpage"].toString(),
          "sizeInString": product["detail"]["sizes"][i]["dimension"],
          "width": width,
          "height": height,
          "isSelected": false
        });
      }
    }
    // print("third");
    //notifyListeners();
  }

  void passpostertoProvider(Map product) {
    print(product);
    this.product = product;
    maxPage = product["detail"]["maxpage"].toString();
    minPage = product["detail"]["minpage"].toString();
    sizes.clear();

    for (int i = 0; i < product["detail"]["sizes"].length; i++) {
      sizes.add(product["detail"]["sizes"][i]["dimension"].toString());
    }
    minPrice = product["detail"]["sizes"][0]["perpage"].toString();
    maxPrice = product["detail"]["sizes"][product["detail"]["sizes"].length - 1]
            ["perpage"]
        .toString();
    print(minPrice);
    print(maxPrice);
    doubleminPrice = double.parse(minPrice);
    doublemaxPrice = double.parse(maxPrice);
    doubleMinPage = double.parse(minPage);
    doubleMaxPage = double.parse(maxPage);
    totalminPrice = doubleminPrice * doubleMinPage;
    totalmaxPrice = doublemaxPrice * doubleMaxPage;
  }

/////////////////
////Photobook////
////////////////
  static const igClientId = "582357346469369";
  static const igClientSecret = "e4fd2b530dd397e5cfddcf6ecfe0fd78";
  static const igRedirectURL = "https://memoti.herokuapp.com/auth/";

  FlutterInsta flutterInsta = FlutterInsta();
  /* final simpleAuth.InstagramApi _igApi = simpleAuth.InstagramApi(
    "instagram",
    igClientId,
    igClientSecret,
    igRedirectURL,
    scopes: [
      'user_profile'
   */ /*   'user_profile', // For getting username, account type, etc.
      'user_media',*/ /* // For accessing media count & data like posts, videos etc.
    ],
  );*/
  //Instagram helpin url
  //https://blog.maskys.com/using-the-instagram-basic-display-api-in-flutter/
  Future printDetails(String username, NavigationProvider provider) async {
/* _igApi.authenticate(then(
          (simpleAuth.Account _user) async {
        simpleAuth.OAuthAccount user = _user;

        var igUserResponse =
        await Dio(BaseOptions(baseUrl: 'https://graph.instagram.com')).get(
          '/me',
          queryParameters: {
            // Get the fields you need.
            // https://developers.facebook.com/docs/instagram-basic-display-api/reference/user
            "fields": "username,id,account_type,media_count",
            "access_token": user.token,
          },
        );
        print("username");
        print(igUserResponse.data);
        },
    ).catchError(
          (Object e) {
            print(e);
      },
    );*/
    print("username");
    // if(username!=null && username!=""){
    /*  await flutterInsta.getProfileData(username);
      print(flutterInsta.feedImagesUrl);
      notifyListeners();*/
    // }
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx) {
      return InstagramAPIWebView(
        provider,
        onPressedConfirmation: () {},
      );
    })).then((responseMedias) async {
      if (responseMedias) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String instagram_user_id =
            preferences.getString(UiData.instagram_user_id);
        String instagram_token = preferences.getString(UiData.instagram_token);
        getAllInstaMedias(instagram_user_id, instagram_token).then((mediaList) {
          instamediaList = mediaList;
          notifyListeners();
        });
      }
    });
    /* _igApi.authenticate().then(
          (simpleAuth.Account _user) async {
        simpleAuth.OAuthAccount user = _user;

        var igUserResponse =
        await Dio(BaseOptions(baseUrl: 'https://graph.instagram.com')).get(
          '/me',
          queryParameters: {
            // Get the fields you need.
            // https://developers.facebook.com/docs/instagram-basic-display-api/reference/user
            "fields": "username,id,account_type,media_count",
            "access_token": user.token,
          },
        );
        print("username");
        print(igUserResponse.data);
        },
    ).catchError(
          (Object e) {
            print(e);
      },
    );*/
  }

  String get maxpage => maxPage;
  dynamic product;
  late String maxPage;
  late String minPage;
  late String minPrice;
  late String maxPrice;
  List<String> sizes = [];
  List bindings = [];
  late double doubleminPrice;
  late double doublemaxPrice;
  late double doubleMinPage;
  late double doubleMaxPage;
  late double totalminPrice;
  late double totalmaxPrice;
  bool viewVisible = false;

  void showMoreDetail() {
    viewVisible = !viewVisible;
    notifyListeners();
  }

  void passtoProvider1(dynamic product, String wheres) {
    where = wheres;
    maxPage = product[0]["detail"]["maxpage"].toString();
    minPage = product[0]["detail"]["minpage"].toString();
    sizes.clear();
    bindings.clear();
    for (int i = 0;
        i < product[0]["detail"]["sizes"][0]["binding"].length;
        i++) {
      bindings.add(product[0]["detail"]["sizes"][0]["binding"][i].toString());
    }
    for (int i = 0; i < product[0]["detail"]["sizes"].length; i++) {
      sizes.add(product[0]["detail"]["sizes"][i]["dimension"].toString());
    }
    minPrice = product[0]["detail"]["sizes"][0]["perpage"].toString();
    maxPrice = product[0]["detail"]["sizes"]
            [product[0]["detail"]["sizes"].length - 1]["perpage"]
        .toString();
    doubleminPrice = double.parse(minPrice);
    doublemaxPrice = double.parse(maxPrice);
    doubleMinPage = double.parse(minPage);
    doubleMaxPage = double.parse(maxPage);
    totalminPrice = doubleminPrice * doubleMinPage;
    totalmaxPrice = doublemaxPrice * doubleMaxPage;
  }

  double width = 1520;
  double height = 1520;
  late List<Map> dimensions;
  String price = "24.99€";
  String selectedSize = "";
  String selectedbinding = "";

  // Map product = null;

  passtoProvider(dynamic product, String wheres) {
    dimensions = [];
    _busy = true;
    //notifyListeners();
    this.product = product[0];

    max_photo = int.parse(product[0]["detail"]["maxpage"].toString());
    min_photo = int.parse(product[0]["detail"]["minpage"].toString());
    where = wheres;
    print("second");
    print(where);
    for (int i = 0; i < product[0]["detail"]["sizes"].length; i++) {
      // print(product[0]["detail"]["sizes"][i]["perpage"]);
      // print(product[0]["detail"]["sizes"][i]["dimension"]);
      if (i == 0) {
        print(product[0]["detail"]["title"]);
        price = product[0]["detail"]["sizes"][i]["perpage"] + "€";
        product_price = product[0]["detail"]["sizes"][i]["perpage"].toString();
        String stringwidth =
            product[0]["detail"]["sizes"][i]["dimension"].split("x")[0];
        String stringHeight = product[0]["detail"]["sizes"][i]["dimension"]
            .split("x")[1]
            .split("cm")[0];
        double width = double.parse(stringwidth);
        double height = double.parse(stringHeight);
        dimensions.add({
          "price": product[0]["detail"]["sizes"][i]["perpage"],
          "sizeInString": product[0]["detail"]["sizes"][i]["dimension"],
          "width": width,
          "height": height,
          "isSelected": true
        });
        selectedSize = dimensions[i]["sizeInString"];
        print(selectedSize);
        print("hhhhhhhhhhhhhhhhhhh");
        print(dimensions[i]["height"]);
        this.width = dimensions[i]["width"] * 5;
        this.height = dimensions[i]["height"] * 5;
        bindings = [];
        for (int j = 0;
            j < product[0]["detail"]["sizes"][0]["binding"].length;
            j++) {
          print(product[0]["detail"]["sizes"][i]["binding"][j]);
          if (j == 0) {
            bindings.add({
              "name": product[0]["detail"]["sizes"][0]["binding"][j],
              "isSelected": true
            });
            selectedbinding = bindings[j]["name"];
          } else {
            bindings.add({
              "name": product[0]["detail"]["sizes"][0]["binding"][j],
              "isSelected": false
            });
          }
        }
      } else {
        String stringwidth =
            product[0]["detail"]["sizes"][i]["dimension"].split("x")[0];
        String stringHeight = product[0]["detail"]["sizes"][i]["dimension"]
            .split("x")[1]
            .split("cm")[0];
        double width = double.parse(stringwidth);
        double height = double.parse(stringHeight);
        print(width);
        print(height);
        String sii =
            product[0]["detail"]["sizes"][i]["dimension"].split("x")[0];
        print(sii);
        dimensions.add({
          "price": product[0]["detail"]["sizes"][i]["perpage"],
          "sizeInString": product[0]["detail"]["sizes"][i]["dimension"],
          "width": 28,
          "height": 28,
          "isSelected": false
        });
      }
    }
    _busy = false;
    print("third");
    //notifyListeners();
  }

  changeDimension(int index) {
    for (int i = 0; i < dimensions.length; i++) {
      if (i == index) {
        selectedSize = dimensions[i]["sizeInString"];
        price = dimensions[i]["price"] + "€";
        product_price = dimensions[i]["price"];
        width = dimensions[i]["width"] * 5;
        height = dimensions[i]["height"] * 5;
        dimensions[i]["isSelected"] = true;
        bindings = [];
        for (int j = 0;
            j < product["detail"]["sizes"][i]["binding"].length;
            j++) {
          if (i == 0) {
            bindings.add({
              "name": product["detail"]["sizes"][0]["binding"][j],
              "isSelected": true
            });
            selectedbinding = bindings[j]["name"];
          } else {
            bindings.add({
              "name": product["detail"]["sizes"][0]["binding"][j],
              "isSelected": false
            });
          }
        }
      } else {
        dimensions[i]["isSelected"] = false;
      }
    }

    notifyListeners();
  }

  changeBindings(int index) {
    for (int i = 0; i < bindings.length; i++) {
      if (i == index) {
        bindings[i]["isSelected"] = true;
        selectedbinding = bindings[i]["name"];
      } else {
        bindings[i]["isSelected"] = false;
      }
    }
    notifyListeners();
  }

///////////////////////////
////New Photo Selection////
///////////////////////////

  String product_price = "";
  String product_name = "";
  String slovaktitle = "";
  String where = "";
  int _currentScreenIndex = 0;
  int get currentTabIndex => _currentScreenIndex;
  int _imageCount = 0;
  int get imageCount => _imageCount;
  List _selectedCategoryImage = [];
  List get selectedCategoryImage => _selectedCategoryImage;
  bool photoProcessingworking = false;
  List _categoryImage = [];
  List get categoryImage => _categoryImage;
  List memotiGalleryPhotoList = [];
  List memotiGalleryPhotoList1 = [];
  List images = [];
  List imagess = [];
  String _dialog_text = "";
  String get dialog_text => _dialog_text;
  String _dialog_title = "";
  String get dialog_title => _dialog_title;
  bool doneClikTap = false;
  late String selected_artist_id;
  bool isautoselectedimageget = false;
  bool autoselcttap = false;
  bool artistApiCall = false;
  late MemotiGalleryCategoryResponse memotiGalleryCategoryResponse;
  late MemotiGalleryPhotosReponse memotiGalleryPhotosReponse;
  late MemotiGalleryPhotosReponse memotiGalleryPhotosReponse1;
  late ArtistListResponse artistListResponse;
  late List artistLists;
  fetchArtistList() async {
    print("123456");
    isautoselectedimageget = true;
    artistApiCall = true;
    //notifyListeners();
    var url = Uri.parse(
        'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/people/vendor');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      artistListResponse =
          ArtistListResponse.fromJson(json.decode(response.body));
      print(artistListResponse);
      artistLists = [];
      artistLists.add({'pi': "all", 'title': "All"});
      for (var x = 0; x < artistListResponse.data.length; x++) {
        artistLists.add({
          'pi': artistListResponse.data[x].pi,
          'title': artistListResponse.data[x].title
        });
      }
      fetchCtaegoryList();
      return artistListResponse;
    } else {
      throw Exception('Failed to load album');
    }
  }

  fetchCtaegoryList() async {
    var url = Uri.parse(
        'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/inventory/gallerycategory');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      memotiGalleryCategoryResponse =
          MemotiGalleryCategoryResponse.fromJson(json.decode(response.body));
      print(memotiGalleryCategoryResponse);
      fetchMemootyGalleryPhptosList();
      return memotiGalleryCategoryResponse;
    } else {
      throw Exception('Failed to load album');
    }
  }

  fetchMemootyGalleryPhptosList() async {
    var url = Uri.parse(
        'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/inventory/photo');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // print("memotiGalleryPhotosReponse response -" + response.body);
      memotiGalleryCategoryResponse.data.items[0].is_selected = true;
      // selected_artist_id = artistListResponse.data[0].pi;
      selected_artist_id = artistLists[0]["pi"];
      memotiGalleryPhotosReponse =
          MemotiGalleryPhotosReponse.fromJson(json.decode(response.body));
      for (int i = 0; i < memotiGalleryPhotosReponse.data.items.length; i++) {
        for (int j = 0;
            j < memotiGalleryPhotosReponse.data.items[i].photos.photo.length;
            j++) {
          memotiGalleryPhotoList1.add({
            "checked": false,
            "image": "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
                memotiGalleryPhotosReponse.data.items[i].photos.photo[j]
          });
          if (memotiGalleryPhotosReponse.data.items[i].vendorId ==
                  artistListResponse.data[0].pi &&
              memotiGalleryPhotosReponse.data.items[i].categoryId ==
                  memotiGalleryCategoryResponse.data.items[0].ii) {
            // memotiGalleryPhotoList.add({"checked": false, "image": "https://memotiapp.s3.eu-central-1.amazonaws.com/"+memotiGalleryPhotosReponse.data.items[i].photos.photo[j]});
            memotiGalleryPhotoList.add({
              "id": (10000 + i).toString(),
              "name": "",
              "createdDate": new DateTime.now().toIso8601String(),
              "fileuriPath": new io.File("a.txt").uri.path,
              "lowresofileuriPath": new io.File("a.txt").uri.path,
              // "uint8list": new Uint8List(0),
              "uintid": "",
              "size": new Size(0.0, 0.0),
              "image_type": "memoti",
              "url_image": "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
                  memotiGalleryPhotosReponse.data.items[i].photos.photo[j],
              "count": "1",
              "isCropped": "false",
              "aspectRatio": "",
              "isSelected": false
            });
            print("memotiGalleryPhotoList");
          }
        }
      }
      memoti_gallery_Data_Got = true;
      notifyListeners();
      return memotiGalleryPhotosReponse;
    } else {
      throw Exception('Failed to load album');
    }
    notifyListeners();
  }

  increaseCount(int index, BuildContext context, BuildContext contextmain) {
    bool add = false;
    int pos = 0;
    int pagePos = -1;
    int length = _getItems[_getItems.length - 1]["imageModel"].imageType.length;
    // print("length - "+ length.toString());
    for (int i = 0; i < length; i++) {
      if (_getItems[_getItems.length - 1]["imageModel"].imageType[i] == "") {
        pos = i;
        add = true;
        break;
      }
    }
    if (add) {
      pagePos = _getItems.length - 1;
      //_getItems[_getItems.length-1]["imageModel"].aspectRatio[pos] = mainImageList[index]["aspectRatio"];
      _getItems[_getItems.length - 1]["imageModel"].iscroppeds[pos] =
          mainImageList[index]["isCropped"];
      _getItems[_getItems.length - 1]["imageModel"].imageType[pos] =
          mainImageList[index]["image_type"];
      _getItems[_getItems.length - 1]["imageModel"].imageUrl[pos] =
          mainImageList[index]["url_image"];
      _getItems[_getItems.length - 1]["imageModel"].fileuriPathlowreso[pos] =
          mainImageList[index]["lowresofileuriPath"];
      _getItems[_getItems.length - 1]["imageModel"].base64[pos] =
          mainImageList[index]["base64"];
      _getItems[_getItems.length - 1]["imageModel"].fileuriPath[pos] =
          mainImageList[index]["fileuriPath"];
      _getItems[_getItems.length - 1]["imageModel"].imageQualityColor[pos] =
          getImageDpiColor(mainImageList[index]["size"]);
    } else {
      pagePos = _getItems.length;
      List<String> imageQualityColor = [];
      List<String> imageType = [];
      List<String> imagefileuripath = [];
      List<String> imagefileuripathlowreso = [];
      List<String> imageUrl = [];
      List<String> iscroppeds = [];
      List<String> aspectRatio = [];
      List<Uint8List> uINtimagelist = [];
      List<String> uintid = [];
      List<String> base64 = [];
      iscroppeds.add(mainImageList[index]["isCropped"]);
      uINtimagelist.add(mainImageList[index]["uint8list"]);
      uintid.add(mainImageList[index]["uintid"]);
      aspectRatio.add(mainImageList[index]["aspectRatio"]);
      imageType.add(mainImageList[index]["image_type"]);
      imagefileuripath.add(mainImageList[index]["fileuriPath"]);
      base64.add(mainImageList[index]["base64"]);
      imagefileuripathlowreso.add(mainImageList[index]["lowresofileuriPath"]);
      imageUrl.add(mainImageList[index]["url_image"]);
      imageQualityColor.add(getImageDpiColor(mainImageList[index]["size"]));
      imageType.add("");
      imagefileuripath.add("");
      base64.add("");
      imagefileuripathlowreso.add("");
      imageUrl.add("");
      imageQualityColor.add("");
      _getItems.add({
        "layout_id": "1",
        "isSelected": false,
        "imageModel": ImageModel(
            uINtimagelist,
            uintid,
            imageType,
            imageUrl,
            imagefileuripath,
            imagefileuripathlowreso,
            iscroppeds,
            aspectRatio,
            imageQualityColor,
            base64),
        "categoryType": categoryType
      });
      starting_page_count = starting_page_count + 1;
    }
    mainImageList[index]["count"] = mainImageList[index]["count"] +
        "," +
        pagePos.toString() +
        "," +
        pos.toString();

    setExpand("0", "expandclosed");
    notifyListeners();
  }

  getTotalImageCount() {
    if (_selectedCategoryImage != null) {
      _imageCount = _selectedCategoryImage.length;
      notifyListeners();
      print("imageCount - " + _imageCount.toString());
    }
  }

  // bool
  uncheckImageAddedorNot1(item, int index) {
    wechatIMages.removeAt(index);
    imagess.removeAt(index);
    _selectedCategoryImage
        .removeWhere((element) => element["id"] == item["id"]);
    getTotalImageCount();
    notifyListeners();
  }

  availableCameras() async {
    return CameraPlatform.instance.availableCameras();
  }

  Widget buildGridView(BuildContext context) {
    return imagess.length > 0
        ? Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height - 320,
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: imagess.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 2),
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1),
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () async {
                                var ind = selectedCategoryImage.indexWhere(
                                    (items) =>
                                        items["id"] == wechatIMages[index].id);
                                if (ind > -1) {
                                  uncheckImageAddedorNot1(
                                      selectedCategoryImage[ind], index);
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.all(0.0),
                                  child: Stack(
                                    children: <Widget>[
                                      //AssetThumb(asset: images[index], width: 300, height: 300),
                                      Image.memory(
                                        imagess[index],
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        color: Colors.black.withOpacity(0.1),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Icon(
                                              Icons.check_circle_outline,
                                              color: MyColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )));
                          //            return index==provider.listGoogleMediaItem.length?Container():GooglePhotoItem( provider, index, context, provider.listGoogleMediaItem[index+1] );
                        })),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (_imageCount < max_photo) {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CameraClass()));
                            if (result != null) {
                              final Uint8List byteData = await result
                                  .readAsBytes(); // Convert to Uint8List
                              final AssetEntity? imageEntity =
                                  await PhotoManager.editor.saveImage(byteData);
                              await imageEntity!
                                  .thumbDataWithSize(200, 200)
                                  .then((value) {
                                imagess.add(value);
                              });
                              wechatIMages.add(imageEntity);
                              print("id");
                              print(imageEntity.id);
                              io.File? imagefile = await imageEntity.originFile;
                              print("originFile");
                              print(imagefile!.uri.path);
                              String id = imageEntity.id;
                              String name = "";
                              name = (imageEntity.title)!;
                              if (name == null) {
                                name = await imageEntity.titleAsync;
                              }
                              _selectedCategoryImage.add({
                                "id": id,
                                "name": name,
                                "createdDate": imageEntity
                                    .createDateTime.millisecond
                                    .toString(),
                                "fileuriPath":
                                    imagefile.uri.path.replaceAll("%20", " "),
                                "lowresofileuriPath":
                                    imagefile.uri.path.replaceAll("%20", " "),
                                "base64": await converttobase64bytes(
                                    imagefile.uri.path.replaceAll("%20", " ")),
                                // "uint8list": imagess[imagess.length - 1],
                                "uintid": "",
                                "size": imageEntity.size,
                                "image_type": "phone",
                                "url_image": "",
                                "count": "1",
                                "isCropped": "false",
                                "aspectRatio": "",
                                "isSelected": false
                              });
                              getTotalImageCount();
                              notifyListeners();
                            }
                          } else {
                            setMaxPhotoImageCheck(context);
                            _showMyDialog();
                          }
                        },
                        child: Container(
                          child: Center(
                            child: Container(
                              width: 130,
                              height: 50,
                              decoration: BoxDecoration(
                                  // border: Border.all(color: MyColors.textColor, width: 2),
                                  color: MyColors.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Center(
                                child: Text(
                                  Languages.of(context)!.Camera,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_imageCount <= max_photo) {
                            loadweChatAsset(context);
                          } else {
                            setMaxPhotoImageCheck(context);
                            _showMyDialog();
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Center(
                              child: Container(
                            width: 130,
                            height: 50,
                            decoration: BoxDecoration(
                                color: MyColors.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                            child: Center(
                              child: Text(
                                // Choose images after images select
                                Languages.of(context)!.Chooseimages,
                                // "",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: Container(
              height: 200,
              child: Column(
                children: [
                  InkWell(
                      onTap: () async {
                        if (_imageCount < max_photo) {
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CameraClass()));
                          if (result != null) {
                            final Uint8List byteData = await result
                                .readAsBytes(); // Convert to Uint8List
                            final AssetEntity? imageEntity =
                                await PhotoManager.editor.saveImage(byteData);
                            await imageEntity!
                                .thumbDataWithSize(200, 200)
                                .then((value) {
                              imagess.add(value);
                            });
                            wechatIMages.add(imageEntity);
                            print("id");
                            print(imageEntity.id);
                            io.File? imagefile = await imageEntity.originFile;
                            print("originFile");
                            print(imagefile!.uri.path);
                            String id = imageEntity.id;
                            String name = "";
                            name = (imageEntity.title)!;
                            if (name == null) {
                              name = await imageEntity.titleAsync;
                            }
                            _selectedCategoryImage.add({
                              "id": id,
                              "name": name,
                              "createdDate": imageEntity
                                  .createDateTime.millisecond
                                  .toString(),
                              "fileuriPath":
                                  imagefile.uri.path.replaceAll("%20", " "),
                              "lowresofileuriPath":
                                  imagefile.uri.path.replaceAll("%20", " "),
                              // "uint8list": imagess[imagess.length - 1],
                              "base64": await converttobase64bytes(
                                  imagefile.uri.path.replaceAll("%20", " ")),
                              "uintid": "",
                              "size": imageEntity.size,
                              "image_type": "phone",
                              "url_image": "",
                              "count": "1",
                              "isCropped": "false",
                              "aspectRatio": "",
                              "isSelected": false
                            });
                            getTotalImageCount();
                            notifyListeners();
                          }
                        } else {
                          setMaxPhotoImageCheck(context);
                          _showMyDialog();
                        }
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            // border: Border.all(color: MyColors.textColor, width: 2),
                            color: MyColors.primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Center(
                          child: Text(
                            Languages.of(context)!.Camera,
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 24,
                  ),
                  InkWell(
                    onTap: () {
                      if (_imageCount < max_photo) {
                        loadweChatAsset(context);
                      } else {
                        setMaxPhotoImageCheck(context);
                        _showMyDialog();
                      }
                      print("assets");
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          // border: Border.all(color: MyColors.textColor, width: 2),
                          color: MyColors.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Center(
                        child: Text(
                          // Choose images before selecting images
                          Languages.of(context)!.Chooseimages,
                          // "",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  updatevalues(minvalue, maxvalue) {
    max_photo = maxvalue;
    min_photo = minvalue;
    notifyListeners();
  }

  /// Set currently visible tab.
  void setTab(int tab) {
    /*_currentScreenIndex = tab;
    currentPage = pages[tab];
    notifyListeners();*/
    if (tab == currentTabIndex) {
      debugPrint("same tab click");
    } else {
      _currentScreenIndex = tab;
      notifyListeners();
    }
  }

  /*Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dialog_title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(dialog_text),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
                child: Text(Languages.of(context)!.Ok),
                onPressed:  () {
                  // Navigator.of(context).pop();
                  //loadAssets();
                  loadweChatAsset(context);
                }),
          ],
        );
      },
    );
  }*/
  static Future<PermissionState> permissionCheck() async {
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
    if (_ps != PermissionState.authorized && _ps != PermissionState.limited) {
      throw StateError('Permission state error with $_ps.');
    }
    return _ps;
  }

  static Future<List<AssetEntity>?> pickAssets(
    BuildContext context, {
    List<AssetEntity>? selectedAssets,
    int maxAssets = 9,
    int pageSize = 80,
    int gridThumbSize = Constants.defaultGridThumbSize,
    int pathThumbSize = 80,
    int gridCount = 4,
    RequestType requestType = RequestType.image,
    List<int>? previewThumbSize,
    SpecialPickerType? specialPickerType,
    Color? themeColor,
    ThemeData? pickerTheme,
    SortPathDelegate? sortPathDelegate,
    AssetsPickerTextDelegate? textDelegate,
    FilterOptionGroup? filterOptions,
    WidgetBuilder? specialItemBuilder,
    IndicatorBuilder? loadingIndicatorBuilder,
    SpecialItemPosition specialItemPosition = SpecialItemPosition.none,
    bool allowSpecialItemWhenEmpty = false,
    bool useRootNavigator = true,
    Curve routeCurve = Curves.easeIn,
    Duration routeDuration = const Duration(milliseconds: 300),
  }) async {
    if (maxAssets < 1) {
      throw ArgumentError(
        'maxAssets must be greater than 1.',
      );
    }
    if (pageSize % gridCount != 0) {
      throw ArgumentError(
        'pageSize must be a multiple of gridCount.',
      );
    }
    if (pickerTheme != null && themeColor != null) {
      throw ArgumentError(
        'Theme and theme color cannot be set at the same time.',
      );
    }
    if (specialPickerType == SpecialPickerType.wechatMoment) {
      if (requestType != RequestType.image) {
        throw ArgumentError(
          'SpecialPickerType.wechatMoment and requestType cannot be set at the same time.',
        );
      }
      requestType = RequestType.common;
    }
    if ((specialItemBuilder == null &&
            specialItemPosition != SpecialItemPosition.none) ||
        (specialItemBuilder != null &&
            specialItemPosition == SpecialItemPosition.none)) {
      throw ArgumentError('Custom item did not set properly.');
    }

    final PermissionState _ps = await permissionCheck();

    final DefaultAssetPickerProvider provider = DefaultAssetPickerProvider(
      maxAssets: maxAssets,
      pageSize: pageSize,
      pathThumbSize: pathThumbSize,
      selectedAssets: selectedAssets,
      requestType: requestType,
      // sortPathDelegate: sortPathDelegate,
      filterOptions: filterOptions,
      routeDuration: routeDuration,
    );
    final Widget picker =
        ChangeNotifierProvider<DefaultAssetPickerProvider>.value(
      value: provider,
      child: AssetPicker<AssetEntity, AssetPathEntity>(
        key: Constants.pickerKey,
        builder: DefaultAssetPickerBuilderDelegate(
          provider: provider,
          gridCount: gridCount,
          textDelegate: textDelegate,
          themeColor: themeColor,
          pickerTheme: pickerTheme,
          gridThumbSize: gridThumbSize,
          previewThumbSize: previewThumbSize,
          specialPickerType: specialPickerType,
          specialItemPosition: specialItemPosition,
          specialItemBuilder: specialItemBuilder,
          loadingIndicatorBuilder: loadingIndicatorBuilder,
          allowSpecialItemWhenEmpty: allowSpecialItemWhenEmpty,
          initialPermission: PermissionState.limited,
        ),
      ),
    );
    final List<AssetEntity>? result = await Navigator.of(
      context,
      rootNavigator: useRootNavigator,
    ).push<List<AssetEntity>>(
      AssetPickerPageRoute<List<AssetEntity>>(
        builder: picker,
        transitionCurve: routeCurve,
        transitionDuration: routeDuration,
      ),
    );
    return result;
  }

  BuildContext get context => _context;
  late BuildContext _context;
  updatecontext(contexts) {
    _context = contexts;
  }

  List<AssetEntity> wechatIMages = [];

  late List<AssetEntity> resultList;
  Future<void> loadweChatAsset(contexts) async {
    // print("provider.where");
    // print(where);
    // print("Load images");
    // ignore: deprecated_member_use
    // List<AssetEntity>();
    String error = 'No Error Dectected';
    try {
      resultList = (await AssetPicker.pickAssets(contexts,
          selectedAssets: wechatIMages,
          requestType: RequestType.image,
          maxAssets: max_photo,
          textDelegate: EnglishTextDelegate(),
          previewThumbSize: const <int>[500, 500],
          gridThumbSize: 300,
          pickerTheme: ThemeData.light().copyWith(
              buttonColor: MyColors.primaryColor,
              brightness: Brightness.light,
              primaryColor: MyColors.primaryColor,
              appBarTheme: const AppBarTheme(
                brightness: Brightness.light,
                elevation: 12,
              ),
              colorScheme: ColorScheme(
                primary: Colors.white,
                primaryVariant: Colors.white12,
                secondary: Colors.white,
                secondaryVariant: Colors.white,
                background: Colors.white,
                surface: Colors.white,
                brightness: Brightness.light,
                error: const Color(0xffcf6679),
                onPrimary: Colors.white,
                onSecondary: Colors.white,
                onSurface: Colors.white,
                onBackground: Colors.white,
                onError: Colors.redAccent,
              ))))!;
    } on Exception catch (e) {
      error = e.toString();
    }
    // print(resultList);
    // print("resultList.length - "+resultList.length.toString());
    if (resultList.length > max_photo) {
      setMaxPhotoImageCheck(context);
      _showMyDialog();
    }
    wechatIMages = resultList;
    imagess.clear();
    for (int i = 0; i < wechatIMages.length; i++) {
      await wechatIMages[i].thumbDataWithSize(200, 200).then((value) {
        imagess.add(value);
        if (i == wechatIMages.length - 1) {
          //notifyListeners();
        }
      });
    }
    print("imagess.length - " + imagess.length.toString());
    if (wechatIMages.length > 0) {
      _busy = true;
      notifyListeners();
      _selectedCategoryImage.clear();
      for (var a = 0; a < memotiGalleryPhotoList.length; a++) {
        if (memotiGalleryPhotoList[a]["isSelected"]) {
          _selectedCategoryImage.add(memotiGalleryPhotoList[a]);
        }
      }
      for (var a = 0; a < instamediaList.length; a++) {
        if (instamediaList[a]["isSelected"]) {
          _selectedCategoryImage.add(instamediaList[a]);
        }
      }
      for (var a = 0; a < listGoogleMediaItem.length; a++) {
        if (listGoogleMediaItem[a]["isSelected"]) {
          _selectedCategoryImage.add(listGoogleMediaItem[a]);
        }
      }

      for (var x = 0; x < wechatIMages.length; x++) {
        photoProcessingworking = true;
        io.File? imagefile = await wechatIMages[x].originFile;
        if (imagefile != null) {
          String id = wechatIMages[x].id;
          String name = "";
          name = (wechatIMages[x].title)!;
          if (name == null) {
            name = await wechatIMages[x].titleAsync;
          }

          //File imagefilelowreso = await writeToFile(byteDatalowreso, images[x].name);
          // print("imagefile");
          // print(imagefile);
          // print(imagefile.uri);
          // print(imagefile.uri.path);
          // print(imagess[x]);
          print("imagefile.uri");
          print(imagefile.path);
          // if(imagefile.uri){

          // }
          String compressedimagepath = await converttobase64(imagefile.path);
          String base64bytes = await converttobase64bytes(imagefile.path);
          checkImageAddedorNot1({
            "id": id,
            "name": name,
            "createdDate": wechatIMages[x].createDateTime.toIso8601String(),
            // "fileuriPath":imagefile.uri.path.replaceAll("%20", " "),
            // "lowresofileuriPath":imagefile.uri.path.replaceAll("%20", " "),
            "fileuriPath": compressedimagepath.replaceAll("%20", " "),
            "lowresofileuriPath": compressedimagepath.replaceAll("%20", " "),
            // "uint8list": imagess[x],
            "base64": base64bytes,
            "uintid": "",
            "size": wechatIMages[x].size,
            "image_type": "phone",
            "url_image": "",
            "count": "1",
            "isCropped": "false",
            "aspectRatio": "",
            "isSelected": false
          }, x);
        }
        photoProcessingworking = false;
        if (wechatIMages.length - 1 == x) {
          _busy = false;
        }
      }
    } else {
      unselectAll();
    }
  }

  converttobase64(image) async {
    // var pp = '';
    // if(image.contains('%20')){
    //   pp = image.replaceAll('%20', '\ ');
    // }
    io.File compressedFile =
        await FlutterNativeImage.compressImage(image, quality: 20);
    return compressedFile.path;
  }

  converttobase64bytes(image) async {
    // var pp = '';
    // if(image.contains('%20')){
    //   pp = image.replaceAll('%20', '\ ');
    // }
    io.File compressedFile =
        await FlutterNativeImage.compressImage(image, quality: 20);
    final bytes = compressedFile.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    return base64Image;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dialog_title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(dialog_text),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
                child: Text(
                  Languages.of(context)!.Ok,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  changeFilterUrl(int index) {
    print("changeFilter");
    for (int i = 0; i < _filterListUrl.length; i++) {
      if (i == index) {
        _selected_filter = _filterListUrl[i].filter;
        _filterListUrl[i].isSelected = true;
      } else {
        _filterListUrl[i].isSelected = false;
      }
    }
    notifyListeners();
  }

  changeFilter(int index) {
    print("changeFilter");
    for (int i = 0; i < _filterList.length; i++) {
      if (i == index) {
        print(index);
        _selected_filter = _filterList[i].filter;
        _filterList[i].isSelected = true;
      } else {
        _filterList[i].isSelected = false;
      }
    }
    notifyListeners();
  }

  changeBGColor(int index) {
    print("changeBGColor");
    for (int i = 0; i < bgcolortList.length; i++) {
      if (i == index) {
        currentBGColor = bgcolortList[i].color;
        bgcolortList[i].isSelected = true;
      } else {
        bgcolortList[i].isSelected = false;
      }
    }
    notifyListeners();
  }

  changeTExtColor(int index) {
    print("changeTExtColor");
    for (int i = 0; i < colortList.length; i++) {
      if (i == index) {
        currenttextColor = colortList[i].color;
        colortList[i].isSelected = true;
      } else {
        colortList[i].isSelected = false;
      }
    }
    notifyListeners();
  }

  Future<Size> _calculateImageDimension(String imageData) {
    print("image url - " + imageData);
    Completer<Size> completer = Completer();
    Image image = Image.network(imageData);
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
          print("size - " + size.toString());
        },
      ),
    );
    return completer.future;
  }

  bool _addinginside = false;
  get addinginside => _addinginside;
  setdaya(item) async {
    _addinginside = true;
    print("where");
    print(where);
    if (where == "photobookcustomization") {
      item["base64"] = await networkImageToBase64(item["url_image"]);
      // item["uint8list"] = [await networkImageToBase64bytes(item["url_image"])];
      _selectedCategoryImage.add(item);
      _addinginside = false;
      getTotalImageCount();
    } else if (where == "photobook") {
      item["base64"] = await networkImageToBase64(item["url_image"]);
      // item["uint8list"] = [await networkImageToBase64bytes(item["url_image"])];
      _selectedCategoryImage.add(item);
      _addinginside = false;
      getTotalImageCount();
    } else if (where == "postercustomization") {
      item["base64"] = await networkImageToBase64(item["url_image"]);
      // item["uint8list"] = [await networkImageToBase64bytes(item["url_image"])];
      _selectedCategoryImage.add(item);
      _addinginside = false;
      getTotalImageCount();
    } else {
      _selectedCategoryImage.add(item);
      _addinginside = false;
      getTotalImageCount();
    }
    notifyListeners();
  }

  bool checkImageAddedorNot(item, int index, BuildContext context) {
    print("_imageCount");
    print(_imageCount);
    print("_imageCount");
    bool check;
    String imagetype = item["image_type"];
    print(imagetype);
    print(item["url_image"]);
    print(_imageCount < max_photo);
    print(_imageCount < min_photo);
    // return true;
    // for(var x = 0; x<albumwithmediaList11.length; x++){
    //   print(albumwithmediaList11[x].id);
    // }
    if (item["isSelected"]) {
      if (imagetype == "memoti") {
        var ind = memotiGalleryPhotoList
            .indexWhere((items) => items["id"] == item["id"]);
        memotiGalleryPhotoList[ind]["isSelected"] = false;
      } else if (imagetype == "instagram") {
        var ind =
            instamediaList.indexWhere((items) => items["id"] == item["id"]);
        print("ind");
        print(ind);
        instamediaList[ind]["isSelected"] = false;
      } else if (imagetype == "google") {
        var ind = listGoogleMediaItem
            .indexWhere((items) => items["id"] == item["id"]);
        print("ind");
        print(ind);
        listGoogleMediaItem[ind]["isSelected"] = false;
      } else {
        _categoryImage[index]["isSelected"] = false;
      }
      _selectedCategoryImage.removeWhere((element) =>
          element["id"] ==
          item[
              "id"] /*{ element.id == item.id;  debugPrint("element_id  "+element.id.toString()+"item_id  "+item.id.toString());}*/);
      check = true;
      getTotalImageCount();
      notifyListeners();
      return check;
    } else {
      if (_imageCount < max_photo) {
        // print("_imageCount < max_photo");
        if (imagetype == "memoti") {
          // print(memotiGalleryPhotoList);
          // print(item);
          var ind = memotiGalleryPhotoList
              .indexWhere((items) => items["id"] == item["id"]);
          // print(ind);
          memotiGalleryPhotoList[ind]["isSelected"] = true;
        } else if (imagetype == "instagram") {
          var ind =
              instamediaList.indexWhere((items) => items["id"] == item["id"]);
          print("ind");
          print(ind);
          print(item["id"]);
          instamediaList[ind]["isSelected"] = true;
        } else if (imagetype == "google") {
          var ind = listGoogleMediaItem
              .indexWhere((items) => items["id"] == item["id"]);
          print("ind");
          print(ind);
          print(item["id"]);
          listGoogleMediaItem[ind]["isSelected"] = true;
        } else {
          _categoryImage[index]["isSelected"] = true;
        }
        if (imagetype == "memoti") {
          setdaya(item);
          check = true;
          getTotalImageCount();
          notifyListeners();
          return check;
        } else if (imagetype == "instagram") {
          // _selectedCategoryImage.add(item);
          setdaya(item);
          check = true;
          getTotalImageCount();
          notifyListeners();
          return check;
        } else if (imagetype == "google") {
          // _selectedCategoryImage.add(item);
          setdaya(item);
          check = true;
          getTotalImageCount();
          notifyListeners();
          return check;
        } else {
          _selectedCategoryImage.add(item);
          check = true;
          getTotalImageCount();
          notifyListeners();
          return check;
        }
      } else if (_imageCount < min_photo) {
        // print("_imageCount < min_photo");
        if (imagetype == "memoti") {
          var ind =
              memotiGalleryPhotoList.indexWhere((items) => items.id == item.id);
          memotiGalleryPhotoList[ind]["isSelected"] = true;
        } else if (imagetype == "instagram") {
          var ind = instamediaList.indexWhere((items) => items.id == item.id);
          // print("ind");
          // print(ind);
          instamediaList[ind]["isSelected"] = true;
        } else if (imagetype == "google") {
          var ind =
              listGoogleMediaItem.indexWhere((items) => items.id == item.id);
          print("ind");
          print(ind);
          listGoogleMediaItem[ind]["isSelected"] = true;
        } else {
          _categoryImage[index]["isSelected"] = true;
        }
        if (imagetype == "memoti") {
          _selectedCategoryImage.add(item);
          check = true;
          getTotalImageCount();
          notifyListeners();
          return check;
        } else if (imagetype == "instagram") {
          _selectedCategoryImage.add(item);
          check = true;
          getTotalImageCount();
          notifyListeners();
          return check;
        } else if (imagetype == "google") {
          _selectedCategoryImage.add(item);
          check = true;
          getTotalImageCount();
          notifyListeners();
          return check;
        } else {
          _selectedCategoryImage.add(item);
          check = true;
          getTotalImageCount();
          notifyListeners();
          return check;
        }
      } else {
        setDialogData(
            Languages.of(context)!.Alert,
            //   "");
            Languages.of(context)!.Youcanselectmorethan100photos +
                max_photo.toString() +
                " " +
                Languages.of(context)!.Photos);
        check = false;
        getTotalImageCount();
        notifyListeners();
        return check;
      }
    }
    getTotalImageCount();
    notifyListeners();
    return check;
  }

  unselectAll() {
    _imageCount = 0;
    for (int i = 0; i < _categoryImage.length; i++) {
      _categoryImage[i]["isSelected"] = false;
    }
    for (int i = 0; i < memotiGalleryPhotoList.length; i++) {
      memotiGalleryPhotoList[i]["isSelected"] = false;
    }
    for (int i = 0; i < instamediaList.length; i++) {
      instamediaList[i]["isSelected"] = false;
    }
    for (int i = 0; i < listGoogleMediaItem.length; i++) {
      listGoogleMediaItem[i]["isSelected"] = false;
    }
    _selectedCategoryImage.clear();
    images = [];
    wechatIMages.clear();
    imagess.clear();
    notifyListeners();
  }

  bool checkImageAddedorNot1(item, int index) {
    // print("selected");
    _selectedCategoryImage.add(item);
    getTotalImageCount();
    if (index == wechatIMages.length - 1) {
      notifyListeners();
    }
    return true;
  }

  void setDialogData(String title, String description) {
    _dialog_title = title;
    _dialog_text = description;
  }

  changeArtist(String value) {
    memotiGalleryPhotoList = [];
    notifyListeners();
    selected_artist_id = value;
    //selected_artist = artistListResponse.data[value].pi;
    int index = artistListResponse.data
        .indexWhere((item) => item.pi == selected_artist_id);
    changeArtistindex = index;
    for (int i = 0; i < memotiGalleryPhotosReponse.data.items.length; i++) {
      for (int j = 0;
          j < memotiGalleryPhotosReponse.data.items[i].photos.photo.length;
          j++) {
        if (value == "all") {
          if (memotiGalleryPhotosReponse.data.items[i].categoryId ==
              memotiGalleryCategoryResponse
                  .data.items[chanageMemotiGalleryCategoryindex].ii) {
            // memotiGalleryPhotoList.add({"checked": false, "image": "https://memotiapp.s3.eu-central-1.amazonaws.com/"+memotiGalleryPhotosReponse.data.items[i].photos.photo[j]});
            memotiGalleryPhotoList.add({
              "id": (10000 + i).toString(),
              "name": "",
              "createdDate": new DateTime.now().toIso8601String(),
              "fileuriPath": new io.File("a.txt").uri.path,
              "lowresofileuriPath": new io.File("a.txt").uri.path,
              // "uint8list": new Uint8List(0),
              "uintid": "",
              "size": new Size(0.0, 0.0),
              "image_type": "memoti",
              "url_image": "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
                  memotiGalleryPhotosReponse.data.items[i].photos.photo[j],
              "count": "1",
              "isCropped": "false",
              "aspectRatio": "",
              "isSelected": false
            });
            print("memotiGalleryPhotoList.length");
            print(memotiGalleryPhotoList.length);
          }
        } else {
          if (memotiGalleryPhotosReponse.data.items[i].vendorId ==
                  artistListResponse.data[index].pi &&
              memotiGalleryPhotosReponse.data.items[i].categoryId ==
                  memotiGalleryCategoryResponse
                      .data.items[chanageMemotiGalleryCategoryindex].ii) {
            // memotiGalleryPhotoList.add({"checked": false, "image": "https://memotiapp.s3.eu-central-1.amazonaws.com/"+memotiGalleryPhotosReponse.data.items[i].photos.photo[j]});
            memotiGalleryPhotoList.add({
              "id": (10000 + i).toString(),
              "name": "",
              "createdDate": new DateTime.now().toIso8601String(),
              "fileuriPath": new io.File("a.txt").uri.path,
              "lowresofileuriPath": new io.File("a.txt").uri.path,
              // "uint8list": new Uint8List(0),
              "base64": "",
              "uintid": "",
              "size": new Size(0.0, 0.0),
              "image_type": "memoti",
              "url_image": "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
                  memotiGalleryPhotosReponse.data.items[i].photos.photo[j],
              "count": "1",
              "isCropped": "false",
              "aspectRatio": "",
              "isSelected": false
            });
          }
        }
      }
    }
    notifyListeners();
  }

  bool memoti_gallery_Data_Got = false;
  void setMiniPhotoImageCheck(BuildContext context) {
    setDialogData(
        // "" ,""
        Languages.of(context)!.Alert,
        Languages.of(context)!.Youwillhavetoselectminimum10photos +
            min_photo.toString() +
            " " +
            Languages.of(context)!.Photos);
    notifyListeners();
  }

  void setMaxPhotoImageCheck(BuildContext context) {
    setDialogData(
        Languages.of(context)!.Alert,
        //   "");
        Languages.of(context)!.Youcanselectmorethan100photos +
            max_photo.toString() +
            " " +
            Languages.of(context)!.Photos);
    notifyListeners();
  }

  void setIMageProcessingDialog(BuildContext context) {
    doneClikTap = true;
    setDialogData(
        Languages.of(context)!.Alert,
        //   "");
        Languages.of(context)!.WeareprocessingthephotosPLeasewait + " ");
    notifyListeners();
  }

  int changeArtistindex = 0;
  int chanageMemotiGalleryCategoryindex = 0;

  chanageMemotiGalleryCategory(int index) {
    chanageMemotiGalleryCategoryindex = index;
    memotiGalleryPhotoList = [];
    notifyListeners();
    for (int i = 0; i < memotiGalleryCategoryResponse.data.items.length; i++) {
      if (i == index) {
        memotiGalleryCategoryResponse.data.items[i].is_selected = true;
      } else {
        memotiGalleryCategoryResponse.data.items[i].is_selected = false;
      }
    }

    for (int i = 0; i < memotiGalleryPhotosReponse.data.items.length; i++) {
      for (int j = 0;
          j < memotiGalleryPhotosReponse.data.items[i].photos.photo.length;
          j++) {
        print(selected_artist_id);
        if (selected_artist_id == 'all') {
          if (memotiGalleryPhotosReponse.data.items[i].categoryId ==
              memotiGalleryCategoryResponse.data.items[index].ii) {
            memotiGalleryPhotoList.add({
              "id": (10000 + i).toString(),
              "name": "",
              "createdDate": new DateTime.now().toIso8601String(),
              "fileuriPath": new io.File("a.txt").uri.path,
              "lowresofileuriPath": new io.File("a.txt").uri.path,
              // "uint8list": new Uint8List(0),
              "base64": "",
              "uintid": "",
              "size": new Size(0.0, 0.0),
              "image_type": "memoti",
              "url_image": "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
                  memotiGalleryPhotosReponse.data.items[i].photos.photo[j],
              "count": "1",
              "isCropped": "false",
              "aspectRatio": "",
              "isSelected": false
            });
            notifyListeners();
            print("memotiGalleryPhotoList");
          }
        } else {
          if (memotiGalleryPhotosReponse.data.items[i].vendorId ==
                  artistListResponse.data[changeArtistindex].pi &&
              memotiGalleryPhotosReponse.data.items[i].categoryId ==
                  memotiGalleryCategoryResponse.data.items[index].ii) {
            // memotiGalleryPhotoList.add({"checked": false, "image": "https://memotiapp.s3.eu-central-1.amazonaws.com/"+memotiGalleryPhotosReponse.data.items[i].photos.photo[j]});
            print("memotiGalleryPhotosReponse.data.items[i].vendorId");
            print(memotiGalleryPhotosReponse.data.items[i].vendorId);
            print("memotiGalleryPhotosReponse.data.items[i].vendorId");
            memotiGalleryPhotoList.add({
              "id": (10000 + i).toString(),
              "name": "",
              "createdDate": new DateTime.now().toIso8601String(),
              "fileuriPath": new io.File("a.txt").uri.path,
              "lowresofileuriPath": new io.File("a.txt").uri.path,
              // "uint8list": new Uint8List(0),
              "base64": "",
              "uintid": "",
              "size": new Size(0.0, 0.0),
              "image_type": "memoti",
              "url_image": "https://memotiapp.s3.eu-central-1.amazonaws.com/" +
                  memotiGalleryPhotosReponse.data.items[i].photos.photo[j],
              "count": "1",
              "isCropped": "false",
              "aspectRatio": "",
              "isSelected": false
            });
            notifyListeners();
            print("memotiGalleryPhotoList");
          }
        }
      }
    }
    notifyListeners();
  }

  List instamediaList = [];
  String instagram_user_id = "";
  String instagram_token = "";

  fetchInstagrammedia() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    instagram_user_id = preferences.getString(UiData.instagram_user_id);
    instagram_token = preferences.getString(UiData.instagram_token);
    print("instagram_user_id");
    print(instagram_user_id);
    print(instagram_token);
    if (instagram_user_id == "" || instagram_user_id == null) {
      //notifyListeners();
    } else {
      getAllInstaMedias(instagram_user_id, instagram_token).then((mediaList) {
        instamediaList = mediaList;
        notifyListeners();
      });
    }
  }

  Future<List> getAllInstaMedias(String user_id, String token) async {
    /// Parse according fieldsList.
    /// Request instagram user medias list.
    /// Request for each media id the details.
    /// Set all medias as list Object.
    /// Returning the List<InstaMedia>.
    ///

    Instagram insta = Instagram();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    /*String user_id = prefs.getString(UiData.instagram_user_id);
    String token = prefs.getString(UiData.instagram_token);*/
    final String fields = insta.mediasListFields.join(',');
    final http.Response responseMedia = await http.get(Uri.parse(
        'https://graph.instagram.com/${user_id}/media?fields=${fields}&access_token=${token}'));
    List medias = [];
    Map<String, dynamic> mediasList = json.decode(responseMedia.body);

    // print("googleNextPageToken - "+googleNextPageToken);
    List<InstaMedia> list =
        (mediasList["data"] as List).map((e) => InstaMedia(e)).toList();
    print(list.length);
    for (int i = 0; i < list.length; i++) {
      if (list[i].type == "IMAGE") {
        medias.add({
          "id": list[i].id,
          "name": list[i].username,
          "createdDate": list[i].timestamp,
          "fileuriPath": new io.File("a.txt").uri.path,
          "lowresofileuriPath": new io.File("a.txt").uri.path,
          // "uint8list": new Uint8List(0),
          "uintid": "",
          "base64": "",
          "size": new Size(0, 0),
          "image_type": "instagram",
          "url_image": list[i]
              .url /*+"=w"+list[i].mediaMetadata.width+"-h"+list[i].mediaMetadata.height+"-c"*/,
          "count": "1",
          "isCropped": "false",
          "aspectRatio": "",
          "isSelected": false
        });
      }
      print("media item");
      print(list[i].url);
      print(list[i].id);
    }
    /*
    print("medialist");
    print(mediasList);
    await mediasList['data'].forEach((media) async {
      print("media");
      print(media);
      // check inside db if exists (optional)
      */ /* Map<String, dynamic> m = await getMediaDetails(media['id']);
      InstaMedia instaMedia = InstaMedia(m);*/ /*
      medias.add(mediasList);
    });*/
    // need delay before returning the List<InstaMedia>
    await Future.delayed(Duration(seconds: 1), () {});
    return medias;
  }

  Future<Map<String, dynamic>> getMediaDetails(String mediaID) async {
    /// Parse according fieldsList.
    /// Request complete media informations.
    /// Returning the response as Map<String, dynamic>
    Instagram insta = Instagram();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_id = prefs.getString(UiData.instagram_user_id);
    String token = prefs.getString(UiData.instagram_token);
    final String fields = insta.mediaFields.join(',');
    final http.Response responseMediaSingle = await http.get(Uri.parse(
        'https://graph.instagram.com/${mediaID}?fields=${fields}&access_token=${token}'));
    print("mediadetail");
    print(responseMediaSingle.body);
    return json.decode(responseMediaSingle.body);
  }

  late GoogleSignInAccount user;
  bool isGoogleLoggedIn = false;
  bool isGooglemediaitemGet = false;
  bool isgoogleempty = true;
  bool isgoogleLoading = false;
  List listGoogleMediaItem = [];
  String googleNextPageToken = "";
  final googlePhotocontroller = ScrollController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
    'profile',
    'https://www.googleapis.com/auth/photoslibrary',
    'https://www.googleapis.com/auth/photoslibrary.readonly'
  ]);
  Future googleSignIn() async {
    try {
      user = (await _googleSignIn.signIn())!;
      print(user);
      if (user != null) {
        print("user - " + user.toString());
        print('User signed in.');
        isGoogleLoggedIn = true;
        user.authHeaders.then((value) {
          print("authHeaders +" + value.toString());
          googlePhotocontroller.addListener(() {
            handleGoogleScroll();
          });
          saveauthtosharedpref(value).then((value) => listmediaItem(""));
          //listAlbums(value);
        });
        // User could not be signed in
      }
    } catch (error) {
      print(error);
    }
  }

  Future saveauthtosharedpref(Map<String, String> authHeaders) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString(UiData.google_auth_token, json.encode(authHeaders));
  }

  void handleGoogleScroll() {
    print(googlePhotocontroller.position.extentAfter);
    if (googlePhotocontroller.position.extentAfter < 500) {
      listmediaItem('&pageToken=' + googleNextPageToken);
    }
  }

  Future listAlbums(Map<String, String> authHeaders) async {
    var url = Uri.parse('https://photoslibrary.googleapis.com/v1/albums');

    return http.get(url, headers: authHeaders).then(
      (response) {
        if (response.statusCode != 200) {
          // print(response.reasonPhrase);
          // print(response.body);
        }
        print("response - " + response.body.toString());
        // return ListAlbumsResponse.fromJson(jsonDecode(response.body));
      },
    );
  }

  // Future getnextgoogleIMages() {}

  Future listmediaItem(String nextpageToken) async {
    print("isgoogleLoading");
    print(isgoogleLoading);
    if (!isgoogleLoading) {
      isgoogleLoading = true;
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      Map<String, dynamic> authHeaders =
          json.decode(prefs.getString(UiData.google_auth_token));
      Map<String, String> map = {
        "Authorization": authHeaders["Authorization"],
        "X-Goog-AuthUser": authHeaders["X-Goog-AuthUser"]
      };

      print(authHeaders);
      var url = Uri.parse(
          'https://photoslibrary.googleapis.com/v1/mediaItems?pageSize=100');
      if (nextpageToken.isNotEmpty) {
        url = Uri.parse(
            'https://photoslibrary.googleapis.com/v1/mediaItems?pageSize=100&pageToken=' +
                nextpageToken);
      }
      print(url);
      http.get(url, headers: map).then(
        (response) {
          if (response.statusCode != 200) {
            isGoogleLoggedIn = false;
            // print(response.reasonPhrase);
            // print(response.body);
          }

          print("response mediaitem- " + response.body.toString());
          if (!response.body.contains("mediaItems")) {
            print("11");
            if (isgoogleempty) {
              isgoogleempty = true;
            }
          } else {
            isgoogleempty = false;
            Map<String, dynamic> responseData = jsonDecode(response.body);
            googleNextPageToken = responseData["nextPageToken"];
            print("googleNextPageToken - " + googleNextPageToken);
            List list = (responseData["mediaItems"] as List)
                .map((e) => GoogleMediaItem.fromJson(e))
                .toList();

            for (int i = 0; i < list.length; i++) {
              if (list[i].mimeType.split("/")[0] == "image") {
                listGoogleMediaItem.add({
                  "id": list[i].id,
                  "name": list[i].filename,
                  "createdDate": new DateTime.now().toIso8601String(),
                  "fileuriPath": new io.File("a.txt").uri.path,
                  "lowresofileuriPath": new io.File("a.txt").uri.path,
                  // "uint8list": new Uint8List(0),
                  "uintid": "",
                  "base64": "",
                  "size": new Size(double.parse(list[i].mediaMetadata.width),
                      double.parse(list[i].mediaMetadata.height)),
                  "image_type": "google",
                  "url_image": list[i]
                      .baseUrl /*+"=w"+list[i].mediaMetadata.width+"-h"+list[i].mediaMetadata.height+"-c"*/,
                  "count": "1",
                  "isCropped": "false",
                  "aspectRatio": "",
                  "isSelected": false
                });
              }
            }
            if (googleNextPageToken != "") {
              print("googleNextPageToken");
              isgoogleLoading = false;
              isGooglemediaitemGet = true;
              listmediaItem(googleNextPageToken);
              notifyListeners();
            } else {
              isGooglemediaitemGet = true;
              print("isgoogleLoading");
              isgoogleLoading = false;
              notifyListeners();
            }
          } // notifyListeners();
        },
      );
    }
  }

//////////////////////////
  ///Photobook Customization
//////////////////////////

  bool addingCreation = false;
  int starting_page_count = 0;
  String selected_layout_id = "";
  List mainImageList = [];
  // late String categoryType;
  double selected_width = 0;
  double selected_height = 0;
  TextEditingController textEditingController = TextEditingController();
  String _which_bottom = "";
  String get which_bottom => _which_bottom;
  List _getItems = [];
  List get getItems => _getItems;
  List _getLayout = [];
  List get getLayout => _getLayout;
  int _isExpanded = 0;
  int get isExpanded => _isExpanded;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  int _angle = 0;
  int get angle => _angle;

  //test formating
  int _istextFormatting = 0;
  int get istextFormatting => _istextFormatting;
  List<CustomFontItem> _customFontList = [];
  List<ImageTextEditPostion> imageTextPostionList = [];
  List<CustomFontItem> _customTextList = [];
  List<CustomFontItem> get customFontList => _customFontList;
  List<DropdownMenuItem<int>> _fontList = [];
  List<DropdownMenuItem<int>> editTextPostionList = [];
  List<DropdownMenuItem<int>> fontsizeList = [];
  double _lowerValue = 1.0;
  double _upperValue = 1000.0;
  double get lowerValue => _lowerValue;
  double get upperValue => _upperValue;
  changedragwidth(double value) {
    print(value);
    dragboxwidth = value;
    notifyListeners();
  }

  List _textpositionList = [
    "Top Left",
    "Top Center",
    "Top Right",
    "Center Left",
    "Center",
    "Center Right",
    "Bottom Left",
    "Bottom Center",
    "Bottom Right"
  ];
  List<DropdownMenuItem<int>> get fontList => _fontList;
  List get textpositionList => _textpositionList;
  int _selectedFontindex = 0;
  int selectedFontSizeindex = 14;
  int selectededitTextPosition = 0;
  String _selectedTextindex = "Center";
  int get selectedFontindex => _selectedFontindex;
  String get selectedTextindex => _selectedTextindex;
  String _selectedFontKey = "Poppins";
  String selectedfontpath = "";
  String _selectedTextKey = "Top Left";
  String get selectFontKey => _selectedFontKey;
  List<CustomColor> _colorList = [];
  List<CustomColor> _bgcolorList = [];
  List<CustomColor> get colortList => _colorList;
  List<CustomColor> get bgcolortList => _bgcolorList;
  int _selectedcolorindex = 0;
  int get selectedcolorindex => _selectedcolorindex;
  int _selectedtextFormatTabindex = 0;
  int get selectedtextFormatTabindex => _selectedtextFormatTabindex;
  var currenttextColor = Colors.black;
  var currentBGColor = Colors.white;
  //IMageFIlter
  int _selectedimageFilterTabindex = 0;
  int get selectedimageFilterTabindex => _selectedimageFilterTabindex;

  List<GlobalKey<FormState>> _formKeys = [GlobalKey<FormState>()];
  List<GlobalKey<FormState>> get formKeys => _formKeys;
  /* Uint8List _selcted_image = null;
  Uint8List _selcted_image_copy = null;*/
  String _selcted_image_type = "";
  String selectedaspectRatio = "";
  bool isLayoutCircle = false;
  bool creatingpdf = false;
  String _selcted_image_url = "";
  String imageQulaityColor = "00ffffff";
  String _selcted_layout_id = "";
  String get selcted_layout_id => _selcted_layout_id;
  int _selcted_pagePosition = 0;
  int get selcted_pagePosition => _selcted_pagePosition;
  int _selcted_imagePostion = 0;
  int get selcted_imagePostion => _selcted_imagePostion;
  int _selcted_imageListLenght = 0;
  int get selcted_imageListLenght => _selcted_imageListLenght;
  int _selcted_imagepos = 0;
  int get selcted_imagepos => _selcted_imagepos;
  String _seletedImageuri = "";
  String get seletedImageuri => _seletedImageuri;
  String _seletedImagebase64uri = "";
  String get seletedImagebase64uri => _seletedImagebase64uri;
  /* io.File _seletedImageFile ;
  io.File get seletedImageFile => _seletedImageFile;*/
  String get selcted_image_type => _selcted_image_type;
  String get selcted_image_url => _selcted_image_url;
  //Uint8List get selcted_image => _selcted_image;
  List<double> _selected_filter = NOFILTER;
  List<double> get selected_filter => _selected_filter;
  List<ImageFilterModel> _filterList = [];
  List<ImageFilterModel> get filterList => _filterList;
  List<ImageFilterModelUrl> _filterListUrl = [];
  List<ImageFilterModelUrl> get filterListUrl => _filterListUrl;
  List<List<double>> _filters = [
    NOFILTER,
    SEPIA_MATRIX,
    GREYSCALE_MATRIX,
    VINTAGE_MATRIX,
    SWEET_MATRIX,
    MILK,
    SEPIUM,
    COLDLIFE,
    OLDTIME,
    BLACKANDWHITE,
    CYAN,
    YELLOW,
    PURPLE
  ];
  List<List<double>> get filters => _filters;
  GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

  final List<AspectRatioItem> aspectRatios = <AspectRatioItem>[
    AspectRatioItem(text: '1*1', value: CropAspectRatiossss.ratio1_1),
    AspectRatioItem(text: 'original', value: CropAspectRatiossss.original),
    // AspectRatioItem(text: 'custom', value: CropAspectRatiossss.custom),
    AspectRatioItem(text: '4*3', value: CropAspectRatiossss.ratio4_3),
    AspectRatioItem(text: '3*4', value: CropAspectRatiossss.ratio3_4),
    AspectRatioItem(text: '16*9', value: CropAspectRatiossss.ratio16_9),
    AspectRatioItem(text: '9*16', value: CropAspectRatiossss.ratio9_16)
  ];
  late AspectRatioItem aspectRatio;

  Future<io.File> writeToFile(Uint8List data, String name) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    final myImagePath = tempDir.path;
    final myImgDir = await new Directory(myImagePath).create();
    String tempPath = tempDir.path;
    var filePath = /*"$myImagePath/image_$baru$rand.jpg"*/
        myImagePath + '/' + name; // file_01.tmp is dump file, can be anything
    return new io.File(filePath).writeAsBytes(data);
  }

  String? selectedlowIMageuri;
  String whichImageShow = "original";
  Future<void> updateImage(Uint8List byteImage) async {
    var lowresoFile = await writeToFile(
        byteImage,
        "image_" + /*DateTime.now().toString().substring(0,20)*/ DateTime.now()
                .microsecond
                .toString() +
            ".jpg");
    print("_selcted_pagePosition ");
    print(_selcted_pagePosition);
    print("_selcted_imagePostion ");
    print(_selcted_imagePostion);
    _getItems[_selcted_pagePosition]["imageModel"]
        .fileuriPathlowreso[_selcted_imagePostion] = lowresoFile.uri.path;
    _getItems[_selcted_pagePosition]["imageModel"]
            .base64[_selcted_imagePostion] =
        await converttobase64bytes(base64Decode(lowresoFile.uri.path));
    _getItems[_selcted_pagePosition]["imageModel"]
        .iscroppeds[_selcted_imagePostion] = "true";
    _getItems[_selcted_pagePosition]["imageModel"]
        .aspectRatio[_selcted_imagePostion] = selectedaspectRatio;
    int imagePosition = 0;

    print("mainImageList Array");
    print(_selcted_image_type);
    if (whichImageShow == "original") {
      if (_selcted_image_type == "phone") {
        print("_seletedImageuri - " + _seletedImageuri.toString());
        for (int i = 0; i < mainImageList.length; i++) {
          if (_seletedImageuri == mainImageList[i]["fileuriPath"]) {
            print("mainImageList[i]._seletedImageuri - " +
                mainImageList[i]["fileuriPath"].toString());
            imagePosition = i;
            mainImageList[i]["isCropped"] = "true";
            mainImageList[i]["aspectRatio"] = selectedaspectRatio;
            mainImageList[i]["base64"] =
                await converttobase64bytes(base64Decode(lowresoFile.uri.path));
            mainImageList[i]["lowresofileuriPath"] = lowresoFile.uri.path;
            break;
          }
        }
      } else {
        print("_selcted_image_url - " + _selcted_image_url.toString());
        for (int i = 0; i < mainImageList.length; i++) {
          print(mainImageList[i]);
          if (_selcted_image_url == mainImageList[i].url_image) {
            mainImageList[i]["isCropped"] = "true";
            mainImageList[i]["aspectRatio"] = selectedaspectRatio;
            mainImageList[i]["base64"] =
                await converttobase64bytes(base64Decode(lowresoFile.uri.path));
            mainImageList[i]["lowresofileuriPath"] = lowresoFile.uri.path;
            break;
          }
        }
      }
      _seletedImageuri = lowresoFile.uri.path;
      _seletedImagebase64uri =
          await converttobase64bytes(base64Decode(lowresoFile.uri.path));
      _selcted_image_url = "";
      _selcted_image_type = "phone";
    } else {
      print("selectedlowIMageuri - " + selectedlowIMageuri.toString());
      for (int i = 0; i < mainImageList.length; i++) {
        if (selectedlowIMageuri == mainImageList[i]["lowresofileuriPath"]) {
          print("mainImageList[i].lowresofileuriPath - " +
              mainImageList[i]["lowresofileuriPath"].toString());
          imagePosition = i;
          mainImageList[i]["isCropped"] = "true";
          mainImageList[i]["aspectRatio"] = selectedaspectRatio;
          mainImageList[i]["base64"] =
              await converttobase64bytes(base64Decode(lowresoFile.uri.path));
          mainImageList[i]["lowresofileuriPath"] = lowresoFile.uri.path;
          break;
        }
      }
      selectedlowIMageuri = lowresoFile.uri.path;
      _seletedImagebase64uri =
          await converttobase64bytes(base64Decode(lowresoFile.uri.path));
      _selcted_image_url = "";
      _selcted_image_type = "phone";
    }
    notifyListeners();
  }

  Uint8List? originaltextEditIMage = null;
  bool isoriginaltextEditIMage = false;
  closedtextformatting() async {
    print("run1");
    _istextFormatting = 2;
    if (textEditingController.text == "") {
      print("run2");
      originaltextEditIMage = null;
      isoriginaltextEditIMage = false;
      currenttextColor = Colors.black;
      currentBGColor = Colors.white;
      _selectedtextFormatTabindex = 0;
      _selectedcolorindex = 0;
      selectedFontSizeindex = 10;
      selectededitTextPosition = 0;

      _selectedFontKey = _customFontList[0].fontName;
      selectedfontpath = _customFontList[0].fontspath;
      _selectedFontindex = 0;
      textEditingController = TextEditingController();
      notifyListeners();
    } else {
      int width, height;
      var image;
      selectedfontpath = _customFontList[_selectedFontindex].fontspath;
      io.File fontFile =
          await getFileFromAssets(selectedfontpath.split("-app/")[1]);
      print("hhhhhhhhhhhhhhh");
      //final String fontName = await getFont(GoogleFonts.poppins());
      final String fontName = await FontManager.registerFont(fontFile);
      if (whichImageShow == "original") {
        image = originaltextEditIMage;
        var decodedImage = await decodeImageFromList(originaltextEditIMage!);
        print(decodedImage.width);
        print(decodedImage.height);
        width = decodedImage.width;
        height = decodedImage.height;
      } else {
        image = new io.File(selectedlowIMageuri!);
        var decodedImage = await decodeImageFromList(image.readAsBytesSync());
        print(decodedImage.width);
        print(decodedImage.height);
        width = decodedImage.width;
        height = decodedImage.height;
      }

      final textOption = AddTextOption();
      textOption.addText(
        EditorText(
          offset: Offset(
              width * imageTextPostionList[selectededitTextPosition].dxOffset,
              height.toDouble() *
                  imageTextPostionList[selectededitTextPosition].dyOffset),
          text: textEditingController.text,
          fontSizePx: selectedFontSizeindex,
          textColor: currenttextColor,
          fontName: fontName,
          //     .fontName,
        ),
      );
      print("run4");
      ImageEditorOption option = ImageEditorOption();
      option = ImageEditorOption();
      option.addOption(textOption);
      //textEditingController.clear();

      if (whichImageShow != "original") {
        final result = await ImageEditor.editFileImage(
          file: image,
          imageEditorOption: option,
        );
        //await updatetextimage(rimageesult);
        if (categoryType == "canvas") {
          updateCanvasImage(result!);
        } else {
          updateImage(result!);
        }
      } else {
        final result = await ImageEditor.editImage(
            image: image, imageEditorOption: option);
        //await updatetextimage(result);

        if (categoryType == "canvas") {
          updateCanvasImage(result!);
        } else {
          updateImage(result!);
        }
      }
      originaltextEditIMage = null;
      isoriginaltextEditIMage = false;
      print("run5");
      currenttextColor = Colors.black;
      currentBGColor = Colors.white;
      _selectedtextFormatTabindex = 0;
      _selectedcolorindex = 0;
      selectedFontSizeindex = 10;
      selectededitTextPosition = 0;

      _selectedFontKey = _customFontList[0].fontName;
      selectedfontpath = _customFontList[0].fontspath;
      _selectedFontindex = 0;
      textEditingController = TextEditingController();
    }
  }

  String ratio = "";
  closedImageFilter() {
    _istextFormatting = 0;
    _selectedimageFilterTabindex = 0;
    selectedaspectRatio = ratio;
    ratio = "";
    _selected_filter = NOFILTER;
    for (int i = 0; i < _filterList.length; i++) {
      _filterList[i].isSelected = false;
    }
    notifyListeners();
  }

  Future<io.File> getFileFromAssets(String path) async {
    print(path);
    final byteData = await rootBundle.load(path);
    print("33333");
    print(byteData.lengthInBytes);
    print(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    final tmp = await getTemporaryDirectory();
    io.File file = await new io.File(
            '${tmp.absolute.path}/${DateTime.now().millisecondsSinceEpoch}.ttf')
        .writeAsBytes(byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    print("33333");
    return file;
  }

  removeItem(int pagePostion) {
    if (_getItems[pagePostion]["imageModel"].fileuriPath != null &&
        _getItems[pagePostion]["imageModel"].fileuriPath.isNotEmpty) {
      for (int i = 0;
          i < _getItems[pagePostion]["imageModel"].fileuriPath.length;
          i++) {
        for (int j = 0; j < mainImageList.length; j++) {
          if (_getItems[pagePostion]["imageModel"].fileuriPath[i] ==
              mainImageList[j]["fileuriPath"]) {
            if (mainImageList[j]["count"].split(",").length > 2) {
              List<String> counuts = mainImageList[j]["count"].split(",");
              print("counuts.length - " + counuts.length.toString());
              for (int k = 0; k < counuts.length; k++) {
                print(k);
                if (pagePostion == int.parse(counuts[k])) {
                  counuts.removeAt(k);
                  counuts.removeAt(k);
                  break;
                }
                k = k + 1;
              }
              mainImageList[j]["count"] = counuts.join(",");
            } else {
              print("mainImageList image io.File - " +
                  mainImageList[j]["fileuriPath"].toString());
              mainImageList.removeAt(j);
            }
          }
        }
      }
    }
    _getItems.removeAt(pagePostion);
    starting_page_count = _getItems.length;
    print("_getItems.length - " + starting_page_count.toString());
    notifyListeners();
  }

  void setValue() {
    currenttextColor = Colors.black;
    currentBGColor = Colors.white;
    _selectedFontindex = 0;
    _selectedcolorindex = 0;
    _selectedtextFormatTabindex = 0;
  }

  selectItem(int index) {
    _selectedIndex = index;
    setValue();
    for (int i = 0; i < _getItems.length; i++) {
      if (i == index) {
        _getItems[i]["isSelected"] = true;
      } else {
        _getItems[i]["isSelected"] = false;
      }
    }
    notifyListeners();
  }

  setExpand(String which, String expand) {
    if (expand == "expandclosed") {
      _isExpanded = int.parse(which);
    } else if (expand == "expandOpen") {
      _isExpanded = int.parse(which);
    } else {
      _isExpanded = int.parse(which);
    }

    print("which  " + _isExpanded.toString());
    changeBottom(which);
    notifyListeners();
  }

  String getImageDpiColornew(Size size) {
    String color;
    double dpiHeight = 0.0;
    double dpiWidth = 0.0;
    double lessDPi = 0.0;
    double requredheight = selected_height; //cm
    double requredwidth = selected_width; //cm
    if (categoryType == "canvas") {
      requredheight = requredheight / 8;
      requredwidth = requredwidth / 8;
    }
    print(categoryType);
    print(requredheight);
    print(requredwidth);
    dpiHeight = size.height * (2.54 / requredheight);
    dpiWidth = size.width * (2.54 / requredwidth);
    print("size -  " +
        size.toString() +
        " - dpiWidth -  " +
        dpiWidth.toString() +
        " - dpiHeight -  " +
        dpiHeight.toString());
    if (dpiHeight <= dpiWidth) {
      lessDPi = dpiHeight;
    } else {
      lessDPi = dpiWidth;
    }
    if (lessDPi >= 150) {
      color = "00ffffff";
    } else if (lessDPi < 150 && lessDPi >= 80) {
      color = "ffff00";
    } else {
      color = "f00e0e";
    }
    notifyListeners();
    return color;
  }

  String getImageDpiColor(Size size) {
    String color;
    double dpiHeight = 0.0;
    double dpiWidth = 0.0;
    double lessDPi = 0.0;
    double requredheight = selected_height; //cm
    double requredwidth = selected_width; //cm
    if (categoryType == "canvas") {
      requredheight = requredheight / 8;
      requredwidth = requredwidth / 8;
    }
    print(categoryType);
    print(requredheight);
    print(requredwidth);
    dpiHeight = size.height * (2.54 / requredheight);
    dpiWidth = size.width * (2.54 / requredwidth);
    print("size -  " +
        size.toString() +
        " - dpiWidth -  " +
        dpiWidth.toString() +
        " - dpiHeight -  " +
        dpiHeight.toString());
    if (dpiHeight <= dpiWidth) {
      lessDPi = dpiHeight;
    } else {
      lessDPi = dpiWidth;
    }
    if (lessDPi >= 150) {
      color = "00ffffff";
    } else if (lessDPi < 150 && lessDPi >= 80) {
      color = "ffff00";
    } else {
      color = "f00e0e";
    }
    //notifyListeners();
    return color;
  }

  void addFilterData(base64) {
    print("adding filter list data");
    String uri = "";
    if (whichImageShow == "original") {
      print("original");
      uri = _seletedImageuri;
    } else {
      print("crop");
      uri = selectedlowIMageuri!;
    }
    print(uri);
    _filterList.clear();
    _filterList
        .add(new ImageFilterModel(uri, "NO FILTER", NOFILTER, false, base64));
    _filterList
        .add(new ImageFilterModel(uri, "SEPIA", SEPIA_MATRIX, false, base64));
    _filterList.add(new ImageFilterModel(
        _seletedImageuri, "GREYSCALE", GREYSCALE_MATRIX, false, base64));
    _filterList.add(
        new ImageFilterModel(uri, "VINTAGE", VINTAGE_MATRIX, false, base64));
    _filterList
        .add(new ImageFilterModel(uri, "SWEET", SWEET_MATRIX, false, base64));
    _filterList.add(new ImageFilterModel(uri, "MILK", MILK, false, base64));
    _filterList.add(new ImageFilterModel(uri, "SEPIUM", SEPIUM, false, base64));
    _filterList
        .add(new ImageFilterModel(uri, "COLD LIFE", COLDLIFE, false, base64));
    _filterList
        .add(new ImageFilterModel(uri, "OLD TIME", OLDTIME, false, base64));
    _filterList.add(new ImageFilterModel(
        uri, "BLACK & WHITE", BLACKANDWHITE, false, base64));
    _filterList.add(new ImageFilterModel(uri, "CYAN", CYAN, false, base64));
    _filterList.add(new ImageFilterModel(uri, "YELLOW", YELLOW, false, base64));
    _filterList.add(new ImageFilterModel(uri, "PURPLE", PURPLE, false, base64));
    print("added filter list data");
    notifyListeners();
  }

  addCreation(
      BuildContext contextmain,
      String categorytype,
      BuildContext context,
      NavigationProvider provider,
      int maxPhoto,
      int minPhoto,
      String productId,
      String productPrice,
      String selectedSizes,
      String productName,
      String slovaktitle,
      int creationId) async {
    print(provider.getItems);
    addingCreation = true;
    notifyListeners();
    List<String> missingImageCout = [];
    int imageLength = 0;
    for (int i = 0; i < provider.getItems.length; i++) {
      for (int j = 0;
          j < provider.getItems[i]["imageModel"].imageType.length;
          j++) {
        imageLength = imageLength + 1;
        if (provider.getItems[i]["imageModel"].imageType[j] == "") {
          missingImageCout.add((i + 1).toString());
          break;
        }
      }
    }
    // print(creationId);
    if (creationId == -1) {
      List list = [];
      // print("mainImageList.length - "+mainImageList.length.toString());
      for (int i = 0; i < mainImageList.length; i++) {
        // print("mainImageList[i].image_type");
        // print(mainImageList[i]);
        // print("type - "+mainImageList[i]["image_type"]);
        // print("url - "+mainImageList[i]["url_image"]);
        // print("file uri - "+mainImageList[i]["fileuriPath"]);
        // print("file uri - "+mainImageList[i]["fileuriPath"]);
        // print("createdDate - "+mainImageList[i]["createdDate"].toString());
        // print("befor i - "+i.toString());
        mainImageList[i]["size"] = mainImageList[i]["size"].toString();
        if (mainImageList[i]["image_type"] == "phone") {
          // Temp
          await MemotiDbProvider.db
              .savePicture(mainImageList[i]["base64"])
              .then((value) {
            // mainImageList[i]["uintid"] = value.toString();
            print(value);
            mainImageList[i]["uintid"] = value.toString();
            //mainImageList[i].uint8list = Uint8List(0);
            list.add(mainImageList[i]);
            print("after i - " + i.toString());
          });
        }
      }
      print("afert after");
      print("afert after - " + list.length.toString());
      for (int i = 0; i < _getItems.length; i++) {
        for (int j = 0;
            j < _getItems[i]["imageModel"].uint8listid.length;
            j++) {
          for (int k = 0; k < list.length; k++) {
            // print(_getItems[i]["imageModel"].fileuriPath[j]);
            if (_getItems[i]["imageModel"].fileuriPath[j] ==
                list[k]["fileuriPath"]) {
              _getItems[i]["imageModel"].uint8listid[j] = list[k]["uintid"];
              // _getItems[i]["imageModel"].uint8list[j] = Uint8List(0);
            }
          }
        }
      }
      getItemResponseinString().then((items) {
        // print("jsonStingitems - "+items);
        getmainImageListResponseinString().then((mainimages) {
          // print("jsonStringsimageList - "+mainimages);
          addingCreation = false;
          notifyListeners();
          // print("selectedSize");
          // print(selectedSize);
          // Temp
          MemotiDbProvider.db
              .insertCreation(
                  "photobook",
                  mainimages,
                  items,
                  max_photo.toString(),
                  min_photo.toString(),
                  product_id,
                  product_price,
                  selectedSize,
                  product_name,
                  slovaktitle)
              .then((value) {
            /*     print("mainImageList");
            print(mainImageList);
            SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);*/
            //Navigator.push( context, MaterialPageRoute(builder: (context) => TabsPage(/*contextmain,provider.getItems,mainImageList,productId,categoryType,int.parse(maxpage),int.parse(minPage), productPrice, selectedSize, productName,slovaktitle,value*/)));
            if (wechatIMages != null) {
              wechatIMages.clear();
              listGoogleMediaItem = [];
              memotiGalleryPhotoList = [];
              imagess.clear();
              unselectAll();
            }
            Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => TabsPage(),
              ),
              (route) =>
                  false, //if you want to disable back feature set to false
            );
          });
        });
      });
    } else {
      print(creationId);
      for (int i = 0; i < mainImageList.length; i++) {
        print("creationId - " + mainImageList[i]["uintid"].toString());
        if (mainImageList[i]["image_type"] == "phone") {
          if (mainImageList[i]["uintid"].isNotEmpty &&
              mainImageList[i]["uintid"] != null) {
            // Temp
            // MemotiDbProvider.db.removepicture(int.parse(mainImageList[i]["uintid"]));
          }
        }
      }
      // Temp
      MemotiDbProvider.db.removecreationItem(creationId).then((value) async {
        List list = [];
        for (int i = 0; i < mainImageList.length; i++) {
          print("befor i - " + i.toString());
          if (mainImageList[i]["image_type"] == "phone") {
            await MemotiDbProvider.db
                .savePicture(mainImageList[i]["base64"])
                .then((value) {
              mainImageList[i]["uintid"] = value.toString();
              //mainImageList[i].uint8list = Uint8List(0);
              list.add(mainImageList[i]);
              print("after i - " + i.toString());
            });
          }
        }
        print("afert after");
        for (int i = 0; i < _getItems.length; i++) {
          for (int j = 0;
              j < _getItems[i]["imageModel"].uint8listid.length;
              j++) {
            for (int k = 0; k < list.length; k++) {
              if (_getItems[i]["imageModel"].fileuriPath[j] ==
                  list[k]["fileuriPath"]) {
                _getItems[i]["imageModel"].uint8listid[j] = list[k]["uintid"];
                // _getItems[i]["imageModel"].uint8list[j] = Uint8List(0);
              }
            }
          }
        }
        getItemResponseinString().then((items) {
          print("jsonStingitems - " + items);
          getmainImageListResponseinString().then((mainimages) {
            // print("jsonStringsimageList - "+mainimages);
            addingCreation = false;
            notifyListeners();
            MemotiDbProvider.db
                .insertCreation(
                    "photobook",
                    mainimages,
                    items,
                    maxpage.toString(),
                    minPage.toString(),
                    productId,
                    productPrice,
                    selectedSize,
                    productName,
                    slovaktitle)
                .then((value) {
              // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
              //Navigator.push( context, MaterialPageRoute(builder: (context) => PhotoBookPerviewPage(contextmain,provider.getItems,mainImageList,productId,categoryType,int.parse(maxpage),int.parse(minPage), productPrice, selectedSize, productName,slovaktitle,value)));
              //Navigator.push( context, MaterialPageRoute(builder: (context) => TabsPage(/*contextmain,provider.getItems,mainImageList,productId,categoryType,int.parse(maxpage),int.parse(minPage), productPrice, selectedSize, productName,slovaktitle,value*/)));
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => TabsPage(),
                ),
                (route) =>
                    false, //if you want to disable back feature set to false
              );
            });
          });
        });
      });
    }
    /*  if(missingImageCout.length>0){
      String msg;
      if(missingImageCout.length==1){
        msg = Languages.of(contextmain)!.Youmustaddimageatthispostion +" "+missingImageCout.join(",");
      }else{
        msg = Languages.of(contextmain)!.Youmustaddimagesonthesepostions +" "+missingImageCout.join(",");
      }
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(Languages.of(contextmain)!.Alert),
              content: setupAlertDialoadContainer2(contextmain,context,msg),
            );
          });
    }else{
      if(imageLength>max_photo){
        String msg;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(Languages.of(contextmain)!.Alert),
                content: setupAlertDialoadContainer2(contextmain,context,Languages.of(contextmain)!.Youcanselectmorethan100photos+ maxpage.toString() + " "+ Languages.of(contextmain)!.Photos),
              );
            });
      }else{
        if(imageLength<min_photo){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(Languages.of(contextmain)!.Alert),
                  content: setupAlertDialoadContainer2(contextmain,context,Languages.of(contextmain)!.Youwillhavetoselectminimum10photos+ minPage.toString() + " "+ Languages.of(contextmain)!.Photos),

                );
              });
        }else{

        }
      }

    }*/
  }

  changeTextFormatSelectedTabColor(int postion) {
    _selectedtextFormatTabindex = postion;
    notifyListeners();
  }

  changeFontSize(int value) {
    print("selectedFontSizevalue - " + value.toString());
    selectedFontSizeindex = value;
    print("selectedFontSizeindex - " + selectedFontSizeindex.toString());
    notifyListeners();
  }

  changeEditTextPostion(int value) {
    selectededitTextPosition = value;
    print("selectededitTextPosition dx &dy - " +
        imageTextPostionList[value].dxOffset.toString() +
        " & " +
        imageTextPostionList[value].dyOffset.toString());
    notifyListeners();
  }

  changeFont(int value) {
    _selectedFontindex = value;
    _selectedFontKey = _customFontList[value].fontName;
    selectedfontpath = _customFontList[value].fontspath;
    notifyListeners();
  }

  void changeaspectratio(AspectRatioItem item) {
    aspectRatio = item;
    ratio = item.text;
    _getItems[_selcted_pagePosition]["imageModel"]
        .aspectRatio[_selcted_imagePostion] = ratio;
    notifyListeners();
  }

  showWarningofImageQuality(BuildContext contextmain, BuildContext context) {
    String? msg;
    switch (imageQulaityColor) {
      case "00ffffff":
        {
          msg = Languages.of(contextmain)!.ImageQualityislow;
          break;
        }
      case "ffff00":
        {
          msg = Languages.of(contextmain)!.ImageQualityislow;
          break;
        }
      case "f00e0e":
        {
          msg = Languages.of(contextmain)!.ImageQualityislow;
          break;
        }
    }
    print(msg);
    notifyListeners();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(Languages.of(contextmain)!.Alert),
            content: setupAlertDialoadContainer2(contextmain, context, msg!),
          );
        });
    notifyListeners();
  }

  setImageSelection(String whichimage) {
    whichImageShow = whichimage;
    _filterList = [];
    _filterListUrl = [];
    _istextFormatting = 2;
    if (whichImageShow == "original") {
      if (_selcted_image_type != null) {
        if (_selcted_image_type == "memoti" ||
            _selcted_image_type == "google") {
          addFilterDataUrl();
        } else {
          addFilterData(base64);
        }
      }
    } else {
      _selcted_image_type = "phone";
      addFilterData(base64);
    }
  }

  opentextformatting() {
    textEditingController.text == "";
    _istextFormatting = 1;
    notifyListeners();
  }

  changeImageFilterSelectedTabColor(int postion) {
    if (postion == 3) {
      opentextformatting();
    } else {
      _selectedimageFilterTabindex = postion;
      notifyListeners();
    }
  }

  setaspectRatio(String ratio) async {
    switch (ratio) {
      case "original":
        {
          aspectRatio = aspectRatios[0];
          break;
        }
      case "custom":
        {
          aspectRatio = aspectRatios[1];
          break;
        }
      case "1*1":
        {
          aspectRatio = aspectRatios[2];
          break;
        }
      case "4*3":
        {
          aspectRatio = aspectRatios[3];
          break;
        }
      case "3*4":
        {
          aspectRatio = aspectRatios[4];
          break;
        }
      case "16*9":
        {
          aspectRatio = aspectRatios[5];
          break;
        }
      case "9*16":
        {
          aspectRatio = aspectRatios[6];
          break;
        }
      default:
        {
          aspectRatio = aspectRatios[0];
          break;
        }
    }
  }

  addImageToLayout(
      String layoutId, int pagePosition, int imageListLength, int imgPos) {
    _selcted_layout_id = layoutId;
    _selcted_pagePosition = pagePosition;
    _selcted_imageListLenght = imageListLength;
    _selcted_imagepos = imgPos;
    print("_selcted_layout_id - " +
        _selcted_layout_id +
        " - _selcted_pagePosition - " +
        _selcted_pagePosition.toString() +
        " - _selcted_imageListLenght - " +
        _selcted_imageListLenght.toString() +
        " - _selcted_imagepos - " +
        _selcted_imagepos.toString());
  }

  openImageFilter(
      String imageUrl,
      String imageType,
      String color,
      String layoutId,
      int pagePosition,
      int imagePostion,
      String seletedImageuri,
      String selectedlowIMageuri,
      bool isLayoutCircle,
      String ratio) async {
    await setaspectRatio(ratio);
    whichImageShow = "original";
    _selcted_image_type = imageType;
    this.isLayoutCircle = isLayoutCircle;
    this.ratio = ratio;

    _selcted_image_url = imageUrl;
    this.selectedlowIMageuri = selectedlowIMageuri;
    _seletedImageuri = seletedImageuri;
    imageQulaityColor = color;
    /*_selcted_image = image;
    _selcted_image_copy = imagecopy;*/
    print(imageQulaityColor);
    _selcted_layout_id = layoutId;
    _selcted_pagePosition = pagePosition;
    _selcted_imagePostion = imagePostion;
    _filterList = [];
    _filterListUrl = [];
    _istextFormatting = 2;
    if (_selcted_image_type != null) {
      if (_selcted_image_type == "memoti" || _selcted_image_type == "google") {
        addFilterDataUrl();
      } else {
        addFilterData(base64);
      }
    }
    print("_selcted_image_type " +
        _selcted_image_type +
        "  _selcted_pagePosition " +
        _selcted_pagePosition.toString() +
        "  _selcted_imagePostion " +
        _selcted_imagePostion.toString());
    print("_selcted_layout_id " +
        _selcted_layout_id +
        "  _selcted_pagePosition " +
        _selcted_pagePosition.toString() +
        "  _selcted_imagePostion " +
        _selcted_imagePostion.toString());
  }

  addItemS(
      List imageList,
      String categoryType,
      int maxPhoto,
      int minPhoto,
      String productId,
      String productPrice,
      String productName,
      String slovaktitle) async {
    // print("selectedSize");
    // print(selectedSize);
    this.selectedSize = selectedSize;
    // print("this.categoryType");
    // print(this.categoryType);
    this.categoryType = categoryType;
    // print("categoryType");
    // print(categoryType);
    product = _selectedproduct[0];
    // print(product);
    maxPage = product["detail"]["maxpage"].toString();
    minPage = product["detail"]["minpage"].toString();
    max_photo = int.parse(product["detail"]["maxpage"].toString());
    min_photo = int.parse(product["detail"]["minpage"].toString());
    product_id = product["detail"]["ii"].toString();
    this.slovaktitle = product["detail"]["slovaktitle"].toString();
    product_name = product["detail"]["title"].toString();
    // print("max_photo - "+max_photo.toString());
    // print("min_photo - "+min_photo.toString());
    // print("product_id - "+product_id.toString());
    // print("product_price - "+product_price.toString());
    // print("selectedSize - "+selectedSize.toString());
    // print("product_name - "+product_name.toString());
    String width = selectedSize.split("x")[0];
    String height = selectedSize.split("x")[1].split("cm")[0];
    selected_width = double.parse(width);
    selected_height = double.parse(height);
    this.width = double.parse(width);
    this.height = double.parse(height);
    // print("imageList.length - "+imageList.length.toString());
    //mainImageList.clear();
    getItems.clear();
    _busy = true;
    _customFontList.clear();
    _fontList.clear();
    _colorList.clear();
    _bgcolorList.clear();
    // print("imageList.length - "+imageList.length.toString());
    mainImageList = imageList;
    List<ImageModel> list = [];
    int pos = 0;
    int pageLength = (mainImageList.length / 2).toInt();
    int count = mainImageList.length % 2;
    // print(mainImageList);
    // print(_selectedCategoryImage);
    // print(selectedCategoryImage);
    for (int i = 0; i < mainImageList.length; i++) {
      print('mainImageList[i]["fileuriPath"]');
      print(mainImageList[i]["fileuriPath"]);
      // print(i.toString()+" size1 - "+imageList[i]["size"].toString());
      // print(i.toString()+" size1 - "+mainImageList[i]["size"].toString());
      //image dpi
      List<String> imageQualityColor = [];
      List<Uint8List> uINtimagelist = [];
      List<String> uintid = [];
      List<String> base64 = [];
      List<String> imageType = [];
      List<String> iscropped = [];
      List<String> aspectRatioo = [];
      List<String> imagefileuripath = [];
      List<String> imagefileuripathlowreso = [];
      List<String> imageUrl = [];
      imagefileuripath.add(mainImageList[i]["fileuriPath"]);
      imagefileuripathlowreso.add(mainImageList[i]["lowresofileuriPath"]);
      iscropped.add("false");
      aspectRatioo.add("");
      imageType.add(mainImageList[i]["image_type"]);
      imageUrl.add(mainImageList[i]["url_image"]);
      print('mainImageList[i]["uint8list"]');
      print(mainImageList[i]["uint8list"]);
      uINtimagelist.add(mainImageList[i]["uint8list"]);
      base64.add(mainImageList[i]["base64"].toString());
      uintid.add(mainImageList[i]["uintid"]);
      mainImageList[i]["count"] = (i - pos).toString() + "," + "0";
      imageQualityColor.add(getImageDpiColor(mainImageList[i]["size"]));
      if (count == 0) {
        imagefileuripath.add(mainImageList[i + 1]["fileuriPath"]);
        imagefileuripathlowreso.add(mainImageList[i + 1]["lowresofileuriPath"]);
        uINtimagelist.add(mainImageList[i + 1]["uint8list"]);
        uintid.add(mainImageList[i + 1]["uintid"]);
        iscropped.add("false");
        aspectRatioo.add("");
        imageType.add(mainImageList[i + 1]["image_type"]);
        imageUrl.add(mainImageList[i + 1]["url_image"]);
        imageQualityColor.add(getImageDpiColor(mainImageList[i + 1]["size"]));
        mainImageList[i + 1]["count"] = (i - pos).toString() + "," + "1";
        if (mainImageList[i + 1]["image_type"] == 'memoti') {
          base64.add("");
        } else {
          base64.add(mainImageList[i + 1]["base64"].toString());
        }
      } else {
        if (i != mainImageList.length - 1) {
          print('mainImageList[i+1]["fileuriPath"]');
          print(mainImageList[i + 1]["fileuriPath"]);
          print("Error");
          imagefileuripath.add(mainImageList[i + 1]["fileuriPath"]);
          imagefileuripathlowreso
              .add(mainImageList[i + 1]["_lowresofileuriPath"]);
          uINtimagelist.add(mainImageList[i + 1]["uint8list"]);
          uintid.add(mainImageList[i + 1]["uintid"]);
          iscropped.add("false");
          aspectRatioo.add("");
          //filelist.add(mainImageList[i + 1].file);
          imageType.add(mainImageList[i + 1]["image_type"]);
          imageUrl.add(mainImageList[i + 1]["url_image"]);
          imageQualityColor.add(getImageDpiColor(mainImageList[i + 1]["size"]));
          mainImageList[i + 1]["count"] = (i - pos).toString() + "," + "1";
          if (mainImageList[i + 1]["image_type"] == 'memoti') {
            print('list[i].imageType');
            base64.add("");
          } else {
            base64.add(mainImageList[i + 1]["base64"].toString());
          }
        } else {
          imagefileuripath.add("");
          imagefileuripathlowreso.add("");
          uINtimagelist.add(new Uint8List(0));
          base64.add("");
          uintid.add("");
          iscropped.add("false");
          aspectRatioo.add("");
          imageType.add("");
          imageUrl.add("");
          imageQualityColor.add(getImageDpiColor(Size(0.0, 0.0)));
        }
      }
      print("imagefileuripath");
      print(imagefileuripath);
      list.add(new ImageModel(
          uINtimagelist,
          uintid,
          imageType,
          imageUrl,
          imagefileuripath,
          imagefileuripathlowreso,
          iscropped,
          aspectRatioo,
          imageQualityColor,
          base64));
      i = i + 1;
      pos++;
      // print(pos);
    }

    print("imageList Length - " + imageList.length.toString());
    for (int i = 0; i < list.length; i++) {
      if (list[i].imageType[0] == 'memoti' || list[i].imageType[0] == 'insta') {
        final imgBase64Str = await networkImageToBase64(list[i].imageUrl[0]);
        list[i].base64[0] = imgBase64Str;
      } else if (list[i].imageType[0] == 'google') {
        final imgBase64Str = await networkImageToBase64(list[i].imageUrl[0]);
        // final imgBase64Str = await networkImageToBase64(list[i].imageUrl[0]+"=w400-h400-c");
        list[i].base64[0] = imgBase64Str;
        print("list[i].base64[0] ");
        print(imgBase64Str);
        if (i == list.length - 1) {
          _busy = false;
          notifyListeners();
        }
      }
      if (list[i].imageType[1] == 'memoti' || list[i].imageType[1] == 'insta') {
        final imgBase64Str = await networkImageToBase64(list[i].imageUrl[1]);
        list[i].base64[1] = imgBase64Str;
        if (i == list.length - 1) {
          _busy = false;
          notifyListeners();
        }
      } else if (list[i].imageType[1] == 'google') {
        final imgBase64Str = await networkImageToBase64(list[i].imageUrl[1]);
        // final imgBase64Str = await networkImageToBase64(list[i].imageUrl[1]+"=w400-h400-c");
        list[i].base64[1] = imgBase64Str;
        if (i == list.length - 1) {
          _busy = false;
          notifyListeners();
        }
      }
      if (i == 0) {
        // print("imageList4   " + i.toString());
        _getItems.add({
          "layout_id": "3",
          "isSelected": true,
          "imageModel": list[i],
          "categoryType": "photobook"
        });
      } else {
        // print("imageList4   " + i.toString());
        _getItems.add({
          "layout_id": "3",
          "isSelected": false,
          "imageModel": list[i],
          "categoryType": "photobook"
        });
      }

      if (i == list.length - 1) {
        notifyListeners();
      }
    }
    starting_page_count = _getItems.length;
    _busy = false;
    addOtherData();
  }

  networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    String base64Image = base64Encode(bytes);
    return base64Image;
  }

  networkImageToBase64bytes(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return bytes;
  }

  addDataForCreationEdit(
      BuildContext contextmain,
      List imageList,
      List itemList,
      String categoryType,
      int maxPhoto,
      int minPhoto,
      String productId,
      String productPrice,
      String selectedSize,
      String productName,
      String slovaktitle) {
    _busy = true;
    this.categoryType = categoryType;
    this.max_photo = maxPhoto;
    this.min_photo = minPhoto;
    this.product_id = productId;
    this.product_price = productPrice;
    this.selectedSize = selectedSize;
    this.slovaktitle = slovaktitle;
    this.product_name = productName;
    maxPage = max_photo.toString();
    minPage = min_photo.toString();
    mainImageList = imageList;
    print(_getItems);
    _getItems = itemList;
    print(" _getItems - " + _getItems.toString());
    for (int i = 0; i < _getItems.length; i++) {
      for (int j = 0; j < _getItems[i]["imageModel"].uint8listid.length; j++) {
        print(_getItems[i]["imageModel"].uint8listid);
        print(_getItems[i]["imageModel"].fileuriPath);
        print(_getItems[i]["imageModel"].iscroppeds);
        print(_getItems[i]["imageModel"].uint8list);
      }
    }
    String width = selectedSize.split("x")[0];
    String height = selectedSize.split("x")[1].split("cm")[0];
    selected_width = double.parse(width);
    selected_height = double.parse(height);
    this.width = double.parse(width);
    this.height = double.parse(height);
    _busy = false;
    print("xcvbn");
    addOtherData();
  }

  addOtherData() {
    _customFontList = [];
    imageTextPostionList = [];
    _fontList = [];
    editTextPostionList = [];
    fontsizeList = [];
    _colorList = [];
    _bgcolorList = [];
    _getLayout = [];
    textEditingController.text = "";
    for (int i = 0; i < 3; i++) {
      _getLayout.add({"_layout_id": (i + 1).toString(), "_isSelected": false});
    }
    _customFontList.add(CustomFontItem(
        "/home/vishal/AndroidStudioProjects/memoti-app/fonts/Poppins-Regular.ttf",
        "Poppins"));
    _customFontList.add(CustomFontItem(
        "/home/vishal/AndroidStudioProjects/memoti-app/fonts/Quicksand-Medium.ttf",
        "Quicksand"));
    _customFontList.add(CustomFontItem(
        "/home/vishal/AndroidStudioProjects/memoti-app/fonts/Raleway-Regular.ttf",
        "Raleway"));
    imageTextPostionList.add(ImageTextEditPostion("Top Left", 0.1, 0.1));
    imageTextPostionList.add(ImageTextEditPostion("Top Center", 0.5, 0.1));
    imageTextPostionList.add(ImageTextEditPostion("Top Right", 0.9, 0.1));
    imageTextPostionList.add(ImageTextEditPostion("Center Left", 0.1, 0.5));
    imageTextPostionList.add(ImageTextEditPostion("Center", 0.5, 0.5));
    imageTextPostionList.add(ImageTextEditPostion("Center Right", 0.9, 0.5));
    imageTextPostionList.add(ImageTextEditPostion("Bottom Left", 0.1, 0.8));
    imageTextPostionList.add(ImageTextEditPostion("Bottom Center", 0.5, 0.8));
    imageTextPostionList.add(ImageTextEditPostion("Bottom Right", 0.9, 0.8));

    for (int i = 0; i < _customFontList.length; i++) {
      _fontList.add(DropdownMenuItem(
        child: Text(
          _customFontList[i].fontName,
          style:
              TextStyle(fontSize: 15, fontFamily: _customFontList[i].fontspath),
        ),
        value: i,
      ));
    }

    for (int i = 0; i < imageTextPostionList.length; i++) {
      editTextPostionList.add(DropdownMenuItem(
        child: Text(
          imageTextPostionList[i].name,
          style: TextStyle(fontSize: 15, fontFamily: selectedfontpath),
        ),
        value: i,
      ));
    }
    for (int i = 10; i < 51; i++) {
      fontsizeList.add(DropdownMenuItem(
        child: Text(
          i.toString(),
          style: TextStyle(fontSize: 15, fontFamily: selectedfontpath),
        ),
        value: i,
      ));
    }

    _colorList.add(new CustomColor(Colors.transparent, false));
    _colorList.add(new CustomColor(Colors.white, true));
    _colorList.add(new CustomColor(Colors.black, false));
    _colorList.add(new CustomColor(Colors.blue, false));
    _colorList.add(new CustomColor(Colors.yellow, false));
    _colorList.add(new CustomColor(Colors.orange, false));
    _colorList.add(new CustomColor(Colors.green, false));
    _colorList.add(new CustomColor(Colors.red, false));
    _colorList.add(new CustomColor(Colors.brown, false));
    _bgcolorList.add(new CustomColor(Colors.transparent, false));
    _bgcolorList.add(new CustomColor(Colors.white, true));
    _bgcolorList.add(new CustomColor(Colors.black, false));
    _bgcolorList.add(new CustomColor(Colors.blue, false));
    _bgcolorList.add(new CustomColor(Colors.yellow, false));
    _bgcolorList.add(new CustomColor(Colors.orange, false));
    _bgcolorList.add(new CustomColor(Colors.green, false));
    _bgcolorList.add(new CustomColor(Colors.red, false));
    _bgcolorList.add(new CustomColor(Colors.brown, false));
    //notifyListeners();
  }

  Future<String> getItemResponseinString(/*String msg*/) async {
    String response;
    if (categoryType == "poster") {
      response = jsonEncode({"product_item": []});
      return response;
    } else if (categoryType == "canvas") {
      dynamic data1 = {
        "product_prices": product_price,
        "product_id": product_id,
        "product": selectedproduct,
        /*"selectedThickness": selectedThickness,
        "selectedborder": selectedBorder,
        "selectedcolor": selectedcolor,*/
        "count": "1",
        "selectedSizes": selectedSize,
        "product_type": "canvas",
        "product_names": product_name,
        "slovaktitle": slovaktitle,
      };

      String response = jsonEncode({"product_item": data1});
      return response;
    } else {
      response = jsonEncode({"product_item": _getItems});
      return response;
    }
  }

  Future<String> getmainImageListResponseinString(/*String msg*/) async {
    print('getmainImageListResponseinString');
    print(imageList);
    print(mainImageList);
    print(categoryType);
    if (categoryType == "canvas") {
      mainImageList = imageList;
    } else if (categoryType == "poster") {
      mainImageList = imageList;
    }
    for (int i = 0; i < mainImageList.length; i++) {
      mainImageList[i]["size"] = mainImageList[i]["size"].toString();
    }
    print("mainImageList");
    // print(mainImageList);
    String response = jsonEncode({"mainImageList": mainImageList});
    return response;
  }

  Widget setupAlertDialoadContainer2(
      BuildContext contextmain, BuildContext context, String text) {
    print("tyjhukl");
    return Container(
      height: 150.0, // Change as per your requirement
      width: 150.0, // Change as per your requirement
      child: Column(
        children: [
          Text(text),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: Text(Languages.of(contextmain)!.Close),
            style: ElevatedButton.styleFrom(
              primary: MyColors.primaryColor,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              side: BorderSide(color: MyColors.primaryColor),
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
          // RaisedButton(
          //   textColor: Colors.white,
          //   shape:  RoundedRectangleBorder(
          //     borderRadius: new BorderRadius.circular(25.0),
          //     side: BorderSide(color: MyColors.primaryColor),
          //   ),
          //   color:MyColors.primaryColor,
          //   child: Container(
          //     height: 45,
          //     width: MediaQuery.of(context).size.width*.4,
          //     child: Center(
          //       child: Text(
          //         Languages.of(contextmain)!.Close,
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 18
          //         ),
          //       ),
          //     ),
          //   ),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },),
        ],
      ),
    );
  }

  Future<void> removeIMage() async {
    int imagePosition = 0;
    if (_selcted_image_type == "memoti" ||
        _selcted_image_type == "google" ||
        _selcted_image_type == "phone_gallery") {
      for (int i = 0; i < mainImageList.length; i++) {
        if (_selcted_image_url == mainImageList[i]["url_image"]) {
          imagePosition = i;
          if (mainImageList[imagePosition]["count"].split(",").length > 2) {
            List<String> counts =
                mainImageList[imagePosition]["count"].split(",");
            for (int j = 0; j < counts.length; i++) {
              if (counts[j] == _selcted_pagePosition.toString()) {
                counts.removeAt(j);
                counts.removeAt(j);
                // print(counts.toString());
                // print(imagePosition.toString());
                // print(i.toString());
                mainImageList[imagePosition]["count"] = counts.join(",");
                break;
              }
              j = j + 1;
            }
          } else {
            mainImageList.removeAt(imagePosition);
          }
          break;
        }
      }
    } else {
      for (int i = 0; i < mainImageList.length; i++) {
        if (_seletedImageuri == mainImageList[i]["fileuriPath"]) {
          imagePosition = i;
          if (mainImageList[imagePosition]["count"].split(",").length > 2) {
            List<String> counts =
                mainImageList[imagePosition]["count"].split(",");
            for (int j = 0; j < counts.length; i++) {
              if (counts[j] == _selcted_pagePosition.toString()) {
                counts.removeAt(j);
                counts.removeAt(j);
                // print(counts.toString());
                // print(imagePosition.toString());
                // print(i.toString());
                mainImageList[imagePosition]["count"] = counts.join(",");
                break;
              }
              j = j + 1;
            }
          } else {
            mainImageList.removeAt(imagePosition);
          }
          break;
        }
      }
    }
    _selcted_image_type = "";
    _selcted_image_url = "";
    ratio = "";
    _selcted_image_url = "";
    _seletedImageuri = new io.File("a.txt").uri.path;
    _getItems[_selcted_pagePosition]["imageModel"]
        .iscroppeds[_selcted_imagePostion] = "";
    _getItems[_selcted_pagePosition]["imageModel"]
        .aspectRatio[_selcted_imagePostion] = "";
    _getItems[_selcted_pagePosition]["imageModel"]
        .fileuriPath[_selcted_imagePostion] = _seletedImageuri;
    _getItems[_selcted_pagePosition]["imageModel"]
        .fileuriPathlowreso[_selcted_imagePostion] = _seletedImageuri;
    _getItems[_selcted_pagePosition]["imageModel"]
        .base64[_selcted_imagePostion] = _seletedImagebase64uri;
    _getItems[_selcted_pagePosition]["imageModel"]
        .imageType[_selcted_imagePostion] = "";
    _getItems[_selcted_pagePosition]["imageModel"]
        .imageUrl[_selcted_imagePostion] = "";
    _getItems[_selcted_pagePosition]["imageModel"]
        .imageQualityColor[_selcted_imagePostion] = "";
    whichImageShow = "original";
    closedImageFilter();
  }

  void addFilterDataUrl() {
    _filterListUrl.clear();
    _filterListUrl.add(new ImageFilterModelUrl(
        _seletedImageuri,
        _selcted_image_url,
        _selcted_image_type,
        "NO FILTER",
        NOFILTER,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        _seletedImageuri,
        _selcted_image_url,
        _selcted_image_type,
        "SEPIA",
        SEPIA_MATRIX,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        _seletedImageuri,
        _selcted_image_url,
        _selcted_image_type,
        "GREYSCALE",
        GREYSCALE_MATRIX,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        _seletedImageuri,
        _selcted_image_url,
        _selcted_image_type,
        "VINTAGE",
        VINTAGE_MATRIX,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        _seletedImageuri,
        _selcted_image_url,
        _selcted_image_type,
        "SWEET",
        SWEET_MATRIX,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        _seletedImageuri,
        _selcted_image_url,
        _selcted_image_type,
        "MILK",
        MILK,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        _seletedImageuri,
        _selcted_image_url,
        _selcted_image_type,
        "SEPIUM",
        SEPIUM,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        _seletedImageuri,
        _selcted_image_url,
        _selcted_image_type,
        "COLD LIFE",
        COLDLIFE,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        _seletedImageuri,
        _selcted_image_url,
        _selcted_image_type,
        "OLD TIME",
        OLDTIME,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        _seletedImageuri,
        _selcted_image_url,
        _selcted_image_type,
        "BLACK & WHITE",
        BLACKANDWHITE,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        _seletedImageuri,
        _selcted_image_url,
        _selcted_image_type,
        "CYAN",
        CYAN,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        _seletedImageuri,
        _selcted_image_url,
        _selcted_image_type,
        "YELLOW",
        YELLOW,
        false,
        selcted_image_base64new));
    _filterListUrl.add(new ImageFilterModelUrl(
        _seletedImageuri,
        _selcted_image_url,
        _selcted_image_type,
        "PURPLE",
        PURPLE,
        false,
        selcted_image_base64new));
    notifyListeners();
  }

  Future<void> addImage(List imageList) async {
    _getItems[_selcted_pagePosition]["imageModel"].imageUrl[_selcted_imagepos] =
        imageList[0]["url_image"];
    _getItems[_selcted_pagePosition]["imageModel"]
        .fileuriPath[_selcted_imagepos] = imageList[0]["fileuriPath"];
    _getItems[_selcted_pagePosition]["imageModel"]
            .fileuriPathlowreso[_selcted_imagepos] =
        imageList[0]["lowresofileuriPath"];
    _getItems[_selcted_pagePosition]["imageModel"]
        .imageType[_selcted_imagepos] = imageList[0]["image_type"];
    _getItems[_selcted_pagePosition]["imageModel"]
        .uint8list[_selcted_imagepos] = imageList[0]["uint8list"];
    _getItems[_selcted_pagePosition]["imageModel"].base64[_selcted_imagepos] =
        imageList[0]["base64"];
    _getItems[_selcted_pagePosition]["imageModel"]
        .uint8listid[_selcted_imagepos] = imageList[0]["uintid"];
    _getItems[_selcted_pagePosition]["imageModel"]
            .imageQualityColor[_selcted_imagepos] =
        getImageDpiColor(imageList[0]["size"]);
    imageList[0]["count"] =
        _selcted_pagePosition.toString() + "," + _selcted_imagepos.toString();
    int pos = 0;
    int pp = 0;
    for (int i = 0; i < _getItems.length; i++) {
      if (i == _selcted_pagePosition) {
        for (int j = 0; j < _getItems[i]["imageModel"].imageType.length; j++) {
          if (j == _selcted_imagepos) {
            pp = pos;
            break;
          } else {
            pos = pos + 1;
          }
        }
      } else {
        for (int j = 0; j < _getItems[i]["imageModel"].imageType.length; j++) {
          pos = pos + 1;
        }
      }
    }
    // print("mainImageList .lenght first "+mainImageList.length.toString());
    mainImageList.insertAll(pp, imageList);
    // print("mainImageList .lenght seond "+mainImageList.length.toString());
    notifyListeners();
  }

  Future<void> addIMages(List imageList) async {
    for (int i = 0; i < imageList.length; i++) {
      imageList[i].count = "";
    }
    mainImageList.addAll(imageList);
    notifyListeners();
  }

  changeBottom(String which) {
    if (which == "") {
      _which_bottom = "";
    } else if (which == "1") {
      _which_bottom = "1";
    } else if (which == "2") {
      _which_bottom = "2";
    } else {
      _which_bottom = "";
    }
    notifyListeners();
  }

  bool _addcart = false;
  bool boolerror = false;
  String stringUploadingImageCount = "";
  bool get addcart => _addcart;
  bool fade_in_out = true;
  int uploadimageCount = 0;
  bool ispreviewPage = false;
  addtocart(contextmain, context) async {
    print(mainImageList);
    calledcart = true;
    if (_addcart) {
      _addcart = false;
      notifyListeners();
      return;
    }
    print("itemList");
    // print(mainImageList);
    _addcart = true;
    boolerror = false;
    stringUploadingImageCount =
        uploadimageCount.toString() + "/" + mainImageList.length.toString();
    // notifyListeners();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String userId = prefs.getString(UiData.user_id) ?? "";
    if (userId == "") {
      _addcart = false;
      ispreviewPage = true;
      notifyListeners();
      SystemChrome.setPreferredOrientations([
        /* DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,*/
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      name = prefs.getString(UiData.name) ?? "";
      email = prefs.getString(UiData.email) ?? "";
      image = prefs.getString(UiData.picture) ?? "";
      user_ids = prefs.getString(UiData.user_id) ?? "";
      token = prefs.getString(UiData.token) ?? "";
      address = prefs.getString(UiData.address) ?? "";
      // notifyListeners();
      // Temp
      // MemotiDbProvider.db.removecreationItem(creation_id).then((value) async {
      //   // _capturePng1(contextmain, context);
      addCartDatatoSqlfite(contextmain, context);
      // });
    }
  }

  uploadimageNew(contextmain, context, List<Uint8List> pdfimages) async {
    int i = 0;
    final pdf = pw.Document();
    for (int i = 0; i < _getItems.length; i++) {
      for (int j = 0; j < _getItems[i]["imageModel"].imageType.length; j++) {
        for (int k = 0; k < mainImageList.length; k++) {
          if (_getItems[i]["imageModel"].fileuriPath[j] ==
              mainImageList[k]["fileuriPath"]) {
            mainImageList[k]["lowresofileuriPath"] =
                _getItems[i]["imageModel"].fileuriPathlowreso[j];
            mainImageList[k]["base64"] = _getItems[i]["imageModel"].base64[j];
            mainImageList[k]["isCropped"] =
                _getItems[i]["imageModel"].iscroppeds[j];
          }
        }
      }
    }

    for (int j = 0; j < _getItems.length; j++) {
      if (_getItems[j]["layout_id"] == "1") {
        addlayoutid1page(pdf, i, (i + 1), pdfimages);
        i = i + 2;
        // break;
      } else if (_getItems[j]["layout_id"] == "2") {
        addlayoutid2page(pdf, i, (i + 1), (i + 2), (i + 3), pdfimages);
        i = i + 4;
        // break;
      } else if (_getItems[j]["layout_id"] == "3") {
        addlayoutid3page(pdf, i, (i + 1), pdfimages);
        i = i + 2;
        // break;
      }
    }
    final output = await getTemporaryDirectory();
    final file =
        new io.File(output.path + "/" + DateTime.now().toString() + ".pdf");
    //final io.File = io.File("example.pdf");
    ddd = await file.writeAsBytes(await pdf.save());
    // print("sizzzze -" + await getFileSize(ddd, 1));

    var stream = new http.ByteStream(DelegatingStream.typed(ddd.openRead()));
    var length = await ddd.length();

    var uri1 = Uri.parse("http://3.65.87.190:5000/upload");

    var request = new http.MultipartRequest("POST", uri1);
    var multipartFile = new http.MultipartFile('photos', stream, length,
        filename: basename(ddd.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    // print(response.statusCode);
    await http.Response.fromStream(response).then((value) {
      String pdfUrl = json.decode(value.body)["data"]["location"];
      print("categoryType");
      print(categoryType);
    print('mainImageList');
    print(mainImageList);
      for(int i = 0; i<mainImageList.length;i++){

      print("mainImageList[i]");
      print(mainImageList[i]);
      // print(mainImageList[i]["uint8listid"]);
      }
      // return;
      getItemResponseinString().then((items) {
        // print("jsonStingitems - "+items);
        getmainImageListResponseinString().then((mainimages) {
          if (wechatIMages != null) {
            wechatIMages = [];
            imagess = [];
            listGoogleMediaItem = [];
            memotiGalleryPhotoList = [];
            _imageCount = 0;
            _selectedCategoryImage = [];
            images = [];
            unselectAll();
            _currentScreenIndex = 0;
          }
          if (categoryType == "cart") {
            // Temp
            MemotiDbProvider.db.removecart(cartIndex1).then((value) {
          print(mainimages); 
          print("jsonStringsimageList - "+mainimages.length.toString()); 
          // return;
              MemotiDbProvider.db
                  .insertCart(
                      "photobook",
                      mainimages,
                      jsonDecode(mainimages)["mainImageList"][0]["base64"],
                      items,
                      max_photo.toString(),
                      min_photo.toString(),
                      product_id,
                      product_price,
                      selectedSize,
                      product_name,
                      slovaktitle,
                      pdfUrl,
                      "1",
                      "pending")
                  .then((value) {
                _addcart = false;
                boolerror = false;
                currentIndex = 2;
                notifyListeners();
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ]);
                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => TabsPage(),
                  ),
                  (route) =>
                      false, //if you want to disable back feature set to false
                );
              });
            });
          } else {
            // Temp
            MemotiDbProvider.db
                .insertCart(
                    "photobook",
                    mainimages,
                    jsonDecode(mainimages)["mainImageList"][0]["base64"],
                    items,
                    maxPage.toString(),
                    minPage.toString(),
                    product_id,
                    product_price,
                    selectedSize,
                    product_name,
                    slovaktitle,
                    pdfUrl,
                    "1",
                    "pending")
                .then((value) {
              _addcart = false;
              boolerror = false;
              currentIndex = 2;
              notifyListeners();
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]);
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => TabsPage(),
                ),
                (route) =>
                    false, //if you want to disable back feature set to false
              );
            });
          }
        });
      });
    });
  }

  Future<void> addCartDatatoSqlfite(contextmain, context) async {
    print("_getItems");
    // print(_getItems);
    notifyListeners();
    stringUploadingImageCount = Languages.of(contextmain)!.Processing;
    List<Uint8List> pdfimages = [];
    int time = 1000;
    int image_length = 0;
    for (var i = 0; i < _getItems.length; i++) {
      for (int x = 0; x < _getItems[i]["imageModel"].imageType.length; x++) {
        image_length = image_length + 1;
        uploadimageCount = image_length;
        if (_getItems[i]["imageModel"].iscroppeds[x] == "true") {
          // Uint8List byte =
          //     await File(_getItems[i]["imageModel"].fileuriPathlowreso[x])
          //         .readAsBytes();
          Uint8List byte = base64Decode(_getItems[i]["imageModel"].base64[x]);
          pdfimages.add(byte);
          stringUploadingImageCount = uploadimageCount.toString() +
              "/" +
              mainImageList.length.toString();
          // notifyListeners();
          if (_getItems.length - 1 == i) {
            if (_getItems[i]["imageModel"].imageType.length - 1 == x) {
              stringUploadingImageCount = Languages.of(contextmain)!.Processing;
              uploadimageNew(contextmain, context, pdfimages);
            }
          }
        } else {
          updateimagepath = "";
          updateimagepathbase64 = "";
          imageupdate = true;
          if (_getItems[i]["imageModel"].imageType[x] == "phone") {
            type = "phone";
            updateimagepath = _getItems[i]["imageModel"].fileuriPath[x];
            updateimagepathbase64 = await converttobase64bytes(
                _getItems[i]["imageModel"].fileuriPath[x]);
          } else {
            type = "url";
            String imageUrl = "";
            if (_getItems[i]["imageModel"].imageType[x] == "memoti") {
              updateimagepath = _getItems[i]["imageModel"].imageUrl[x];
              updateimagepathbase64 = await networkImageToBase64(
                  _getItems[i]["imageModel"].imageUrl[x]);
            } else if (_getItems[i]["imageModel"].imageType[x] == "insta") {
              updateimagepath = _getItems[i]["imageModel"].imageUrl[x];
              updateimagepathbase64 = await networkImageToBase64(
                  _getItems[i]["imageModel"].imageUrl[x]);
            } else if (_getItems[i]["imageModel"].imageType[x] == "google") {
              updateimagepath = _getItems[i]["imageModel"].imageUrl[x];
              updateimagepathbase64 = await networkImageToBase64(
                  _getItems[i]["imageModel"].imageUrl[x]);
            } else {
              // updateimagepath =
              //     _getItems[i]["imageModel"].imageUrl[x]+"=w400-h400-c";
              // updateimagepathbase64 = await networkImageToBase64(_getItems[i]["imageModel"].imageUrl[x]+"=w400-h400-c");
              updateimagepath = _getItems[i]["imageModel"].imageUrl[x];
              updateimagepathbase64 = await networkImageToBase64(
                  _getItems[i]["imageModel"].imageUrl[x]);
            }
          }
          // print("type-  " + type);
          // notifyListeners();
          time = time + 30;
          await Future.doWhile(() async {
            await Future.delayed(Duration(seconds: 1));
            // print("2");
            // print(time);
            // print(imageloadingstate);
            if (imageloadingstate == "complete") {
              // notifyListeners();
              await convertImageToCropImageFile().then((value) async {
                _getItems[i]["imageModel"].fileuriPathlowreso[x] =
                    value.uri.path;
                _getItems[i]["imageModel"].iscroppeds[x] = "true";
                _getItems[i]["imageModel"].aspectRatio[x] =
                    (width / height).toString();
                Uint8List byte = await value.readAsBytes();
                pdfimages.add(byte);
                stringUploadingImageCount = uploadimageCount.toString() +
                    "/" +
                    mainImageList.length.toString();
                //notifyListeners();
                if (_getItems.length - 1 == i) {
                  if (_getItems[i]["imageModel"].imageType.length - 1 == x) {
                    imageupdate = false;
                    // notifyListeners();
                    // stringUploadingImageCount =
                    //     Languages.of(contextmain)!.Processing;
                    uploadimageNew(contextmain, context, pdfimages);
                  }
                }
              });
              return false;
            } else if (imageloadingstate == "failed") {
              print('imageloadingstate=="failed"');
              _getItems[i]["imageModel"].fileuriPathlowreso[x] =
                  _getItems[i]["imageModel"].fileuriPath[x];
              _getItems[i]["imageModel"].iscroppeds[x] = "false";
              _getItems[i]["imageModel"].aspectRatio[x] =
                  (width / height).toString();
              // Uint8List byte = await File(_getItems[i]["imageModel"].fileuriPath[x]).readAsBytes();
              Uint8List byte =
                  base64Decode(_getItems[i]["imageModel"].base64[x]);
              pdfimages.add(byte);
              if (_getItems.length - 1 == i) {
                if (_getItems[i]["imageModel"].imageType.length - 1 == x) {
                  imageupdate = false;
                  notifyListeners();
                  stringUploadingImageCount =
                      Languages.of(contextmain)!.Processing;
                  uploadimageNew(contextmain, context, pdfimages);
                }
              }
              return false;
            }
            return true;
          });
        }
      }
    }
  }

  Future<io.File> convertImageToCropImageFile() async {
    // print(cropKey);
    // notifyListeners();
    final ExtendedImageEditorState? state = cropKey.currentState;
    final Rect? rect = state!.getCropRect();
    final EditActionDetails? action = state.editAction;

    final img = state.rawImageData;
    // print("rawimagedata");
    // print("rawImageData " + img.toString());
    ImageEditorOption option = ImageEditorOption();

    if (action!.needCrop) option.addOption(ClipOption.fromRect(rect!));
    final result = await ImageEditor.editImageAndGetFile(
      image: img,
      imageEditorOption: option,
    );
    return result;
  }

  getbase64fromfileimage(file) async {
    final bytes = file.readAsBytesSync();
    String _img64 = base64Encode(bytes);
    return _img64;
  }

  List<String> layout_id = [];
  Future<void> _capturePng1(contextmain, context) async {
    //List<String> uri = [];
    List images = [];
    List<Uint8List> pdfimages = [];
    int time = 500;
    layout_id.clear();
    int image_length = 0;
    for (var x = 0; x < mainImageList.length; x++) {
      List<String> uri = [];
      if (x < _getItems.length) {
        // print(_getItems[x]["layout_id"]);
        layout_id.add(_getItems[x]["layout_id"]);
      }
      // print("x- "+x.toString());
      // print("itemList[x].isCropped- "+mainImageList[x].isCropped);
      if (mainImageList[x].isCropped == "true") {
        // print(mainImageList[x].lowresofileuriPath);
        // print(mainImageList[x].fileuriPath);
        Uint8List byte = await new io.File(mainImageList[x].lowresofileuriPath)
            .readAsBytes();
        pdfimages.add(byte);
        await getbase64fromfileimage(
                new io.File(mainImageList[x].lowresofileuriPath))
            .then((response1) async {
          uri.add("data:image/png;base64," + response1);
          //print(uri[x]);
          print(uri.length);
          image_length = image_length + 1;
          dynamic data = {"images": uri};
          String body = json.encode(data);
          print("mobileuploadbody -" + body.toString());
          var url = Uri.parse(
              'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobileupload');
          http.Response response = await http.post(url,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: body);
          print(response.statusCode);
          List repp = json.decode(response.body);
          for (int i = 0; i < repp.length; i++) {
            images.add(repp[i]["image"]);
          }
          uploadimageCount = image_length;
          stringUploadingImageCount = uploadimageCount.toString() +
              "/" +
              mainImageList.length.toString();
          notifyListeners();
          if (mainImageList.length - 1 == x) {
            stringUploadingImageCount = Languages.of(contextmain)!.Processing;
            notifyListeners();
            uploadimage(contextmain, images, context, image_length, pdfimages);
          }
        });
      } else {
        updateimagepath = "";
        updateimagepathbase64 = "";
        imageupdate = true;
        if (mainImageList[x].image_type == "phone") {
          type = "phone";
          updateimagepath = mainImageList[x].fileuriPath;
          updateimagepathbase64 =
              converttobase64bytes(mainImageList[x].fileuriPath);
        } else {
          type = "url";
          String imageUrl = "";
          if (mainImageList[x].image_type == "memoti") {
            updateimagepath = mainImageList[x].url_image;
            updateimagepathbase64 =
                networkImageToBase64(mainImageList[x].url_image);
          } else if (mainImageList[x].image_type == "google") {
            updateimagepath = mainImageList[x].url_image;
            updateimagepathbase64 =
                networkImageToBase64(mainImageList[x].url_image);
          } else if (mainImageList[x].image_type == "insta") {
            updateimagepath = mainImageList[x].url_image;
            updateimagepathbase64 =
                networkImageToBase64(mainImageList[x].url_image);
          } else {
            updateimagepath = mainImageList[x].url_image;
            updateimagepathbase64 =
                networkImageToBase64(mainImageList[x].url_image);
            // updateimagepath = mainImageList[x].url_image+"=w400-h400-c";
            // updateimagepathbase64 = networkImageToBase64(mainImageList[x].url_image+"=w400-h400-c");
          }
        }
        print("type-  " + type);
        notifyListeners();
        time = time + 30;
        print("1");
        await Future.delayed(Duration(milliseconds: time), () {
          // Do something
        });
        int time1 = 10;
        print("2");
        double size =
            mainImageList[x].size.height + mainImageList[x].size.width;
        print(size);
        if (imageloadingstate != "complete") {
          if (size >= 1000.0 && size <= 1500.0) {
            time1 = 1500;
          }
          /* else if(size>=1001.0&&size<=2000.0){
            time1 = 3000;
          }*/
          else if (size >= 1501.0 && size <= 3500.0) {
            time1 = 2000;
          } else if (size >= 3501.0 && size <= 4500.0) {
            time1 = 3000;
          } else {
            time1 = 3500;
          }
          print(time1);
          await Future.delayed(Duration(milliseconds: time1), () {
            // Do something
            print("3");
          });
        }
        print("4");
        await convertImageToCropImage().then((value) async {
          String base64string = base64Encode(value!);
          print("5");
          pdfimages.add(value);
          imageloadingstate = "";
          uri.add("data:image/png;base64," + base64string);
          image_length = image_length + 1;
          dynamic data = {"images": uri};
          String body = json.encode(data);
          print("mobileuploadbody -" + body.toString());
          var url = Uri.parse(
              'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobileupload');
          http.Response response = await http.post(url,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: body);
          print(response.statusCode);
          List repp = json.decode(response.body);
          for (int i = 0; i < repp.length; i++) {
            images.add(repp[i]["image"]);
          }
          uploadimageCount = image_length;
          stringUploadingImageCount = uploadimageCount.toString() +
              "/" +
              mainImageList.length.toString();
          if (mainImageList.length - 1 == x) {
            imageupdate = false;
            stringUploadingImageCount = Languages.of(contextmain)!.Processing;
            notifyListeners();
            uploadimage(contextmain, images, context, image_length, pdfimages);
          }
        });
      }
    }
  }
  openpdf(context){

  }
  uploadimage(contextmain, uri, context, int image_length,
      List<Uint8List> pdfimages) async {
    List images = [];
    images = uri;
    int totalimage = 0;
    for (int i = 0; i < _getItems.length; i++) {
      for (int j = 0; j < _getItems[i]["imageModel"].imageType.length; j++) {
        totalimage = totalimage + 1;
      }
    }
    int exact_image_length = images.length;
    for (int i = image_length; i < totalimage; i++) {
      itemList.add({
        "id": "22",
        "name": "name",
        "createdDate": DateTime.now(),
        "fileuriPath": new io.File("abc.txt").uri.path,
        "lowresofileuriPath": new io.File("abc.txt").uri.path,
        // "uint8list": new Uint8List(0),
        "uintid": "",
        "size": Size(0.0, 0.0),
        "image_type": "",
        "url_image": "",
        "count": "",
        "isCropped": "",
        "aspectRatio": "",
        "isSelected": false
      });
      images.add("");
      pdfimages.add(Uint8List(0));
    }
    for (int i = 0; i < exact_image_length; i++) {
      if (itemList[i].count.split(",").length > 2) {
        List<String> counts = itemList[i].count.split(",");
        print(itemList[i].count);
        print("count");
        print(counts.length);
        for (int j = 2; j < counts.length; j++) {
          int page_pos = int.parse(counts[j]);
          int img_pos = int.parse(counts[j + 1]);
          int used_img_count = 0;
          for (int k = 0; k < _getItems.length; k++) {
            print("getItems[k].imageModel.imageType.length" +
                _getItems[k].imageModel.imageType.length.toString());
            for (int l = 0; l < _getItems[k].imageModel.imageType.length; l++) {
              if (page_pos == k) {
                if (l == img_pos) {
                  print("K - " + k.toString() + " - l - " + l.toString());
                  print("page_pos - " +
                      page_pos.toString() +
                      " - img_pos - " +
                      img_pos.toString());
                  used_img_count = used_img_count;
                  print("used_img_count - " + used_img_count.toString());
                  images.insert(used_img_count, images[i]);
                  pdfimages.insert(used_img_count, pdfimages[i]);
                  images.removeAt(used_img_count + 1);
                  pdfimages.removeAt(used_img_count + 1);
                  //images.remove(used_img_count+1);
                  print("images.length - " + images.length.toString());
                  print("pdfimages.length - " + pdfimages.length.toString());
                }
              }
              used_img_count = used_img_count + 1;
            }
          }
          j = j + 1;
        }
      }
    }
    print(images.length);
    print(pdfimages.length);
    print(exact_image_length);
    int i = 0;
    final pdf = pw.Document();
    // for(int i = 0;i<_getItems.length;i++){
    //   print("lowfilelength - "+getItems[i]["imageModel"].fileuriPathlowreso.length.toString());
    //   print("imagetypelength - "+getItems[i]["imageModel"].imageType.length.toString());
    // }

    for (int j = 0; j < _getItems.length; j++) {
      if (_getItems[j].layout_id == "1") {
        addlayoutid1page(pdf, i, (i + 1), pdfimages);
        i = i + 2;
        break;
      } else if (_getItems[j].layout_id == "2") {
        addlayoutid2page(pdf, i, (i + 1), (i + 2), (i + 3), pdfimages);
        i = i + 4;
        break;
      } else if (_getItems[j].layout_id == "3") {
        addlayoutid3page(pdf, i, (i + 1), pdfimages);
        i = i + 2;
        break;
      }
    }
    final output = await getTemporaryDirectory();
    final file =
        new io.File(output.path + "/" + DateTime.now().toString() + ".pdf");
    //final io.File = io.File("example.pdf");
    ddd = await file.writeAsBytes(await pdf.save());
    print("sizzzze -" + await getFileSize(ddd, 1));

    var stream = new http.ByteStream(DelegatingStream.typed(ddd.openRead()));
    var length = await ddd.length();

    var uri1 = Uri.parse("http://3.65.87.190:5000/upload");

    var request = new http.MultipartRequest("POST", uri1);
    var multipartFile = new http.MultipartFile('photos', stream, length,
        filename: basename(ddd.path));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    await http.Response.fromStream(response).then((value) {
      saveaddtocart(contextmain, context, images, value);
      _addcart = false;
      notifyListeners();
    });
  }

  getFileSize(var file, int decimals) async {
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  GlobalKey globalKey = GlobalKey();
  increasePerviewPagePostion() {
    fade_in_out = false;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 250), () {
      if (perview_page_position == _getItems.length - 1) {
        perview_page_position = 0;
      } else {
        perview_page_position = perview_page_position + 1;
      }
      print("perview_page_position  -  " + perview_page_position.toString());
      fade_in_out = true;
      int pagepos = 0;
      if (perview_page_position == 0) {
        previousNumber = _getItems.length * 2;
        currentNumber = (perview_page_position + 1) * 2;
        nextNumber = (perview_page_position + 2) * 2;
      } else if (perview_page_position == _getItems.length - 1) {
        previousNumber = perview_page_position * 2;
        currentNumber = _getItems.length * 2;
        nextNumber = 2;
      } else {
        for (int i = 0; i <= perview_page_position; i++) {
          pagepos = pagepos + 2;
        }
        print("pagepos  -  " + pagepos.toString());
        currentNumber = pagepos;
        previousNumber = pagepos - 2;
        nextNumber = pagepos + 2;
      }
      notifyListeners();
    });
  }

  dynamic ddd;
  int get cartIndex1 => cartIndex;
  saveaddtocart(
    contextmain,
    context,
    list,
    http.Response value,
  ) async {
    print(list.length);
    for (int i = 0; i < list.length; i++) {
      print(list[i]);
    }
    dynamic data1 = {
      "product_prices": product_prices,
      "product_id": product_id,
      "min_photo": min_photo.toString(),
      "max_photo": max_photo.toString(),
      "layout_id": layout_id,
      "count": "1",
      "selectedSizes": selectedSizes,
      "product_type": "photobook",
      "product_names": product_names,
      "slovaktitle": slovaktitle,
      "images": list,
      "pdf_url": json.decode(value.body)["data"]["location"],
    };
    if (categoryType == "cart") {
      cartlist.removeAt(cartIndex1);
    }

    //print(data1);
    cartlist.insert(0, data1);
    dynamic data = {
      "customer_id": user_ids,
      "items": cartlist,
      "product_names": product_names,
      "selectedSizes": selectedSizes,
      "product_prices": product_prices
    };
    String body = json.encode(data);
    print(body);
    var url = Uri.parse(
        'https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/inventory/add/product/to/cart');

    http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    _addcart = true;
    notifyListeners();
    // print(response.body);
    if (response.statusCode == 200) {
      _addcart = false;
      boolerror = false;
      notifyListeners();
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => TabsPage(),
          // TabsPage(contextmain, 2, ""),
        ),
        (route) => false, //if you want to disable back feature set to false
      );
    } else {
      boolerror = true;
      _addcart = false;
      notifyListeners();
      throw Exception('Failed to load album');
    }
  }

  // late PdfImageOrientation orientation;
  // late double dpi;
  void addlayoutid1page(
    pw.Document pdf,
    int index1,
    int index2,
    List<Uint8List> images,
  ) async {
    print("addlayoutid1page");
    /* final image  = pw.MemoryImage(File(_getItems[getItemsindex].imageModel.fileuriPath[0]).readAsBytesSync());
    final image1  = pw.MemoryImage(File(_getItems[getItemsindex].imageModel.fileuriPath[1]).readAsBytesSync());
   */
    final image1 =
        pw.MemoryImage(images[index1], orientation: orientation, dpi: dpi);
    final image2 =
        pw.MemoryImage(images[index2], orientation: orientation, dpi: dpi);

    print("1111");
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat(
            (width * 2) * PdfPageFormat.cm, height * PdfPageFormat.cm,
            marginAll: 0.0 * PdfPageFormat.cm),
        build: (pw.Context contxt) {
          return pw.Container(
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                pw.Container(
                  margin: pw.EdgeInsets.only(left: 13),
                  height: 8,
                  child: pw.VerticalDivider(
                      // width: 8,
                      thickness: 5,
                      color: PdfColor.fromHex("808080")),
                ),
                pw.Expanded(
                    child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                      pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Container(
                                margin: pw.EdgeInsets.only(top: 13),
                                child: pw.Container(
                                    height: 5,
                                    width: 8,
                                    color: PdfColor.fromHex("808080"))),
                            pw.Container(
                                margin: pw.EdgeInsets.only(bottom: 13),
                                child: pw.Container(
                                    height: 5,
                                    width: 8,
                                    color: PdfColor.fromHex("808080")))
                          ]),
                      pw.Expanded(
                          child: pw.Container(
                        margin: pw.EdgeInsets.only(
                            top: 21, left: 16, right: 8, bottom: 21),
                        decoration: pw.BoxDecoration(
                          shape: pw.BoxShape.circle,
                          image: pw.DecorationImage(
                              image: image1, fit: pw.BoxFit.cover),
                        ),
                      )),
                      pw.Expanded(
                          child: pw.Container(
                        margin: pw.EdgeInsets.only(
                            top: 21, left: 8, right: 16, bottom: 21),
                        decoration: pw.BoxDecoration(
                          image: pw.DecorationImage(
                              image: image2, fit: pw.BoxFit.cover),
                        ),
                      )),
                      pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Container(
                                margin: pw.EdgeInsets.only(top: 0),
                                padding: pw.EdgeInsets.only(top: 0),
                                height: 8,
                                child: pw.Container(
                                    height: 8,
                                    // width: 8,
                                    child: pw.VerticalDivider(
                                        // width: 8,
                                        thickness: 5,
                                        color: PdfColor.fromHex("808080")))),
                            pw.Container(
                                height: 8,
                                margin: pw.EdgeInsets.only(bottom: 0),
                                padding: pw.EdgeInsets.only(bottom: 0),
                                child: pw.Container(
                                    height: 8,
                                    // width: 8,
                                    child: pw.VerticalDivider(
                                        // width: 8,
                                        thickness: 5,
                                        color: PdfColor.fromHex("808080"))))
                          ]),
                      pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Container(
                                margin: pw.EdgeInsets.only(top: 13),
                                child: pw.Container(
                                    height: 5,
                                    width: 8,
                                    color: PdfColor.fromHex("808080"))),
                            pw.Container(
                                margin: pw.EdgeInsets.only(bottom: 13),
                                child: pw.Container(
                                    height: 5,
                                    width: 8,
                                    color: PdfColor.fromHex("808080")))
                          ])
                    ])),
                pw.Container(
                    margin: pw.EdgeInsets.only(left: 13),
                    height: 8,
                    child: pw.VerticalDivider(
                        // width: 8,
                        thickness: 5,
                        color: PdfColor.fromHex("808080"))),
              ]));
        }));
  }

  void addlayoutid2page(pw.Document pdf, int index1, int index2, int index3,
      int index4, List<Uint8List> images) async {
    print("addlayoutid2page");
    // PdfImageOrientation orientation;
    // double dpi;
    final image1 =
        pw.MemoryImage(images[index1], orientation: orientation, dpi: dpi);
    final image2 =
        pw.MemoryImage(images[index2], orientation: orientation, dpi: dpi);
    final image3 =
        pw.MemoryImage(images[index3], orientation: orientation, dpi: dpi);
    final image4 =
        pw.MemoryImage(images[index4], orientation: orientation, dpi: dpi);

    /*final image2  = await networkImage(_getItems[getItemsindex].imageModel.imageUrl[0]);*/
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat(
            (width * 2) * PdfPageFormat.cm, height * PdfPageFormat.cm,
            marginAll: 0.5 * PdfPageFormat.cm),
        build: (pw.Context contxt) {
          print("image2");
          print(image2.height);

          return pw.Container(
              // height: image1.height.toDouble(),
              // margin: pw.EdgeInsets.fromLTRB(16, 15, 16, 15),
              // padding: pw.EdgeInsets.all(3.0),
              // decoration: pw.BoxDecoration(
              //     // border: pw.Border.all(color: PdfColor.fromHex("53C9CF"),width: 5)
              //     border: pw.Border.all(color: PdfColor.fromHex("000000"),width: 5)
              // ),

              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                pw.Container(
                  margin: pw.EdgeInsets.only(left: 13),
                  height: 8,
                  child: pw.VerticalDivider(
                      // width: 8,
                      thickness: 5,
                      color: PdfColor.fromHex("808080")),
                ),
                pw.Expanded(
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Column(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Container(
                                  margin: pw.EdgeInsets.only(top: 13),
                                  child: pw.Container(
                                      height: 5,
                                      width: 8,
                                      color: PdfColor.fromHex("808080"))),
                              pw.Container(
                                  margin: pw.EdgeInsets.only(bottom: 13),
                                  child: pw.Container(
                                      height: 5,
                                      width: 8,
                                      color: PdfColor.fromHex("808080")))
                            ]),
                        pw.Expanded(
                            child: pw.Container(
                                margin: pw.EdgeInsets.all(8),
                                child: pw.Column(children: [
                                  pw.Expanded(
                                      child: pw.Container(
                                    margin: pw.EdgeInsets.only(bottom: 2),
                                    decoration: pw.BoxDecoration(
                                      image: pw.DecorationImage(
                                          image: image2, fit: pw.BoxFit.cover),
                                    ),
                                  )),
                                  pw.Expanded(
                                    child: pw.Row(
                                      children: [
                                        pw.Expanded(
                                            child: pw.Container(
                                          margin: pw.EdgeInsets.only(
                                              top: 2, right: 2),
                                          decoration: pw.BoxDecoration(
                                            image: pw.DecorationImage(
                                                image: image3,
                                                fit: pw.BoxFit.cover),
                                          ),
                                        )),
                                        pw.Expanded(
                                            child: pw.Container(
                                          margin: pw.EdgeInsets.only(
                                              top: 2, right: 2),
                                          decoration: pw.BoxDecoration(
                                            image: pw.DecorationImage(
                                                image: image4,
                                                fit: pw.BoxFit.cover),
                                          ),
                                        )),
                                      ],
                                    ),
                                  )
                                ]))),
                        pw.Expanded(
                            child: pw.Container(
                          ///margin: pw.EdgeInsets.all(8),
                          decoration: pw.BoxDecoration(
                            image: pw.DecorationImage(
                                image: image1, fit: pw.BoxFit.cover),
                          ),
                        )),
                        pw.Column(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Container(
                                  margin: pw.EdgeInsets.only(top: 0),
                                  padding: pw.EdgeInsets.only(top: 0),
                                  height: 8,
                                  child: pw.Container(
                                      height: 8,
                                      // width: 8,
                                      child: pw.VerticalDivider(
                                          // width: 8,
                                          thickness: 5,
                                          color: PdfColor.fromHex("808080")))),
                              pw.Container(
                                  height: 8,
                                  margin: pw.EdgeInsets.only(bottom: 0),
                                  padding: pw.EdgeInsets.only(bottom: 0),
                                  child: pw.Container(
                                      height: 8,
                                      // width: 8,
                                      child: pw.VerticalDivider(
                                          // width: 8,
                                          thickness: 5,
                                          color: PdfColor.fromHex("808080"))))
                            ]),
                        pw.Column(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Container(
                                  margin: pw.EdgeInsets.only(top: 13),
                                  child: pw.Container(
                                      height: 5,
                                      width: 8,
                                      color: PdfColor.fromHex("808080"))),
                              pw.Container(
                                  margin: pw.EdgeInsets.only(bottom: 13),
                                  child: pw.Container(
                                      height: 5,
                                      width: 8,
                                      color: PdfColor.fromHex("808080")))
                            ])
                      ]),
                ),
                pw.Container(
                    margin: pw.EdgeInsets.only(left: 13),
                    height: 8,
                    child: pw.VerticalDivider(
                        // width: 8,
                        thickness: 5,
                        color: PdfColor.fromHex("808080"))),
              ]));
        }));
  }

  // late PdfImageOrientation orientation;
  // late double dpi;
  void addlayoutid3page(
      pw.Document pdf, int index1, int index2, List<Uint8List> images) async {
    print("index1");
    print(index1);
    print("index2");
    print(index2);
    final image1 =
        pw.MemoryImage(images[index1], orientation: orientation, dpi: dpi);
    final image2 =
        pw.MemoryImage(images[index2], orientation: orientation, dpi: dpi);
    /*final image1  = await downloadImage("https://upload.wikimedia.org/wikipedia/commons/a/a9/Example.jpg");
  final image2  = await downloadImage("https://upload.wikimedia.org/wikipedia/commons/a/a9/Example.jpg");*/
    /*final image2  = await networkImage(_getItems[getItemsindex].imageModel.imageUrl[0]);*/
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat(
            (width * 2) * PdfPageFormat.cm, height * PdfPageFormat.cm,
            marginAll: 0.5 * PdfPageFormat.cm),
        build: (pw.Context contxt) {
          return pw.Container(
              // height: image1.height.toDouble(),
              // margin: pw.EdgeInsets.fromLTRB(16, 15, 16, 15),
              // padding: pw.EdgeInsets.all(3.0),
              // decoration: pw.BoxDecoration(
              //     // border: pw.Border.all(color: PdfColor.fromHex("53C9CF"),width: 5)
              //     border: pw.Border.all(color: PdfColor.fromHex("000000"),width: 5)
              // ),
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                pw.Container(
                  margin: pw.EdgeInsets.only(left: 13),
                  height: 8,
                  child: pw.VerticalDivider(
                      // width: 8,
                      thickness: 5,
                      color: PdfColor.fromHex("808080")),
                ),
                pw.Expanded(
                    child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                      pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Container(
                                margin: pw.EdgeInsets.only(top: 13),
                                child: pw.Container(
                                    height: 5,
                                    width: 8,
                                    color: PdfColor.fromHex("808080"))),
                            pw.Container(
                                margin: pw.EdgeInsets.only(bottom: 13),
                                child: pw.Container(
                                    height: 5,
                                    width: 8,
                                    color: PdfColor.fromHex("808080")))
                          ]),
                      pw.Expanded(
                          child: pw.Container(
                        margin: pw.EdgeInsets.only(
                            top: 21, left: 16, right: 8, bottom: 21),
                        decoration: pw.BoxDecoration(
                          //shape: pw.BoxShape.circle,
                          image: pw.DecorationImage(
                              image: image1, fit: pw.BoxFit.cover),
                        ),
                      )),
                      pw.Expanded(
                          child: pw.Container(
                        margin: pw.EdgeInsets.only(
                            top: 21, left: 8, right: 16, bottom: 21),
                        decoration: pw.BoxDecoration(
                          image: pw.DecorationImage(
                              image: image2, fit: pw.BoxFit.cover),
                        ),
                      )),
                      /*/usr/bin/adb*/
                      pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Container(
                                margin: pw.EdgeInsets.only(top: 0),
                                padding: pw.EdgeInsets.only(top: 0),
                                height: 8,
                                child: pw.Container(
                                    height: 8,
                                    // width: 8,
                                    child: pw.VerticalDivider(
                                        // width: 8,
                                        thickness: 5,
                                        color: PdfColor.fromHex("808080")))),
                            pw.Container(
                                height: 8,
                                margin: pw.EdgeInsets.only(bottom: 0),
                                padding: pw.EdgeInsets.only(bottom: 0),
                                child: pw.Container(
                                    height: 8,
                                    // width: 8,
                                    child: pw.VerticalDivider(
                                        // width: 8,
                                        thickness: 5,
                                        color: PdfColor.fromHex("808080"))))
                          ]),
                      pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Container(
                                margin: pw.EdgeInsets.only(top: 13),
                                child: pw.Container(
                                    height: 5,
                                    width: 8,
                                    color: PdfColor.fromHex("808080"))),
                            pw.Container(
                                margin: pw.EdgeInsets.only(bottom: 13),
                                child: pw.Container(
                                    height: 5,
                                    width: 8,
                                    color: PdfColor.fromHex("808080")))
                          ])
                    ])),
                pw.Container(
                    margin: pw.EdgeInsets.only(left: 13),
                    height: 8,
                    child: pw.VerticalDivider(
                        // width: 8,
                        thickness: 5,
                        color: PdfColor.fromHex("808080"))),
              ]));
        }));
  }

  Future<Uint8List?> convertImageToCropImage() async {
    final ExtendedImageEditorState? state = cropKey.currentState;
    print(state);
    final Rect? rect = state!.getCropRect();
    final EditActionDetails? action = state.editAction;
    final img = state.rawImageData;
    ImageEditorOption option = ImageEditorOption();

    if (action!.needCrop) option.addOption(ClipOption.fromRect(rect!));

    final result = await ImageEditor.editImage(
      image: img,
      imageEditorOption: option,
    );
    return result;
  }

  deacreasePerviewPagePostion() {
    fade_in_out = false;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 250), () {
      if (perview_page_position > 0) {
        perview_page_position = perview_page_position - 1;
      } else {
        perview_page_position = _getItems.length - 1;
      }
      fade_in_out = true;
      print("perview_page_position  -  " + perview_page_position.toString());
      int pagepos = 0;
      if (perview_page_position == 0) {
        previousNumber = _getItems.length * 2;
        currentNumber = (perview_page_position + 1) * 2;
        nextNumber = (perview_page_position + 2) * 2;
      } else if (perview_page_position == _getItems.length - 1) {
        previousNumber = perview_page_position * 2;
        currentNumber = _getItems.length * 2;
        nextNumber = 2;
      } else {
        for (int i = 0; i <= perview_page_position; i++) {
          pagepos = pagepos + 2;
        }
        print("pagepos  -  " + pagepos.toString());
        currentNumber = pagepos;
        previousNumber = pagepos - 2;
        nextNumber = pagepos + 2;
      }

      notifyListeners();
    });
  }

  String imageloadingstate = "";
  checkImageState(String imagestate) {
    imageloadingstate = imagestate;
  }

  String updateimagepath = "";
  String updateimagepathbase64 = "";
  final GlobalKey<ExtendedImageEditorState> cropKey =
      GlobalKey<ExtendedImageEditorState>();
  int previousNumber = 0;
  int perview_page_position = 0;
  int currentNumber = 0;
  late String product_prices;
  late String selectedSizes;
  late String product_names;
  //String categorytype;categoryType
  late List itemList;
  int? creation_id;
  int nextNumber = 0;
  List cartlist = [];
  bool imageupdate = false;
  String type = "";
  Future<void> addItemSS(
      List imageList,
      List itemList,
      productPrice,
      selectedSize,
      productName,
      String slovaktitle,
      String productId,
      String categorytype,
      int minPhoto,
      int maxPhoto,
      int creationId) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    // print("min_photo - " +
    //     minPhoto.toString() +
    //     "- max_photo- " +
    //     maxPhoto.toString() +
    //     " -product_id - " +
    //     productId);
    // print(creationId);

    String userId = prefs.getString(UiData.user_id) ?? "";
    product_prices = productPrice.replaceAll("€", "");
    selectedSizes = selectedSize;
    this.max_photo = maxPhoto;
    this.min_photo = minPhoto;
    this.itemList = itemList;
    this.product_id = productId;
    this.creation_id = creationId;
    print("catethis.categorytypegorytype");
    print(this.categoryType);
    this.categoryType = categorytype;
    this.product_names = productName;
    this.slovaktitle = slovaktitle;
    notifyListeners();
    print("categorytype");
    print(categorytype);
    width = double.parse(selectedSizes.split("x")[0]);
    height = double.parse(selectedSizes.split("x")[1].split("cm")[0]);
    _getItems = imageList;
    previousNumber = _getItems.length * 2;
    currentNumber = (perview_page_position + 1) * 2;
    nextNumber = (perview_page_position + 2) * 2;
/*    dynamic data = {"customer_id": userId};
    String body = json.encode(data);
    var url = Uri.parse('https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/mobile/v1/api/inventory/list/product/to/cart');
    http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    print(body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(json.decode(utf8.decode(response.bodyBytes))["data"]);
      Map<String, dynamic> map =
          json.decode(utf8.decode(response.bodyBytes))["data"];
      if (map != null && map.isNotEmpty) {
        cartlist =
            json.decode(utf8.decode(response.bodyBytes))["data"]["cartItems"];
        print("cartlist - = " + cartlist.length.toString());
      }
    }*/
  }
}

// class PhotoBookCustomModel {
//   String _layout_id;
//   String _categoryType;
//   bool _isSelected;
//   ImageModel _imageModel;
//   PhotoBookCustomModel(this._layout_id, this._isSelected, this._imageModel, this._categoryType);

//   String get layout_id => _layout_id;

//   set layout_id(String value) {
//     _layout_id = value;
//   }

//   bool get isSelected => _isSelected;

//   set isSelected(bool value) {
//     _isSelected = value;
//   }

//   ImageModel get imageModel => _imageModel;

//   set imageModel(ImageModel value) {
//     _imageModel = value;
//   }

//   String get categoryType => _categoryType;

//   set categoryType(String value) {
//     _categoryType = value;
//   }

//    PhotoBookCustomModel.fromJson(Map<String, dynamic> json) {

//      _layout_id =  json["_layout_id"];
//      _imageModel =  json["_imageModel"]!= null ? ImageModel.fromJson(json["_imageModel"]) : null;
//      _categoryType = json["_categoryType"];
//      _isSelected = false;
//      print(_layout_id);
//    }

//   Map<String, dynamic> toJson() {
//     print("1");
//     print("2");
//     return {
//       '_layout_id': layout_id,
//       '_imageModel': imageModel,
//       '_categoryType':categoryType
//     };
//   }
// }

ProductModel imageModelFromJson(String str) {
  final jsonData = json.decode(str);
  return ProductModel.fromMap(jsonData);
}

String ImageModelToJson(ProductModel data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class ProductImageModel {
  String product_category;
  String product_name;
  int image_id;
  Uint8List image;

  ProductImageModel(
      {required this.product_category,
      required this.product_name,
      required this.image_id,
      required this.image});

  factory ProductImageModel.fromMap(Map<String, dynamic> json) =>
      new ProductImageModel(
        product_category: json["product_category"],
        product_name: json["product_name"],
        image_id: json["image_id"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "product_category": product_category,
        "product_name": product_name,
        "image_id": image_id,
        "image": image,
      };
}

class ProductModel {
  int id;
  String categorytype;
  String images;
  String productItem;
  String max_photo;
  String min_photo;
  String product_id;
  String product_price;
  String selectedSize;
  String product_name;
  String slovaktitle;
  String lasteditdate;

  ProductModel(
      {required this.id,
      required this.categorytype,
      required this.images,
      required this.productItem,
      required this.max_photo,
      required this.min_photo,
      required this.product_id,
      required this.product_price,
      required this.selectedSize,
      required this.product_name,
      required this.slovaktitle,
      required this.lasteditdate});

  factory ProductModel.fromMap(Map<String, dynamic> json) => new ProductModel(
        id: json["id"],
        categorytype: json["categorytype"],
        images: json["images"],
        productItem: json["productItem"],
        max_photo: json["max_photo"],
        min_photo: json["min_photo"],
        product_id: json["product_id"],
        product_price: json["product_price"],
        selectedSize: json["selectedSize"],
        product_name: json["product_name"],
        slovaktitle: json["slovaktitle"],
        lasteditdate: json["lasteditdate"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "categorytype": categorytype,
        "images": images,
        "productItem": productItem,
        "max_photo": max_photo,
        "min_photo": min_photo,
        "product_id": product_id,
        "product_price": product_price,
        "selectedSize": selectedSize,
        "product_name": product_name,
        "slovaktitle": slovaktitle,
        "lasteditdate": lasteditdate,
      };
}

class ImageModel {
  late List<Uint8List> uint8list;
  late List<String> uint8listid;
  late List<String> imageType;
  late List<String> imageUrl;
  late List<String> fileuriPath;
  late List<String> base64;
  late List<String> fileuriPathlowreso;
  late List<String> iscroppeds;
  late List<String> aspectRatio;
  late List<String> imageQualityColor;

  ImageModel(
      this.uint8list,
      this.uint8listid,
      this.imageType,
      this.imageUrl,
      this.fileuriPath,
      this.fileuriPathlowreso,
      this.iscroppeds,
      this.aspectRatio,
      this.imageQualityColor,
      this.base64);

  getSplitList(String stringlist) {
    List<String> list1 = [];
    String s1 = stringlist.split("[")[1];
    String s2 = s1.split("]")[0];
    List<String> list = s2.split(",");
    for (int i = 0; i < list.length; i++) {
      String ss = list[i].substring(0, list[i].length - 1);
      String sss = ss.substring(1);
      list1.add(sss);
    }
    return list1;
  }

  getuint8list(String stringlist) {
    List<Uint8List> list1 = [];
    /* String s1 = stringlist.split("[")[1];
    String s2 = s1.split("]")[0];*/
    List<String> list = stringlist.split(",");
    for (int i = 0; i < list.length; i++) {
      list1.add(Uint8List(0));
    }
    return list1;
  }

  ImageModel.fromJson(Map<String, dynamic> json) {
    uint8list = getuint8list(json["uint8list"]);
    uint8listid = getSplitList(json["uint8listid"]);
    imageType = getSplitList(json["imageType"]);
    base64 = getSplitList(json["base64"]);
    imageUrl = getSplitList(json["imageUrl"]);
    imageQualityColor = getSplitList(json["imageQualityColor"]);
    fileuriPath = getSplitList(json["fileuriPath"]);
    fileuriPathlowreso = getSplitList(json["fileuriPathlowreso"]);
    iscroppeds = getSplitList(json["iscroppeds"]);
    aspectRatio = getSplitList(json["aspectRatio"]);
  }

  Map<String, dynamic> toJson() {
    List<Uint8List> ll = [];
    for (int i = 0; i < uint8listid.length; i++) {
      ll.add(Uint8List(0));
    }
    dynamic map = {
      'uint8listid': jsonEncode(uint8listid),
      'uint8list': jsonEncode(ll),
      'imageType': jsonEncode(imageType),
      'base64': jsonEncode(base64),
      'fileuriPath': jsonEncode(fileuriPath),
      'fileuriPathlowreso': jsonEncode(fileuriPathlowreso),
      'imageUrl': jsonEncode(imageUrl),
      'imageQualityColor': jsonEncode(imageQualityColor),
      'iscroppeds': jsonEncode(iscroppeds),
      'aspectRatio': jsonEncode(aspectRatio)
    };
    return map;
  }
}

class ImageTextEditPostion {
  String name;
  double dxOffset;
  double dyOffset;

  ImageTextEditPostion(this.name, this.dxOffset, this.dyOffset);
}

class CustomColor {
  Color color;
  bool isSelected;

  CustomColor(this.color, this.isSelected);
}

class ImageFilterModel {
  String assetImage;
  String name;
  String base64;
  List<double> filter;
  bool isSelected;

  ImageFilterModel(
      this.assetImage, this.name, this.filter, this.isSelected, this.base64);
}

class CustomFontItem {
  String fontspath;
  String fontName;
  CustomFontItem(this.fontspath, this.fontName);
}

class ImageFilterModelUrl {
  String assetImage;
  String imageType;
  String imageUrl;
  String name;
  String base64;
  List<double> filter;
  bool isSelected;
  ImageFilterModelUrl(this.assetImage, this.imageUrl, this.imageType, this.name,
      this.filter, this.isSelected, this.base64);
}

class AspectRatioItem {
  AspectRatioItem({required this.value, required this.text});
  final String text;
  final double value;
}

class AspectRatioWidget extends StatelessWidget {
  const AspectRatioWidget(
      {required this.aspectRatioS,
      required this.aspectRatio,
      this.isSelected = false});
  final String aspectRatioS;
  final double aspectRatio;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100),
      painter: AspectRatioPainter(
          aspectRatio: aspectRatio,
          aspectRatioS: aspectRatioS,
          isSelected: isSelected),
    );
  }
}

class AspectRatioPainter extends CustomPainter {
  AspectRatioPainter(
      {required this.aspectRatioS,
      required this.aspectRatio,
      this.isSelected = false});
  final String aspectRatioS;
  final double aspectRatio;
  final bool isSelected;
  @override
  void paint(Canvas canvas, Size size) {
    final Color color = isSelected ? Colors.blue : Colors.grey;
    final Rect rect = Offset.zero & size;
    //https://github.com/flutter/flutter/issues/49328
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final double aspectRatioResult =
        (aspectRatio != null && aspectRatio > 0.0) ? aspectRatio : 1.0;
    canvas.drawRect(
        getDestinationRect(
            rect: const EdgeInsets.all(10.0).deflateRect(rect),
            inputSize: Size(aspectRatioResult * 100, 100.0),
            fit: BoxFit.contain),
        paint);

    final TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: aspectRatioS,
            style: TextStyle(
              color:
                  color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
              fontSize: 16.0,
            )),
        textDirection: TextDirection.ltr,
        maxLines: 1);
    textPainter.layout(maxWidth: rect.width);

    textPainter.paint(
        canvas,
        rect.center -
            Offset(textPainter.width / 2.0, textPainter.height / 2.0));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate is AspectRatioPainter &&
        (oldDelegate.isSelected != isSelected ||
            oldDelegate.aspectRatioS != aspectRatioS ||
            oldDelegate.aspectRatio != aspectRatio);
  }

  late Offset sliceBorder;
  Rect getDestinationRect({
    Rect? rect,
    Size? inputSize,
    double scale = 1.0,
    BoxFit? fit,
    Alignment alignment = Alignment.center,
    Rect? centerSlice,
    bool flipHorizontally = false,
  }) {
    Size outputSize = rect!.size;

    if (centerSlice != null) {
      sliceBorder = Offset(
          centerSlice.left + inputSize!.width - centerSlice.right,
          centerSlice.top + inputSize.height - centerSlice.bottom);
      outputSize = outputSize - sliceBorder as Size;
      inputSize = inputSize - sliceBorder as Size;
    }
    fit ??= centerSlice == null ? BoxFit.scaleDown : BoxFit.fill;
    assert(centerSlice == null || (fit != BoxFit.none && fit != BoxFit.cover));
    final FittedSizes fittedSizes =
        applyBoxFit(fit, inputSize! / scale, outputSize);
    final Size sourceSize = fittedSizes.source * scale;
    Size destinationSize = fittedSizes.destination;
    if (centerSlice != null) {
      outputSize += sliceBorder;
      destinationSize += sliceBorder;
      // We don't have the ability to draw a subset of the image at the same time
      // as we apply a nine-patch stretch.
      assert(sourceSize == inputSize,
          'centerSlice was used with a BoxFit that does not guarantee that the image is fully visible.');
    }

    final double halfWidthDelta =
        (outputSize.width - destinationSize.width) / 2.0;
    final double halfHeightDelta =
        (outputSize.height - destinationSize.height) / 2.0;
    final double dx = halfWidthDelta +
        (flipHorizontally ? -alignment.x : alignment.x) * halfWidthDelta;
    final double dy = halfHeightDelta + alignment.y * halfHeightDelta;
    final Offset destinationPosition = rect.topLeft.translate(dx, dy);
    final Rect destinationRect = destinationPosition & destinationSize;
    return destinationRect;
  }
}

const NOFILTER = [
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
];
const MILK = [
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.6,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
];
const SEPIUM = [
  1.3,
  -0.3,
  1.1,
  0.0,
  0.0,
  0.0,
  1.3,
  0.2,
  0.0,
  0.0,
  0.0,
  0.0,
  0.8,
  0.2,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
];
const COLDLIFE = [
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  -0.2,
  0.2,
  0.1,
  0.4,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
];
const OLDTIME = [
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  -0.4,
  1.3,
  -0.4,
  0.2,
  -0.1,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
];
const BLACKANDWHITE = [
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  1.0,
  0.0,
];
const CYAN = [
  1.0,
  0.0,
  0.0,
  1.9,
  -2.2,
  0.0,
  1.0,
  0.0,
  0.0,
  0.3,
  0.0,
  0.0,
  1.0,
  0.0,
  0.5,
  0.0,
  0.0,
  0.0,
  1.0,
  0.2,
];
const YELLOW = [
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  -0.2,
  1.0,
  0.3,
  0.1,
  0.0,
  -0.1,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
];
const PURPLE = [
  1.0,
  -0.2,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  -0.1,
  0.0,
  0.0,
  1.2,
  1.0,
  0.1,
  0.0,
  0.0,
  0.0,
  1.7,
  1.0,
  0.0,
];
const SEPIA_MATRIX = [
  0.39,
  0.769,
  0.189,
  0.0,
  0.0,
  0.349,
  0.686,
  0.168,
  0.0,
  0.0,
  0.272,
  0.534,
  0.131,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0
];

const GREYSCALE_MATRIX = [
  0.2126,
  0.7152,
  0.0722,
  0.0,
  0.0,
  0.2126,
  0.7152,
  0.0722,
  0.0,
  0.0,
  0.2126,
  0.7152,
  0.0722,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0
];

const VINTAGE_MATRIX = [
  0.9,
  0.5,
  0.1,
  0.0,
  0.0,
  0.3,
  0.8,
  0.1,
  0.0,
  0.0,
  0.2,
  0.3,
  0.5,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0
];

const SWEET_MATRIX = [
  1.0,
  0.0,
  0.2,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0,
  0.0,
  0.0,
  0.0,
  0.0,
  1.0,
  0.0
];

class CropAspectRatiossss {
  /// no aspect ratio for crop
  static const Null custom = null;

  /// the same as aspect ratio of image
  /// [cropAspectRatio] is not more than 0.0, it's original
  static const double original = 0.0;

  /// ratio of width and height is 1 : 1
  static const double ratio1_1 = 1.0;

  /// ratio of width and height is 3 : 4
  static const double ratio3_4 = 3.0 / 4.0;

  /// ratio of width and height is 4 : 3
  static const double ratio4_3 = 4.0 / 3.0;

  /// ratio of width and height is 9 : 16
  static const double ratio9_16 = 9.0 / 16.0;

  /// ratio of width and height is 16 : 9
  static const double ratio16_9 = 21.0 / 9.0;
}
// make matrix

class MediaMetadata {
  late String creationTime;
  late String width;
  late String height;

  MediaMetadata(
      {required this.creationTime, required this.width, required this.height});

  MediaMetadata.fromJson(Map<String, dynamic> json) {
    creationTime = json['creationTime'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['creationTime'] = this.creationTime;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class GoogleMediaItem {
  late String id;
  late String productUrl;
  late String baseUrl;
  late String mimeType;
  late MediaMetadata mediaMetadata;
  late String filename;

  GoogleMediaItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productUrl = json['productUrl'];
    baseUrl = json['baseUrl'];
    mimeType = json['mimeType'];
    mediaMetadata = (json['mediaMetadata'] != null
        ? new MediaMetadata.fromJson(json['mediaMetadata'])
        : null)!;
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productUrl'] = this.productUrl;
    data['baseUrl'] = this.baseUrl;
    data['mimeType'] = this.mimeType;
    if (this.mediaMetadata != null) {
      data['mediaMetadata'] = this.mediaMetadata.toJson();
    }
    data['filename'] = this.filename;
    return data;
  }

  GoogleMediaItem(
      {required this.id,
      required this.productUrl,
      required this.baseUrl,
      required this.mimeType,
      required this.filename});
}

class ValidationItem {
  final String value;
  final String error;

  ValidationItem(this.value, this.error);
}

class VideoController {
  Future<void> recordVideo(String filePath) async {
    // We need to refresh camera before using it
    // audio channel need to be ready
    CamerawesomePlugin.refresh();

    await CamerawesomePlugin.recordVideo(filePath);
  }

  Future<void> stopRecordingVideo() async {
    await CamerawesomePlugin.stopRecordingVideo();
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
  io.File? img;
  bool imgget = false;

  /// use this to call a take picture
  PictureController _pictureController = PictureController();

  /// use this to record a video
  VideoController _videoController = VideoController();

  /// list of available sizes
  late List<Size> _availableSizes;

  late AnimationController _iconsAnimationController,
      _previewAnimationController;
  late Animation<Offset> _previewAnimation;
  late Timer _previewDismissTimer;
  // StreamSubscription<Uint8List> previewStreamSub;
  late Stream<Uint8List> previewStream;

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
              onResolutionTap: () => _buildChangeResolutionDialog(context),
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
    _lastPhotoPath = filePath;
    setState(() {});
    if (_previewAnimationController.status == AnimationStatus.completed) {
      _previewAnimationController.reset();
    }
    _previewAnimationController.forward();
    print("----------------------------------");
    print("TAKE PHOTO CALLED");
    final file = new io.File(filePath);
    // print("==> hastakePhoto : ${file.exists()} | path : $filePath");
    setState(() {
      img = file;
      imgget = true;
    });
    final imgq = imgUtils.decodeImage(file.readAsBytesSync());
    // print("==> img.width : ${imgq.width} | img.height : ${imgq.height}");

    print("----------------------------------");
  }

  _buildChangeResolutionDialog(context) {
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

  void Function(bool?)? _onPermissionsResult(bool granted) {
    print(granted);
    // if (!granted) {
    //   AlertDialog alert = AlertDialog(
    //     title: Text('Error'),
    //     content: Text(
    //         'It seems you doesn\'t authorized some permissions. Please check on your settings and try again.'),
    //     actions: [
    //       TextButton(
    //         child: Text('OK'),
    //         onPressed: () {
    //           print("close");
    //         },
    //       ),
    //     ],
    //   );

    //   // show the dialog
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return alert;
    //     },
    //   );
    // } else {
    //   setState(() {});
    //   print("granted");
    // }
  }

  Widget buildFullscreenCamera() {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: Center(
        // child: CameraAwesome(
        //   testMode: false,
        //   onPermissionsResult: (bool? result) {},
        //   onOrientationChanged: (CameraOrientations? newOrientation) {},
        //   selectDefaultSize: (List<Size> availableSizes) => Size(1920, 1080),
        //   onCameraStarted: () {},
        //   sensor: _sensor,
        //   photoSize: _photoSize,
        //   switchFlashMode: _switchFlash,
        //   captureMode: _captureMode,
        //   fitted: true,

          child: CameraAwesome(
            onPermissionsResult: (bool? result) {},
            selectDefaultSize: (availableSizes) {
              this._availableSizes = availableSizes;
              return availableSizes[0];
            },
            captureMode: _captureMode,
            photoSize: _photoSize,
            sensor: _sensor,
            enableAudio: _enableAudio,
            switchFlashMode: _switchFlash,
            zoom: _zoomNotifier,
            onCameraStarted: () {
              // camera started here -- do your after start stuff
            },


            // onPermissionsResult: _onPermissionsResult,
            // // selectDefaultSize: (availableSizes) {
            // //   this._availableSizes = availableSizes;
            // //   return availableSizes[0];
            // // },
            // captureMode: _captureMode,
            // photoSize: _photoSize,
            // sensor: _sensor,
            // // enableAudio: _enableAudio,
            // switchFlashMode: _switchFlash,
            // zoom: _zoomNotifier,
            // // onOrientationChanged: (){
            //   // _onOrientationChange
            // // },
            // onCameraStarted: () {
            // },
        ),
      ),
    );
  }



  Widget buildSizedScreenCamera(context) {
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
              onPermissionsResult: (bool? result) {
                print('result');
                print(result);
              },
              onOrientationChanged: (CameraOrientations? newOrientation) {},
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
                      CameraButton(
                        key: ValueKey('cameraButton'),
                        captureMode: captureMode.value,
                        isRecording: isRecording,
                        onTap: () => onCaptureTap.call(),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ],
          ),
        ),
      );
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
                  OptionButton(
                    icon: Icons.switch_camera,
                    rotationController: rotationController,
                    orientation: orientation,
                    onTapCallback: () => onChangeSensorTap.call(),
                  ),
                  SizedBox(width: 20.0),
                  OptionButton(
                    rotationController: rotationController,
                    icon: _getFlashIcon(),
                    orientation: orientation,
                    onTapCallback: () => onFlashTap.call(),
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
  const OptionButton({
    Key? key,
    required this.icon,
    required this.onTapCallback,
    required this.rotationController,
    required this.orientation,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  _OptionButtonState createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton>
    with SingleTickerProviderStateMixin {
  double _angle = 0.0;
  CameraOrientations _oldOrientation = CameraOrientations.PORTRAIT_UP;

  late double newAngle;
  @override
  void initState() {
    newAngle = 0;
    super.initState();

    Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(widget.rotationController)
        .addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _oldOrientation = OrientationUtils.convertRadianToOrientation(_angle)!;
      }
    });

    widget.orientation.addListener(() {
      // _angle =
      // OrientationUtils.convertOrientationToRadian(widget.orientation.value);

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

CameraOrientations? orientation;

class OrientationUtils {
  static CameraOrientations? convertRadianToOrientation(double radians) {
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

  // static
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

  static bool isOnPortraitMode(CameraOrientations orientation) {
    return (orientation == CameraOrientations.PORTRAIT_DOWN ||
        orientation == CameraOrientations.PORTRAIT_UP);
  }
}

class MemotiGalleryCategoryResponse {
  late String status;
  late String message;
  late int code;
  late CategoryObjects data;

  MemotiGalleryCategoryResponse(
      {required this.status,
      required this.message,
      required this.code,
      required this.data});

  MemotiGalleryCategoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    data = (json['data'] != null
        ? new CategoryObjects.fromJson(json['data'])
        : null)!;
  }
}

class CategoryObjects {
  late int count;
  late List<CategoryItem> items;

  CategoryObjects({required this.count, required this.items});

  CategoryObjects.fromJson(Map<String, dynamic> json) {
    count = json['Count'];
    if (json['Items'] != null) {
      items = new List<CategoryItem>.empty(growable: true);
      json['Items'].forEach((v) {
        items.add(new CategoryItem.fromJson(v));
      });
    }
  }
}

class CategoryItem {
  late String ii;
  late String situation;
  late String it;
  late String title;
  late bool is_selected;

  CategoryItem(
      {required this.ii,
      required this.situation,
      required this.it,
      required this.title,
      required this.is_selected});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    ii = json['ii'];
    situation = json['situation'];
    it = json['it'];
    title = json['title'];
    is_selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ii'] = this.ii;
    data['situation'] = this.situation;
    data['it'] = this.it;
    data['title'] = this.title;
    return data;
  }
}

class MemotiGalleryPhotosReponse {
  late String status;
  late String message;
  late int code;
  late PhotoReponseData data;

  MemotiGalleryPhotosReponse(
      {required this.status,
      required this.message,
      required this.code,
      required this.data});

  MemotiGalleryPhotosReponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    data = (json['data'] != null
        ? new PhotoReponseData.fromJson(json['data'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class PhotoReponseData {
  late int count;
  late List<PhotoItem> items;

  PhotoReponseData({required this.count, required this.items});

  PhotoReponseData.fromJson(Map<String, dynamic> json) {
    count = json['Count'];
    if (json['Items'] != null) {
      items = new List<PhotoItem>.empty(growable: true);
      json['Items'].forEach((v) {
        items.add(new PhotoItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Count'] = this.count;
    if (this.items != null) {
      data['Items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PhotoItem {
  late Photos photos;
  late String? ii;
  late String? it;
  late String? parentId;
  late String? categoryId;
  late String? vendorId;

  PhotoItem(
      {required this.photos,
      required this.ii,
      required this.it,
      required this.parentId,
      required this.categoryId});

  PhotoItem.fromJson(Map<String, dynamic> json) {
    photos =
        (json['photos'] != null ? new Photos.fromJson(json['photos']) : null)!;
    ii = json['ii'];
    it = json['it'];
    parentId = json['parent_id'];
    categoryId = json['category_id'];
    vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.photos != null) {
      data['photos'] = this.photos.toJson();
    }
    data['ii'] = this.ii;
    data['it'] = this.it;
    data['parent_id'] = this.parentId;
    data['category_id'] = this.categoryId;
    data['vendor_id'] = this.vendorId;
    return data;
  }
}

class Photos {
  late String title;
  late List<String> photo;

  Photos({required this.title, required this.photo});

  Photos.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    photo = json['photo'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['photo'] = this.photo;
    return data;
  }
}

class ArtistListResponse {
  late String status;
  late int code;
  late List<ArtistItem> data;

  ArtistListResponse(
      {required this.status, required this.code, required this.data});

  ArtistListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    if (json['data'] != null) {
      data = List<ArtistItem>.empty(growable: true);
      json['data'].forEach((v) {
        print(ArtistItem.fromJson(v).toJson());
        data.add(ArtistItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArtistItem {
  late String password;
  late int commissionRate;
  late String situation;
  late String pt;
  late String pi;
  late String email;
  late String title;

  ArtistItem(
      {required this.password,
      required this.commissionRate,
      required this.situation,
      required this.pt,
      required this.pi,
      required this.email,
      required this.title});

  ArtistItem.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    commissionRate = json['commission_rate'];
    situation = json['situation'];
    pt = json['pt'];
    pi = json['pi'];
    email = json['email'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['commission_rate'] = this.commissionRate;
    data['situation'] = this.situation;
    data['pt'] = this.pt;
    data['pi'] = this.pi;
    data['email'] = this.email;
    data['title'] = this.title;
    return data;
  }
}

double _currentScale = 1.0;
double _baseScale = 1.0;
int _pointers = 0;

void _handleScaleStart(ScaleStartDetails details) {
  _baseScale = _currentScale;
}

Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
  // When there are not exactly two fingers on screen don't scale
  var controller;
  if (controller == null || _pointers != 2) {
    return;
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    var controller;
    if (controller == null) {
      return;
    }
  }

  print("messagesss");

  Widget _cameraPreviewWidget() {
    CameraController? controller;
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      print("message");
      return Listener(
        onPointerDown: (_) => _pointers++,
        onPointerUp: (_) => _pointers--,
        child: CameraPreview(
          controller!,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onScaleStart: _handleScaleStart,
                  onScaleUpdate: _handleScaleUpdate,
                  onTapDown: (TapDownDetails details) =>
                      onViewFinderTap(details, constraints),
                );
              }),
        ),
      );
    }
  }
}