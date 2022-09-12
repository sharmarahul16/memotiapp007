import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:memotiapp/pages/products/photobook.dart';
import 'package:memotiapp/pages/products/poster.dart';
import 'package:provider/provider.dart';
import 'package:memotiapp/provider/appaccess.dart';
import 'package:memotiapp/provider/statics.dart';

import 'package:memotiapp/localization/language/languages.dart';
import 'package:memotiapp/localization/locale_constant.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'canvas.dart';

class NewphotoselectionPage extends StatefulWidget {
  String where;
  NewphotoselectionPage(this.where, {Key? key}) : super(key: key);

  @override
  _NewphotoselectionPageState createState() =>
      _NewphotoselectionPageState(where);
}

class _NewphotoselectionPageState extends State<NewphotoselectionPage> {
  late int max_photo;
  late String product_price;
  late String selectedSize;
  late String? where;
  late String product_name;
  late int min_photo;
  late String product_id;
  late String slovaktitle;
  late int count = 0;

  _NewphotoselectionPageState(this.where);
  @override
  void initState() {
    super.initState();
    max_photo = 300;
    min_photo = 1;
    product_price = '';
    selectedSize = '';
    product_name = '';
    product_id = '';
    slovaktitle = '';
    count = 0;
  }

  @override
  void dispose() {
    PaintingBinding.instance!.imageCache!.clear();
    PaintingBinding.instance!.imageCache!.clearLiveImages();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    if (count == 0) {
      print(provider.max_photo);
      print("provider.where");
      print(provider.where);
      provider.where = where!;
      if (!provider.artistApiCall) {
        provider.fetchArtistList();
        provider.fetchInstagrammedia();
      }
      count++;
    }
    return Scaffold(
        appBar: CustomAppBar(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(4, 20, 0, 0),
                color: MyColors.primaryColor,
                height: 105,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                        child: IconButton(
                          icon: Icon(Icons.clear, color: Colors.white),
                          onPressed: () {
                            if (provider.wechatIMages != null) {
                              provider.wechatIMages.clear();
                              provider.listGoogleMediaItem = [];
                              provider.memotiGalleryPhotoList = [];
                              provider.imagess.clear();
                              provider.unselectAll();
                            }
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        // Select photo image
                        Languages.of(context)!.SelectPhoto,
                        // "",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          print("provider.where");
                          print(provider.where);
                          for (var x = 0;
                              x < provider.selectedCategoryImage.length;
                              x++) {
                            // print(provider.selectedCategoryImage[x]["base64"]);
                          }
                          // return;
                          // return;
                          if (!provider.photoProcessingworking) {
                            if (provider.imageCount >= provider.min_photo) {
                              if (provider.imageCount <= provider.max_photo) {
                                List emptyItemList = [];
                                switch (where) {
                                  case "photobook":
                                    {
                                      print("Photobook customization");
                                      print(max_photo);
                                      print(min_photo);
                                      print(selectedSize);
                                      print(product_id);
                                      print(provider.selectedCategoryImage);
                                      print(emptyItemList);
                                      print(where!);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PhotobookCustomizationPage(
                                                    context,
                                                    provider
                                                        .selectedCategoryImage,
                                                    emptyItemList,
                                                    where!,
                                                    max_photo,
                                                    min_photo,
                                                    product_id,
                                                    product_price,
                                                    selectedSize,
                                                    product_name,
                                                    slovaktitle,
                                                    -1)),
                                      );
                                      break;
                                    }
                                  case "calendar":
                                    {
                                      print("Calendar");
                                      switch (product_name.trim()) {
                                        case "Desk":
                                          {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(builder: (context) => CalendarAfterImageSelectionPage(context,provider.selectedCategoryImage, where,max_photo,min_photo,product_id,product_price,selectedSize,product_name,slovaktitle),));
                                            break;
                                          }
                                        case "Poster":
                                          {
                                            print("Poster");
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(builder: (context) => CalendarPosterPreviewPage(-1,"calendar",context,provider.selectedCategoryImage, max_photo,min_photo,product_id,product_price,selectedSize,product_name,slovaktitle)),);
                                            break;
                                          }
                                        case "Wall":
                                          {
                                            print("Wall");
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(builder: (context) => CalendarAfterImageSelectionPage(context,provider.selectedCategoryImage, where,max_photo,min_photo,product_id,product_price,selectedSize,product_name,slovaktitle),));

                                            break;
                                          }
                                        case "Little Moments":
                                          {
                                            print("Little Moments");
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(builder: (context) => CalendarAfterImageSelectionPage(context,provider.selectedCategoryImage, where,max_photo,min_photo,product_id,product_price,selectedSize,product_name,slovaktitle),));

                                            break;
                                          }

                                          print("dd");
                                      }
                                      break;
                                    }
                                  case "canvas":
                                    {
                                      // print("provider.selectedCategoryImage");
                                      // print(provider.selectedCategoryImage);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CanvasSizeSelectionPage(
                                                    provider
                                                        .selectedCategoryImage,
                                                    context,
                                                    -1,
                                                    "canvas")),
                                      );
                                      break;
                                    }

                                  case "poster":
                                    {
                                      print("Poster");
                                      // print(provider.selectedCategoryImage);
                                      print("posterprovider");
                                      provider.gotoposter(provider.contextmain);
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => PosterAfterImageSelectionPage(-1,"poster",context, provider.selectedCategoryImage,max_photo,min_photo,product_id,product_price,selectedSize,product_name,slovaktitle)),);

                                      break;
                                    }
                                  case "canvascustomization":
                                    {
                                      print("Canvas custozization");
                                      // Navigator.pop(context,provider.selectedCategoryImage);
                                      break;
                                    }
                                  case "photobbokcustomization":
                                    {
                                      print("Photobook customization");
                                      // Navigator.pop(context, provider.selectedCategoryImage);
                                      break;
                                    }
                                  case "postercustomization":
                                    {
                                      print("Poster customization");
                                      // Navigator.pop(context0,provider.selectedCategoryImage);
                                      break;
                                    }
                                  default:
                                    {
                                      if (provider.wechatIMages != null) {
                                        provider.wechatIMages.clear();
                                        provider.imagess.clear();
                                        provider.unselectAll();
                                      }
                                      Navigator.pop(context,
                                          provider.selectedCategoryImage);

                                      break;
                                    }
                                }
                              } else {
                                provider.setMaxPhotoImageCheck(context);
                                _showMyDialog(context, provider);
                              }
                            } else {
                              provider.setMiniPhotoImageCheck(context);
                              _showMyDialog(context, provider);
                            }
                          } else {
                            provider.setIMageProcessingDialog(context);
                            _showMyDialog(context, provider);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                // Next page after image selection
                                Languages.of(context)!.Done,
                                // "",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
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
              where == "photobbokcustomization"
                  ? Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                          child: Text(
                            Languages.of(context)!.Selected +
                                "(" +
                                provider.imageCount.toString() +
                                "/" +
                                provider.min_photo.toString() +
                                ")",
                            style: TextStyle(
                                color: MyColors.primaryColor,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  : Container(
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
                                  Languages.of(context)!.UnselectAll,
                                  style: TextStyle(
                                      color: MyColors.primaryColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: Align(
                              alignment: Alignment.center,
                              child: provider.where == "photobook"
                                  ? GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(6.0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: MyColors.textColor,
                                                width: 2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6))),
                                        child: Text(
                                          Languages.of(context)!.AutoSelect,
                                          style: TextStyle(
                                              color: MyColors.textColor,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
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
                                Languages.of(context)!.Selected +
                                    "(" +
                                    // provider.selectedCategoryImage.length.toString()
                                    provider.imageCount.toString() +
                                    "/" +
                                    provider.max_photo.toString() +
                                    ")",
                                style: TextStyle(
                                    color: MyColors.primaryColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ),
        body: Stack(
          children: [
            Visibility(
              visible: provider.currentTabIndex == 0,
              child: Column(
                children: [
                  Expanded(
                    child: provider.buildGridView(context),
                  ),
                ],
              ),
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
              child: FacebookGalleryScreen(context),
              maintainState: true,
              maintainSize: false,
            ),
            Visibility(
              visible: provider.currentTabIndex == 4,
              child: InstaGramGalleryScreen(context, provider),
              maintainState: true,
              maintainSize: false,
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
              icon: SvgPicture.asset(
                  "assets/icon/IconUnselected_PhoneGallery.svg"),
              label: Languages.of(context)!.PhoneGallery,
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                  "assets/icon/IconSelected_MemotiGallery.svg"),
              icon: SvgPicture.asset(
                  "assets/icon/IconUnselected_MemotiGallery.svg"),
              label: Languages.of(context)!.MemotiGallery,
            ),
            BottomNavigationBarItem(
              activeIcon:
                  SvgPicture.asset("assets/icon/IconSelected_GooglePhotos.svg"),
              icon: SvgPicture.asset(
                  "assets/icon/IconUnselected_GooglePhotos.svg"),
              label: Languages.of(context)!.GooglePhoto,
            ),
            BottomNavigationBarItem(
              activeIcon:
                  SvgPicture.asset("assets/icon/IconSelected_Facebook.svg"),
              icon: SvgPicture.asset("assets/icon/IconUnselected_Facebook.svg"),
              label: Languages.of(context)!.Facebook + "\n ",
            ),
            BottomNavigationBarItem(
              activeIcon:
                  SvgPicture.asset("assets/icon/IconSelected_Instagram.svg"),
              icon:
                  SvgPicture.asset("assets/icon/IconUnselected_Instagram.svg"),
              label: Languages.of(context)!.Instagram + "\n ",
            ),
          ],
          currentIndex: provider.currentTabIndex,
          onTap: provider.setTab,
        ));
  }

  Future<void> _showMyDialog(BuildContext context, provider) async {
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
                child: Text(Languages.of(context)!.Ok),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }
}

class CustomAppBar extends PreferredSize {
  late Widget child;
  late double height;

  CustomAppBar({required this.child, this.height = kToolbarHeight})
      : super(child: child, preferredSize: Size.fromHeight(height));

  @override
  Size get preferredSize => Size.fromHeight(height);

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

////////////////
///Memoti Gallery
///////////////

class MemotiGalleryScreen extends StatelessWidget {
  NavigationProvider provider;
  BuildContext context;
  MemotiGalleryScreen(this.provider, this.context);

  @override
  Widget build(BuildContext context) {
    List list = [];
    list = provider.memotiGalleryPhotoList;
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          provider.memoti_gallery_Data_Got
              ? Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
                      color: HexColor("F0F0F2"),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text(
                            Languages.of(context)!.ChooseArtist,
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          items:
                              // provider.artistListResponse.data
                              provider.artistLists.map((e) {
                            return DropdownMenuItem(
                              child: Text(
                                e["title"],
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 14),
                              ),
                              value: e["pi"],
                            );
                          }).toList(),
                          isDense: true,
                          value: provider.selected_artist_id,
                          onChanged: (value) {
                            print(value);
                            // provider.changeArtist(value)
                          },
                          isExpanded: true,
                        ),
                      ),
                    ),
                    Container(
                      height: 240,
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.fromLTRB(14, 14, 14, 14),
                      decoration: BoxDecoration(
                          color: HexColor("F0F0F2"),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 6),
                              child: Text(
                                Languages.of(context)!.SelectCategory,
                                // "",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )),
                          Container(
                            height: 190,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: provider
                                    .memotiGalleryCategoryResponse
                                    .data
                                    .items
                                    .length,
                                itemBuilder: (BuildContext ctx, int index) {
                                  return MemotiGalleryCategoryItem(
                                      provider,
                                      index,
                                      ctx,
                                      provider.memotiGalleryCategoryResponse
                                          .data.items[index]);
                                }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1.0,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black26,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(14, 12, 14, 12),
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 1,
                                    mainAxisSpacing: 1),
                            itemCount: list.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return Container(
                                  child: ScrollItem(
                                      provider, index, context, list[index]));
                            }),
                      ),
                    ),
                  ],
                )
              : Container(),
          provider.memoti_gallery_Data_Got
              ? Container()
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }
}

class MemotiGalleryCategoryItem extends StatelessWidget {
  NavigationProvider provider;
  int index;
  BuildContext context;
  dynamic item;
  MemotiGalleryCategoryItem(
    this.provider,
    this.index,
    this.context,
    this.item,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        provider.chanageMemotiGalleryCategory(index);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(6, 16, 6, 0),
        width: 150,
        child: Column(
          children: [
            Container(
              height: 130,
              child: Image.asset(
                "assets/images/economy_photobook.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Container(
                height: 44,
                color: item.is_selected ? MyColors.primaryColor : Colors.white,
                child: Center(
                    child: Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: item.is_selected ? Colors.white : Colors.black87,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                )))
          ],
        ),
      ),
    );
  }
}

class ScrollItem extends StatelessWidget {
  NavigationProvider provider;
  int index;
  BuildContext context;
  dynamic item;

  ScrollItem(this.provider, this.index, this.context, this.item);

  @override
  Widget build(BuildContext context) {
    // print("item.isSelected");
    // print(item["url_image"]);
    bool isSelected = item["isSelected"];
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
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

    return InkWell(
      onTap: () {
        // print(index);
        // return;
        if (provider.checkImageAddedorNot(item, index, context) ||
            provider.imageCount > provider.max_photo) {
          // debugPrint(item.isSelected.toString());
          // print("if");
        } else {
          // print("else");
          provider.getTotalImageCount();
          _showMyDialog();
        }
        ;
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 40) * 0.5,
        child: Stack(
          children: [
            Container(
              child: CachedNetworkImage(
                imageUrl: item["url_image"],
                fit: BoxFit.cover,
                width: 200,
                height: 200,
                placeholder: (context, url) => Center(
                    child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 50,
                  height: 50,
                )),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            isSelected
                ? Container(
                    color: Colors.black.withOpacity(0.1),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.check_circle_outline,
                            color: MyColors.primaryColor,
                          )),
                    ),
                  )
                : Container(
                    //color: Colors.black.withOpacity(0.5),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 1.0, color: Colors.black),
                            ),
                          )),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
////////////////////
///Instagram Gallery
////////////////////

class InstaGramGalleryScreen extends StatefulWidget {
  static const route = '/instagramgallery';
  BuildContext contextmain;
  NavigationProvider provider;
  InstaGramGalleryScreen(this.contextmain, this.provider);
  @override
  _InstaGramGalleryScreenState createState() =>
      _InstaGramGalleryScreenState(contextmain, provider);
}

class _InstaGramGalleryScreenState extends State<InstaGramGalleryScreen> {
  BuildContext contextmain;
  NavigationProvider provider;
  _InstaGramGalleryScreenState(this.contextmain, this.provider);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
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

    return provider.instamediaList.length > 0
        ? Container(
            child: GridView.builder(
                itemCount: provider.instamediaList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    /*childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 2),*/
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1),
                itemBuilder: (context, index) {
                  //InstaMedia media = provider.instamediaList[index];
                  var media = provider.instamediaList[index];
                  return InkWell(
                    onTap: () {
                      print("IInstagram");
                      if (provider.checkImageAddedorNot(
                          media, index, context)) {
                        // debugPrint(item.isSelected.toString());
                      } else {
                        _showMyDialog();
                      }
                      ;
                    },
                    child: Container(
                        width: (MediaQuery.of(context).size.width - 40) * 0.5,
                        child: Stack(
                          children: [
                            Container(
                                padding: EdgeInsets.all(0.0),
                                /*child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: '${item.url_image}=w300-h280-c',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (BinstamediaListuildContext context, String url, Object error) {
                  print(error);
                  return const Icon(Icons.error);
                },
              ),*/
                                child: CachedNetworkImage(
                                  imageUrl: media["url_image"],
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                  placeholder: (context, url) => Center(
                                      child: SizedBox(
                                    child: CircularProgressIndicator(),
                                    width: 50,
                                    height: 50,
                                  )),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )),
                            media["isSelected"]
                                ? Container(
                                    color: Colors.black.withOpacity(0.1),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.check_circle_outline,
                                            color: MyColors.primaryColor,
                                          )),
                                    ),
                                  )
                                : Container(
                                    //color: Colors.black.withOpacity(0.5),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: Colors.black),
                                            ),
                                          )),
                                    ),
                                  )
                          ],
                        )),
                  );
                  //            return index==provider.listGoogleMediaItem.length?Container():GooglePhotoItem( provider, index, context, provider.listGoogleMediaItem[index+1] );
                }),
          )
        : Container(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  provider.printDetails("lnegi52", provider);
                },
                child: Container(
                  width: 170,
                  height: 50,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                          width: 2,
                          color: (Colors.purple[100])!,
                          style: BorderStyle.solid)),
                  child: Center(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                            "assets/icon/IconSelected_Instagram.svg"),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          Languages.of(contextmain)!.Instagram,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.purple[100]),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

///////////////
///Google Gallery
///////////////

class GoogleGalleryScreen extends StatelessWidget {
  NavigationProvider provider;
  BuildContext context;

  GoogleGalleryScreen(this.provider, this.context);

  @override
  Widget build(BuildContext context) {
    return provider.isGoogleLoggedIn
        ? provider.isGooglemediaitemGet
            ? provider.isgoogleempty
                ? Container(
                    color: Colors.white,
                    child: Center(
                      child: RaisedButton(
                        shape: StadiumBorder(),
                        child: Text(
                          Languages.of(context)!
                              .Thereisnoimagesinyourgooglephoto,
                          style: TextStyle(color: Colors.black45, fontSize: 20),
                        ),
                        color: Colors.redAccent,
                        onPressed: () {
                          provider.googleSignIn();
                        },
                      ),
                    ),
                  )
                :
                // Text("Test")
                Container(
                    child: GridView.builder(
                        controller: provider.googlePhotocontroller,
                        itemCount: provider.listGoogleMediaItem.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            /*childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 2),*/
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1),
                        itemBuilder: (context, index) {
                          return GooglePhotoItem(provider, index, context,
                              provider.listGoogleMediaItem[index]);
                          //            return index==provider.listGoogleMediaItem.length?Container():GooglePhotoItem( provider, index, context, provider.listGoogleMediaItem[index+1] );
                        }),
                  )
            : Center(
                child:
                    // Text(provider.isGooglemediaitemGet.toString()+" "+provider.isGoogleLoggedIn.toString())
                    CircularProgressIndicator(),
              )
        : Container(
            color: Colors.white,
            child: Center(
              child: RaisedButton(
                shape: StadiumBorder(),
                child: Text(
                  Languages.of(context)!.GoogleSignin,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.redAccent,
                onPressed: () {
                  provider.googleSignIn();
                },
              ),
            ),
          );
  }
}

class GooglePhotoItem extends StatelessWidget {
  NavigationProvider provider;
  int index;
  BuildContext context;
  dynamic item;

  GooglePhotoItem(this.provider, this.index, this.context, this.item);

  @override
  Widget build(BuildContext context) {
    bool isSelected = item["isSelected"];
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
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

    return InkWell(
      onTap: () {
        print(index);
        if (provider.checkImageAddedorNot(item, index, context)) {
          // debugPrint(item.isSelected.toString());
        } else {
          _showMyDialog();
        }
        ;
      },
      child: Container(
          width: (MediaQuery.of(context).size.width - 40) * 0.5,
          child: Stack(
            children: [
              Container(
                  padding: EdgeInsets.all(0.0),
                  /*child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: '${item.url_image}=w300-h280-c',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (BuildContext context, String url, Object error) {
                  print(error);
                  return const Icon(Icons.error);
                },
              ),*/
                  child: CachedNetworkImage(
                    imageUrl: item["url_image"],
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                    placeholder: (context, url) => Center(
                        child: SizedBox(
                      child: CircularProgressIndicator(),
                      width: 50,
                      height: 50,
                    )),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )),
              isSelected
                  ? Container(
                      color: Colors.black.withOpacity(0.1),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.check_circle_outline,
                              color: MyColors.primaryColor,
                            )),
                      ),
                    )
                  : Container(
                      //color: Colors.black.withOpacity(0.5),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 1.0, color: Colors.black),
                              ),
                            )),
                      ),
                    )
            ],
          )),
    );
  }
}

class FacebookGalleryScreen extends StatefulWidget {
  BuildContext contextmain;
  FacebookGalleryScreen(this.contextmain);
  @override
  _FacebookGalleryScreenState createState() =>
      _FacebookGalleryScreenState(contextmain);
}

class _FacebookGalleryScreenState extends State<FacebookGalleryScreen> {
  BuildContext contextmain;
  _FacebookGalleryScreenState(this.contextmain);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    return Container(
      child: Center(
        child: InkWell(
          child: Container(
            width: 170,
            height: 55,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                    width: 2, color: Colors.blue, style: BorderStyle.solid)),
            child: Center(
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.facebook,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    // "",
                    // Fetch Images
                    Languages.of(contextmain)!.Facebook,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          onTap: () {
            // FB login
            provider.fetchAlbums();
          },
        ),
      ),
    );
  }
}

class InstagramAPIWebView extends StatelessWidget {
  final Function onPressedConfirmation;

  const InstagramAPIWebView(NavigationProvider provider,
      {Key? key, required this.onPressedConfirmation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // // INIT THE INSTAGRAM CLASS
    // final Instagram instagram = Instagram();
    // // INIT THE WEBVIEW
    // final flutterWebviewPlugin = new FlutterWebviewPlugin();
    // // OPEN WEBVIEW ACCORDING TO URL GIVEN
    // flutterWebviewPlugin.launch(Instagram.url);
    // // LISTEN CHANGES
    // flutterWebviewPlugin.onUrlChanged.listen((String url) async {
    //   // IF SUCCESS LOGIN
    //   if (url.contains(Instagram.redirectUri)) {
    //     instagram.getAuthorizationCode(url);
    //     instagram.getTokenAndUserID().then((isDone) {
    //       if (isDone) {
    //         instagram.getUserProfile().then((isDone) {
    //           flutterWebviewPlugin.close();
    //           Navigator.of(context).pop(isDone);
    //           /*instagram.getAllMedias().then((mds) {
    //             instagram.medias = mds;
    //             // NOW WE CAN CLOSE THE WEBVIEW
    //             flutterWebviewPlugin.close();
    //             Navigator.of(context).pop(instagram.medias);
    //             // WE PUSH A NEW ROUTE FOR SELECTING OUR MEDIAS
    //             */ /*Navigator.of(context)
    //                 .push(MaterialPageRoute(builder: (BuildContext ctx) {
    //               // ADDING OUR SELECTION PAGE
    //               return InstagramSelectionPage(
    //                 medias: medias,
    //                 onPressedConfirmation: () {
    //                   // RETURNING AFTER SELECTION OUR MEDIAS LIST
    //                   Navigator.of(ctx).pop();
    //                   Navigator.of(context).pop(medias);
    //                 },
    //               );
    //             }));/*
    //           */});*/
    //         });
    //       }
    //     });
    //   }
    // });

    // return WebviewScaffold(
    //   resizeToAvoidBottomInset: true,
    //   url: Instagram.url,
    //   appBar: AppBar(
    //     leading: IconButton(
    //         icon: Icon(Icons.arrow_back, color: Colors.white),
    //         onPressed: () {
    //           Navigator.of(context).pop();
    //         }),
    //     centerTitle: true,
    //     title: Text("Instagram media login"),
    //     elevation: 5,
    //     iconTheme: IconThemeData(color: Colors.white),
    //   ),
    // );
    return Container();
  }
}
