
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memotiapp/pages/products/newphotoselection.dart';
import 'package:memotiapp/pages/products/photobook.dart';
import 'package:memotiapp/pages/products/poster.dart';
import 'package:memotiapp/pages/tabs.dart';
import 'package:provider/provider.dart';
import 'package:memotiapp/provider/appaccess.dart';
import 'package:memotiapp/provider/statics.dart';

import 'package:memotiapp/localization/language/languages.dart';
import 'package:memotiapp/localization/locale_constant.dart';

class CreationsPage extends StatefulWidget {
  CreationsPage({Key? key}) : super(key: key);

  @override
  _CreationsPageState createState() => _CreationsPageState();
}

class _CreationsPageState extends State<CreationsPage> {

  int count  = 0;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    Size size = MediaQuery
        .of(context)
        .size;
    if (count==0) {
      count++;
      print("creationt start --- ");
      provider.getAllCreationproduct();
      print('provider.busy');
      print(provider.busy);
    }
    else{
      // provider.calledcart = true;
    }
    List list = provider.creationList;
    final ListView mylist = ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.all(12),
                              width: size.width * 0.3,
                              height: 110,
                              child: Image.memory(base64Decode(json.decode(list[index]["images"])["mainImageList"][0]["base64"]))
                            // child: json.decode(list[index]["images"])["mainImageList"][0]["base64"] != null ?
                            // Image.memory(base64Decode(json.decode(list[index]["images"])["mainImageList"][0]["base64"]))
                            //    : Container()
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  getLocal() == 'en_' || getLocal() == 'en'
                                      ? list[index]["product_name"]
                                      : list[index]["slovaktitle"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                      color: Colors.black),
                                )),
                            Container(
                                margin: EdgeInsets.only(top: 16),
                                child: Text(
                                  DateFormat("yyyy-MM-dd").format(
                                      DateFormat("yyyy-MM-dd").parse(
                                          list[index]["lasteditdate"])),
                                  //'Last edit: July ${(index + 1)}, 2020 1${index + 2}:40pm',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0,
                                      color: Colors.grey),
                                )),
                            Row(
                              children: [
                                Flexible(
                                  child:InkWell(
                                    onTap: () {
                                      provider.deleteCreation(list[index]["id"]);
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(top: 16),
                                        width: 90,
                                        padding: EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 5,
                                            bottom: 5),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            border: Border.all(
                                                color: HexColor("4E4E4E"),
                                                width: 1,
                                                style: BorderStyle.solid)),
                                        child: Text(
                                          Languages
                                              .of(provider.context)!
                                              .delete,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13.0,
                                              color: HexColor("4E4E4E")),
                                        )),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    provider.setCartIndex(null);
                                    provider.gocreationCUstomizationPage(context,context,index,"creations");
                                  },
                                  child: Container(
                                      width: 90,
                                      margin: EdgeInsets.only(
                                          left: 10, top: 16),
                                      padding: EdgeInsets.only(
                                          left: 6, right: 6, top: 5, bottom: 5),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: MyColors.primaryColor,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                      ),
                                      child: Text(
                                        // Continue
                                        Languages
                                            .of(provider.context)!
                                            .Continue,
                                        // "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13.0,
                                            color: Colors.white),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )));
        });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        centerTitle: true,
        title: Text(
          Languages
              .of(context)!
              .Creations,
          style:TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: provider.busy
          ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
          : provider.creationList.length>0
          ? mylist
          : getNoDataView(context, provider),
    );
  }


  Widget getNoDataView(BuildContext context, provider) {
    return Container(
//width: MediaQuery.of(context).size.width,
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      color: Colors.white,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery
              .of(context)
              .size
              .width * 0.8,
          margin: EdgeInsets.fromLTRB(MediaQuery
              .of(context)
              .size
              .width * .15,
              0, MediaQuery
                  .of(context)
                  .size
                  .width * .15, 0),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Wrap(
              children: [
                Center(
                  child: Icon(
                    Icons.face,
                    color: MyColors.primaryColor,
                    size: 80,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    Languages
                        .of(context)!
                        .ThereisnothingincreationPleaseaddbyclickonbelowbutton,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: MyColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                GestureDetector(
                  onTap: () {
                    provider.changeTabpagePosition(0);
                    Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => TabsPage(),
                      ),
                          (route) => false,//if you want to disable back feature set to false
                    );
                    /*
                    Navigator.push( context, MaterialPageRoute(builder: (context) => TabsPage(*//*contextmain,2,""*//*)));*/
                  },
                  child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9,
                      alignment: Alignment.center,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: Colors.black),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Text(Languages
                          .of(context)!
                          .AddMoreProducts,
                          style: TextStyle(
                              color: HexColor("282828"),
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0))),
/* onTap: () {
Navigator.pushNamed(context, UiData.loginRoute,
arguments: ScreenNameArguments("cart"));
},*/
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreationSingleProductList extends StatefulWidget {
  @override
  _CreationSingleProductListState createState() => _CreationSingleProductListState();
}

class _CreationSingleProductListState extends State<CreationSingleProductList> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    Size size = MediaQuery.of(context).size;
    List list = provider.creationsingleprojectList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          Languages
              .of(context)!
              .ProjectList,
          style:TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(list);

                    print(list[index]["product_name"]);
                    print(list[index]["slovaktitle"]);
                    return Card(
                        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.all(12),
                                      width: size.width * 0.3,

                                      height: 110,
                                      decoration: BoxDecoration(
                                        color: HexColor("F5F5F6"),
                                        // image: DecorationImage(
                                        //   fit: BoxFit.contain,
                                        //   image: json.decode(list[index]["images"])["mainImageList"][0]["isCropped"].toString()=="true"
                                        //       ?FileImage(File(json.decode(list[index]["images"])["mainImageList"][0]["lowresofileuriPath"].toString()))
                                        //       :json.decode(list[index]["images"])["mainImageList"][0]["image_type"].toString() == "phone"
                                        //       ? FileImage(File(json.decode(list[index]["images"])["mainImageList"][0]["fileuriPath"].toString()))
                                        //       :CachedNetworkImageProvider(
                                        //     json.decode(list[index]["images"])["mainImageList"][0]["image_type"].toString() == "memoti"
                                        //         ? json.decode(list[index]["images"])["mainImageList"][0]["url_image"].toString()
                                        //         : json.decode(list[index]["images"])["mainImageList"][0]["url_image"].toString() +"=w400-h400-c",
                                        //   ),


                                        //   //image:FileImage(File(json.decode(provider.localCartList[index]["images"])["mainImageList"][0]["lowresofileuriPath"].toString()))/*json.decode(list[index].images)['mainImageList'][0]["_isCropped"] == "true" ? FileImage(File(json.decode(list[index].images)['mainImageList'][0]["_lowresofileuriPath"])) : json.decode(list[index].images)['mainImageList'][0]["_image_type"] == "phone" ? FileImage(File(json.decode(list[index].images)['mainImageList'][0]["_fileuriPath"]),)

                                        // ),
                                        // child: Container()
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      /*Container(
                                      child: Stack(
                                        children: [
                                          Text(
                                            list[index].product_id.length>20?'ID: '+list[index].product_id.substring(0,20):'ID: '+list[index].product_id,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.0,
                                                color: HexColor("53C9CF")),
                                          ),
                                          Text(
                                            list[index].product_id.length>20?'ID: '+list[index].product_id.substring(0,20):'ID: '+list[index].product_id,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              backgroundColor: Colors.redAccent,
                                                fontSize: 12.0,
                                                color:Colors.redAccent),
                                          ),
                                        ],
                                      ),
                                    ),*/

                                      Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Text(
                                            getLocal() == 'en_' || getLocal() == 'en'
                                                ? list[index]["product_name"]
                                                : list[index]["slovaktitle"],
                                            //'${(index + 1) % 3 == 0 ? "PhotoBook" : (index + 1) % 2 == 0 ? "Canvas" : "Calendar"}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.0,
                                                color: Colors.black),
                                          )),
                                      Container(
                                          margin: EdgeInsets.only(top: 16),
                                          child: Text(
                                            DateFormat("yyyy-MM-dd").format(
                                                DateFormat("yyyy-MM-dd").parse(
                                                    list[index]["lasteditdate"])),
                                            //'Last edit: July ${(index + 1)}, 2020 1${index + 2}:40pm',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.0,
                                                color: Colors.grey),
                                          )),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              provider.deleteSingleProjectCreation(index);
                                            },
                                            child: Container(
                                                margin: EdgeInsets.only(top: 16),
                                                width: 90,
                                                padding: EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    top: 5,
                                                    bottom: 5),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(20)),
                                                    border: Border.all(
                                                        color: HexColor("4E4E4E"),
                                                        width: 1,
                                                        style: BorderStyle.solid)),
                                                child: Text(
                                                  Languages
                                                      .of(provider.context)!
                                                      .delete,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 13.0,
                                                      color: HexColor("4E4E4E")),
                                                )),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              provider.setCartIndex(null);
                                              provider.gocreationCUstomizationPage(context,context,index,"singleprojectList");
                                            },
                                            child: Container(
                                                width: 90,
                                                margin: EdgeInsets.only(
                                                    left: 10, top: 16),
                                                padding: EdgeInsets.only(
                                                    left: 6, right: 6, top: 5, bottom: 5),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: MyColors.primaryColor,
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(20)),
                                                ),
                                                child: Text(
                                                  Languages
                                                      .of(provider.context)!
                                                      .Continue,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 13.0,
                                                      color: Colors.white),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )));
                  }),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 16.0),
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width*1.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: MyColors.primaryColor,
                  onPressed: () {
                    print("provider.where");
                    print(provider.where);
                    print(provider.categoryType);
                    if(provider.where=="canvas"){
                      provider.artistApiCall = false;
                      provider.isGooglemediaitemGet = false;
                      if(provider.isGoogleLoggedIn){
                        provider.listmediaItem("");
                      }
                      //provider.googleSignIn();
                      provider.setTab(0);
                      provider.fromcanvasdetail = true;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewphotoselectionPage("canvas")),);
                    }else if(provider.where=="poster"){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PosterSizeSelectionPage(
                                    provider.product, context)),
                      );
                    }else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PhotoBookSizeSelectionPage()),);
                    }
                    /*    print(provider.where);
                    provider.artistApiCall = false;
                    provider.isGooglemediaitemGet = false;
                    provider.setTab(0);
                    provider.googleSignIn();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewphotoselectionPage("photobook")),);*/
                  },
                  child: Text(Languages.of(context)!.CreateNow,
                      style: TextStyle(
                          color: Colors.white, fontSize: 22)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
