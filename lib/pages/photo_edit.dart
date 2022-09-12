import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_editor/image_editor.dart';
import 'package:memotiapp/localization/language/languages.dart';
import 'package:memotiapp/pages/products/newphotoselection.dart';
import 'package:memotiapp/pages/products/poster.dart';
import 'package:memotiapp/provider/appaccess.dart';
import 'package:memotiapp/provider/statics.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

class PhotoEdit extends StatefulWidget {
  BuildContext contextmain;
  PhotoEdit(this.contextmain);
  @override
  _PhotoEditState createState() => _PhotoEditState(this.contextmain);
}

class _PhotoEditState extends State<PhotoEdit> {
  BuildContext contextmain;
  final GlobalKey _globalKey = GlobalKey();
  final GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey<ExtendedImageEditorState>();
  _PhotoEditState(this.contextmain);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    return Scaffold(
      // appBar: withoutAppBar(context, provider),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child:withoutAppBar(context, provider)),
      body: Stack(
        children: [
          case2(
            provider.istextFormattingnew,
            {
              0: Container(),
              2: imageFilterWidget(contextmain,provider, context),
              1: textFormatingWidget(contextmain,provider, context),
              3: chooseImage(contextmain,provider, context),
            },
            Container(),
          )
        ],
      ),
    );
  }
  Widget withoutAppBar(BuildContext context, NavigationProvider provider) {
    return AppBar(
      backgroundColor: Colors.black.withOpacity(0.8),
      leading: provider.istextFormattingnew == 3?Container():
      IconButton(
        padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
        // Close edit image 
        icon: Icon(Icons.clear, color: Colors.white70),
        onPressed: () async {
          provider.closedImageFilternew();
          Navigator.pop(context,null);
          provider.closedtextformattingnew(context);
          // print(provider.istextFormattingnew);
          // if(provider.istextFormattingnew==2) {
          //   provider.closedImageFilternew();
          //   Navigator.pop(context,null );
          // }else if(provider.istextFormattingnew==1){
          //   provider.closedtextformattingnew(context);
          // }
        },
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: provider.istextFormattingnew == 3?Container():InkWell(
        onTap: () async {
          print(provider.istextFormattingnew);
          print(provider.selectedimageFilterTabindexnew);
          if(provider.istextFormattingnew==1){
            provider.closedtextformattingnew(context);
          }else{
            if(provider.selectedimageFilterTabindexnew==0) {
              await convertImageToCropImage(provider,context);
              provider.closedImageFilternew();
            }else if(provider.selectedimageFilterTabindexnew==1){
              convertWidgetToImage(provider,context);
              provider.closedImageFilternew();
            }
          }
        },
        child: Container(
          child: Text(
            // Edit done
            Languages.of(contextmain)!.Done,
            // "",
            style:TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      actions: provider.istextFormattingnew==1?<Widget>[
        Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: SizedBox(
                width: 100.0,
                child:IconButton(
                  icon: Text( Languages.of(contextmain)!.Remove, 
                  style: TextStyle(color: Colors.white, fontSize: 15),),
                  onPressed: ()  {
                    provider.removeIMage();
                    },
                ))),
      ]:null,
    );
  }
  Widget imageFilterWidget(
      BuildContext contextmain,
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
                SizedBox(
                  height: 16,
                ),
                imageFilterFirstWidget(provider, context),
                imageSecondWidget(contextmain,provider, context),
                SizedBox(
                  height: 20,
                ),
                case2(
                  provider.selectedimageFilterTabindexnew,
                  {
                    0: imagerotateThirdWidget(contextmain,provider, context, editorKey),
                    1: case2(provider.selcted_image_typenew, {
                      "memoti":imageFilterThirdWidgetUrl(contextmain,provider, context),
                      "facebook":imageFilterThirdWidgetUrl(contextmain,provider, context),
                      "instagram":imageFilterThirdWidgetUrl(contextmain,provider, context),
                      "google":imageFilterThirdWidgetUrl(contextmain,provider, context),
                    },  imageFilterThirdWidget(contextmain,provider, context)),
                    2: Container(), //imageFilterThirdWidget(provider, context),
                  },
                  imagerotateThirdWidget(contextmain,provider, context, editorKey),
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
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: case2(
              provider.selectedimageFilterTabindexnew,
              {
                0: provider.selcted_image_typenew != null
                    ? Center(
                  child: ExtendedImage.memory(
                    base64Decode(provider.selcted_image_base64new),
                    cacheRawData: true,
                    clearMemoryCacheWhenDispose: true,
                    shape: provider.isLayoutCirclenew?BoxShape.circle:BoxShape.rectangle,
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.width-40,
                    width: MediaQuery.of(context).size.width,
                    mode: ExtendedImageMode.editor,
                    enableLoadState: true,
                    extendedImageEditorKey: editorKey,
                    initEditorConfigHandler: (state) {
                        return EditorConfig(
                          maxScale: 8.0,
                          hitTestSize: 20.0,
                          initCropRectType: InitCropRectType.layoutRect,
                          cropAspectRatio: provider.width / provider.height);
                    },
                    // initEditorConfigHandler: (ExtendedImageState state) {
                    //   return EditorConfig(
                    //       maxScale: 8.0,
                    //       hitTestSize: 20.0,
                    //       initCropRectType: InitCropRectType.layoutRect,
                    //       cropAspectRatio: provider.width / provider.height);
                    // },
                  ),
                )
                : Container(),
                1: Center(
                  child: Container(
                    child: RepaintBoundary(
                      key: _globalKey,
                      child: Container(
                        height: MediaQuery.of(context).size.width-40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          shape: provider.isLayoutCirclenew?BoxShape.circle:BoxShape.rectangle,
                        ),
                        child: ColorFiltered(
                          colorFilter:
                          ColorFilter.matrix(provider.selected_filternew),
                          child: provider.seletedImageurinew == null
                              ? Image.asset(
                            "assets/images/economy_photobook.jpg",
                            fit: provider.isLayoutCirclenew?BoxFit.cover:BoxFit.cover,
                          )
                              : Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:  Image.memory(base64Decode(provider.selcted_image_base64new)).image
                                )
                            ),
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
          child:IconButton(
            padding: EdgeInsets.all(16),
            icon: Icon(
              Icons.warning,
              color: HexColor(provider.imageQulaityColornew),
              size: 20,
            ),
            onPressed: () {
              provider.showWarningofImageQuality(contextmain,context);
            },
          ),
        ),
      ],
    );
  }

  Widget imageSecondWidget(contextmain,
      NavigationProvider provider, BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 36, 20, 0),
      padding: EdgeInsets.only(top: 12, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => provider.changeImageFilterSelectedTabColornew(0),
              child: Center(
                child: Container(
                  child: Column(
                    children: [
                      Icon(
                        Icons.refresh,
                        color: case2(
                            provider.selectedimageFilterTabindexnew,
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
                                  provider.selectedimageFilterTabindexnew,
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
              onTap: () => provider.changeImageFilterSelectedTabColornew(1),
              child: Center(
                child: Container(
                  child: Column(
                    children: [
                      Icon(
                        Icons.brush,
                        color: case2(
                            provider.selectedimageFilterTabindexnew,
                            {
                              1: MyColors.primaryColor,
                            },
                            Colors.grey[300]),
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          // "",
                          Languages.of(contextmain)!.Filters,
                          style: TextStyle(
                              color: case2(
                                  provider.selectedimageFilterTabindexnew,
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
                gotoPhotoSelectionPage( contextmain, context, provider, 1, 1, false );
              },
              child: Center(
                child: Container(
                  child: Column(
                    children: [
                      Icon(
                        Icons.loop,
                        color: case2(
                            provider.selectedimageFilterTabindexnew,
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
                          // "",
                          style: TextStyle(
                              color: case2(
                                  provider.selectedimageFilterTabindexnew,
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
                if(provider.whichImageShownew=="original"){
                  convertImagewhengointToText(provider);
                 }
                provider.changeImageFilterSelectedTabColornew(3);
              },
              child: Center(
                child: Container(
                  child: Column(
                    children: [
                      Icon(
                        Icons.text_format,
                        color: case2(
                            provider.selectedimageFilterTabindexnew,
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
                                  provider.selectedimageFilterTabindexnew,
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

  Widget imagerotateThirdWidget(BuildContext contextmain,NavigationProvider provider,
      BuildContext context, GlobalKey<ExtendedImageEditorState> editorKey) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: IconButton(
              icon: Icon(Icons.rotate_left_outlined, color: Colors.white, size: 40,),
              onPressed: () {
                editorKey.currentState!.rotate(right: false);
              },
            ),
          ),
          Center(
            child: IconButton(
              icon: Icon(Icons.flip_camera_android_outlined, color: Colors.white, size: 40,),
              onPressed: () {
                editorKey.currentState!.flip();
              },
            ),
          ),
          Center(
            child: IconButton(
              icon: Icon(Icons.rotate_right_outlined, color: Colors.white, size: 40,),
              onPressed: () {
                editorKey.currentState!.flip();
                editorKey.currentState!.rotate(right: true);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget imageFilterThirdWidget(
      BuildContext contextmain,
      NavigationProvider provider, BuildContext context) {
    List<ImageFilterModel> list = provider.filterList;
    List<ImageFilterModelUrl> listUrl = provider.filterListUrl;
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      height: 100,
      child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext ctx, int index) {
            return FilterItemList(provider, index, context, list[index], 'phone',
                list[index].name, list[index].isSelected, list[index].filter);
          }),
    );
  }

  Widget imageFilterThirdWidgetUrl(
      BuildContext contextmain,
      NavigationProvider provider, BuildContext context) {
    List<ImageFilterModelUrl> listUrl = provider.filterListUrl;
    return listUrl.isNotEmpty
        ? Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                  listUrl[index].imageType,
                  listUrl[index].name,
                  listUrl[index].isSelected,
                  listUrl[index].filter,
                  listUrl[index].base64);
              // return Container();
            }))
        : Container();
  }

  Widget textFormatingWidget(
      BuildContext contextmain,
      NavigationProvider provider, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        color: Colors.black.withOpacity(0.8),
        child: SingleChildScrollView(
          child: Container(
            width: size.width-40,
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 
                RepaintBoundary(
                      key: provider.editglobalKey,
                      child: 
                  Container(
                    child: Stack(
                      children: [
                        Container(
                          child: MeasureSize(
                            onChange: (childsize){
                              provider.imagesize = childsize;
                              print("childsize");
                              print(childsize);
                            },
                            child: 
                            Container(
                              height: MediaQuery.of(context).size.width-40,
                              width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:  Image.memory(base64Decode(provider.selcted_image_base64new)).image
                                )
                            ),
                          )
                          ),
                        ),
                        DragBox1(provider,contextmain),
                      ],
                    ),
                  ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                testingTopWidget(contextmain,provider, context),
                SizedBox(
                  height: 12,
                ),
                provider.selectedtextFormatTabindex==0?
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container(
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
                      ),),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(child: Container(
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
                      ),),
                    ],
                  ),
                ):Container(),
                SizedBox(
                  height: 12,
                ),
                provider.selectedtextFormatTabindex==0?Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.25-15,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                        ),
                        child: Text("Width: ")
                      ),
                      Container(
                        // margin: EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width*0.75-25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                        ),
                        child:
                        Slider(
                          min: provider.lowerValue,
                          max: provider.upperValue,
                          value: provider.dragboxwidth.toDouble(),
                          activeColor: MyColors.textColor,
                          inactiveColor: Colors.grey,
                          label: 'Set volume value',
                          onChanged: (value) {
                            provider.changedragwidth(value);
                          },
                        ),
                      )
                    ],
                  ),
                ): Container(),
                provider.selectedtextFormatTabindex==0?SizedBox(
                  height: 24,
                ): Container(),
                case2(
                  provider.selectedtextFormatTabindex,
                  {
                    0: Container(),
                    // secondWidget(contextmain,provider, context),
                    1: secondColorWidget(provider, context),
                    2: thirdColorWidget(provider, context)
                  },
                      Container(),
                  // secondWidget(contextmain,provider, context),
                ),
                SizedBox(
                  height: 24,
                ),
                // thirdWidget(contextmain,provider, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget testingTopWidget(
      BuildContext contextmain,
      NavigationProvider provider, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: InkWell(
                onTap: () => {
                    provider.changeTextFormatSelectedTabColor(0)
                  },
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
                        padding: const EdgeInsets.only(top: 8.0),
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
              child: InkWell(
                onTap: () => {
                    provider.changeTextFormatSelectedTabColor(1)
                  },
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
                        padding: const EdgeInsets.only(top: 8.0),
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
              child: InkWell(
                onTap: () => {
                    provider.changeTextFormatSelectedTabColor(2)
                  },
                child: Container(
                  child: Column(
                    children: [
                      Image.asset(case2(
                          provider.selectedtextFormatTabindex,
                          {
                            2: "assets/icon/BGColor_Select.png",
                          },
                          "assets/icon/BGColor_Unselect.png"),fit: BoxFit.contain,height: 30,width: 30,),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          Languages.of(contextmain)!.BgColor,
                          // "",
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

  Widget thirdWidget(
      BuildContext contextmain,
      NavigationProvider provider, BuildContext context) {
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


  Widget secondColorWidget(NavigationProvider provider,
      BuildContext context) {
    print("colortList");
       return Container(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: provider.colortList.length,
          itemBuilder: (BuildContext ctx, int index) {
            print("colortList");
            print(provider.colortList[index]);
            return  TextColorItem(provider, index, ctx, provider.colortList[index]);
          }),
    );
  }

  Widget thirdColorWidget(NavigationProvider provider,
      BuildContext context) {
    print("colortList");
       return Container(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: provider.bgcolortList.length,
          itemBuilder: (BuildContext ctx, int index) {
            print("colortList");
            print(provider.colortList[index]);
            return BGColorItem(provider, index, ctx, provider.bgcolortList[index]);
          }),
    );
  }

  Widget secondWidget(
      BuildContext contextmain,
      NavigationProvider provider, BuildContext context) {
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

  Widget chooseImage(BuildContext contextmain,
      NavigationProvider provider, BuildContext context){

    return Positioned(top: 0.0,
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
                    onTap: (){
                      provider.setImageSelectionnew("original");
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
                                child:
                                // MemoryImage(base64Decode(provider.selcted_image_base64new))
                                provider.selcted_image_typenew=="phone"? Image.file(
                                  new File(provider.seletedImageurinew),fit: BoxFit.cover,
                                ):provider.selcted_image_typenew=="google"?CachedNetworkImage(imageUrl: provider.selcted_image_urlnew+"=w400-h400-c",fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(child: SizedBox(child: CircularProgressIndicator(),width: 50,height: 50,)),
                                  errorWidget: (context, url, error) => Icon(Icons.error),)
                                    :CachedNetworkImage(imageUrl:
                                provider.selcted_image_urlnew,fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(child: SizedBox(child: CircularProgressIndicator(),width: 50,height: 50,)),
                                  errorWidget: (context, url, error) => Icon(Icons.error),),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 20,
                              right: MediaQuery.of(context).size.width*.37,
                              child: Center(child: Container(
                                  padding: EdgeInsets.all(8),
                                  color: Colors.grey.withOpacity(0.5),
                                  child: Text("Original",style: TextStyle(color: Colors.white),)),))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      provider.setImageSelectionnew("crop");
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
                                child:provider.seletedImagebase64==null?Container():
                                ExtendedImage.memory(
                                base64Decode(provider.seletedImagebase64)),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 20,
                              right: MediaQuery.of(context).size.width*.37,
                              child: Center(child: Container(
                                  padding: EdgeInsets.all(8),
                                  color: Colors.grey.withOpacity(0.5),
                                  child: Text("Crop one",style: TextStyle(color: Colors.white),)),))
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

  convertImagewhengointToText(NavigationProvider provider) async {
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

    provider.isoriginaltextEditIMagenew =true;
    provider.originaltextEditIMagenew = result!;
  }
  void convertWidgetToImage(NavigationProvider provider, BuildContext context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    print("currentFocus.hasPrimaryFocus");
    print(currentFocus.hasPrimaryFocus);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    RenderRepaintBoundary? repaintBoundary =
    _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image boxImage = await repaintBoundary.toImage(pixelRatio:3.0);
    ByteData? byteData =
    await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8list = byteData!.buffer.asUint8List();
    Navigator.pop(context,uint8list);
  }
  Future<void> convertImageToCropImage(
      NavigationProvider provider, BuildContext context) async {
    final ExtendedImageEditorState? state = editorKey.currentState;
    print('state');
    print(state);
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
    print('image_editor time : $diff');
    Navigator.pop(context,result);
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
            builder: (context) => NewPhotoSelction(contextmain, minPhoto,
                maxPhoto, "", "", "", "", "", "photobookcustomization")),);
    if (result != null) {
      imageList = result;
      if (layout) {
        provider.addImage(imageList);
      } else {
        if (imageList.length == 1) {
          provider.replaceImage(imageList[0]);
        } else{
          provider.addIMages(imageList);
        }
      }
    }
  }
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
  void dispose() {
    PaintingBinding.instance!.imageCache!.clear();
    PaintingBinding.instance!.imageCache!.clearLiveImages();
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = select;
    return Stack(children: [
      GestureDetector(
        onTap: () => provider.changeFilternew(index),
        child: Container(
          margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Column(
            children: [
              Container(
                height: 80,
                width: 100,

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
                      child: Image.memory(
                        // File(model.assetImage),
                        base64Decode(model.base64),
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
  late String base64;

  FilterItemListUrl(this.provider, this.index, this.context, this.modelUrl,
      this.imageUrl, this.imageType, this.name, this.select, this.filter, this.base64);

  @override
  void dispose() {
    PaintingBinding.instance!.imageCache!.clear();
    PaintingBinding.instance!.imageCache!.clearLiveImages();
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = select;
    return Stack(children: [
      InkWell(
        onTap: () => provider.changeFilterUrlnew(index),
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
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: MemoryImage(base64Decode(base64)),fit: BoxFit.cover,)
                        )),
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
  void dispose() {
    PaintingBinding.instance!.imageCache!.clear();
    PaintingBinding.instance!.imageCache!.clearLiveImages();
  }

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
  void dispose() {
    PaintingBinding.instance!.imageCache!.clear();
    PaintingBinding.instance!.imageCache!.clearLiveImages();
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = customColor.isSelected;
    Color itemColor = customColor.color;
    return InkWell(
      onTap: () => {
          provider.changeBGColor(index)
        },
      child: Container(
        margin: EdgeInsets.all(8),
        height: 30,
        width: 35,
        decoration: BoxDecoration(
          color: itemColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 2,
            color: isSelected ? MyColors.primaryColor : Colors.white24,
          ),
        ),
      ),
    );
  }
}

class DragBox extends StatefulWidget {
  final Offset initPos;
  final NavigationProvider provider;

  DragBox(this.initPos,this.provider);

  @override
  DragBoxState createState() => DragBoxState();
}

class DragBoxState extends State<DragBox> {
  Offset position = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: Draggable(
          child: Container(
            width: 100.0,
            height: 100.0,
            child: Center(
              child: TextFormField(
                controller: widget.provider.textEditingController,
                style: TextStyle(
                    fontSize: widget.provider.selectedFontSizeindex.toDouble(),
                    color: widget.provider.currenttextColor,
                    fontFamily: widget.provider.selectFontKey),
                decoration: InputDecoration(
                  hintText: Languages.of(widget.provider.contextmain)!.Enteryourmessage,
                ),
                scrollPadding: EdgeInsets.all(20.0),
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                autofocus: true,
              ),
            ),
          ),
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              print("offset");
              print(offset);
              position = offset;
            });
          },
          feedback: Container(
            width: 120.0,
            height: 120.0,
            child: Center(
              child: Text(
                "widget.label",
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ));
  }
}

class DragBox1 extends StatefulWidget {
  final NavigationProvider provider;
  final BuildContext contextmain;

  DragBox1(this.provider, this.contextmain);

  @override
  DragBox1State createState() => DragBox1State();
}

class DragBox1State extends State<DragBox1> {
  Offset offset = Offset.zero;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double x = 0.0;
    double y = 0.0;
    if(offset.dx<0.1){
      x = 0.1;
      // widget.provider.dragboxwidth = widget.provider.imagesize.width-offset.dx;
      if(widget.provider.dragboxwidth>widget.provider.imagesize.width){
        // widget.provider.dragboxwidth = widget.provider.imagesize.width-40;
      }
    }else if(offset.dx>widget.provider.imagesize.width-50){
      x  = size.width-80;
      // widget.provider.dragboxwidth = 50;
    }else{
      // widget.provider.dragboxwidth = widget.provider.imagesize.width-(offset.dx-20);
      x = offset.dx;
    }

    if(offset.dy<0.1){
      y = 0.1;
    }else if(offset.dy>widget.provider.imagesize.height-40){
      y  = widget.provider.imagesize.height-40;
    }else{
      y = offset.dy;
    }
    widget.provider.textPostion = Offset(x,y);

    return Positioned(
        left: offset.dx,
        top: offset.dy,
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              offset = Offset(offset.dx + details.delta.dx, offset.dy + details.delta.dy);
            });
          },
          child: Container(
            width: widget.provider.dragboxwidth,
            // height: widget.provider.dragboxheight,
            padding: EdgeInsets.fromLTRB(15, 10, 10, 15),
            color: widget.provider.currentBGColor,
            child: TextFormField(
              controller: widget.provider.textEditingController,
              style: TextStyle(
                  fontSize: widget.provider.selectedFontSizeindex.toDouble(),
                  color: widget.provider.currenttextColor,
                  fontFamily: widget.provider.selectFontKey),
              decoration: InputDecoration(
                hintText: Languages.of(widget.contextmain)!.Enteryourmessage,
                fillColor: Colors.black26,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              autofocus: true,
            ),
          ),
        ));
  }
}
