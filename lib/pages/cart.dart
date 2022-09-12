import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:memotiapp/pages/tabs.dart';
import 'package:provider/provider.dart';
import 'package:memotiapp/provider/appaccess.dart';
import 'package:memotiapp/provider/statics.dart';
import 'package:memotiapp/localization/language/languages.dart';
import 'package:memotiapp/localization/locale_constant.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {


  @override
  void dispose() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
    super.dispose();
  }

  int count  = 0;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    if (count==0) {
      count++;
      provider.getAllLocalCartproduct();
    }
    else{
      // provider.calledcart = true;
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            Languages
                .of(context)!
                .Cart,
            style:TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
        body: Stack(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  provider.apierror?
                  Container(
                    height: MediaQuery.of(context).size.height-200,width: MediaQuery.of(context).size.width,
                    child: Center(child: Column(
                      children: [
                        Text(Languages
                            .of(context)!
                            .SomeThingwentwrong,style: TextStyle(color: MyColors.primaryColor,fontSize: 20,fontWeight: FontWeight.bold),),
                        SizedBox(width: 20),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                              side: BorderSide(color: MyColors.primaryColor)),
                          onPressed: () {
                            provider.getAllLocalCartproduct();
                          },
                          color: Colors.white,
                          textColor: MyColors.primaryColor,
                          child: Text(Languages
                              .of(context)!
                              .Tryagain,
                              style: TextStyle(fontSize: 14)),
                        ),
                      ],
                    ),),
                  )
                      :provider.empty == false
                      ? provider.localCartList.length>0
                      ? Expanded(child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: provider.localCartList.length,
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
                                        provider.localCartList != null && provider.localCartList.length > 0 && 
                                        provider.localCartList[index]["base64"]!= null
                                        // provider.localCartList[index]["images"] != null && 
                                        // json.decode(provider.localCartList[index]["images"])["mainImageList"] != "" && json.decode(provider.localCartList[0]["images"])["mainImageList"].length > 0 && json.decode(provider.localCartList[index]["images"])["mainImageList"][0] != null && json.decode(provider.localCartList[index]["images"])["mainImageList"][0]["base64"] != null 
                                        ?Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.all(12),
                                          // width: MediaQuery.of(context).size.width,
                                          // height: MediaQuery.of(context).size.height,
                                          width: MediaQuery.of(context).size.width*0.33,
                                          height: 115,
                                          decoration: BoxDecoration(
                                            color: HexColor("F5F5F6"),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: MemoryImage(base64Decode(provider.localCartList[index]["base64"].toString()))
                                            ),
                                          ),
                                          // child: Text(provider.localCartList[index]["images"]),
                                        ):Container(
                                            margin: EdgeInsets.all(12),
                                            height: 115,
                                            width: MediaQuery.of(context).size.width*0.33, child: Center(child: Text("No image"),)) ,
                                      ],
                                    ),
                                    provider.localCartList != null && provider.localCartList.length > 0?
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // '',
                                            // json.decode(provider.localCartList[index]["images"])["mainImageList"].toString(),
                                            langcode=="en"||langcode=="en_"?provider.localCartList[index]["product_name"].toString():provider.localCartList[index]["slovaktitle"].toString(),
                                            // '${(index + 1) % 2 == 0 ? "Canvas" : "PhotoBook"}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 16.0,
                                                color: Colors.black),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child:provider.localCartList[index]["product_price"]!=null? Text(
                                                (double.parse(provider.localCartList[index]["product_price"]).truncateToDouble()*int.parse(provider.localCartList[index]["count"])).toStringAsFixed(2).replaceAll("€", "")+' \u{20AC}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.0,
                                                    color: MyColors.primaryColor),
                                              ):Container(),
                                          ),
                                          Row(children: [
                                            GestureDetector(
                                              onTap: (){
                                                provider.changeCount(provider.localCartList[index]["count"].toString(),false,index);
                                              },
                                              child: Container(
                                                  width: 25,
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.only(top: 10),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: HexColor("4E4E4E"),
                                                          width: 2,
                                                          style: BorderStyle.solid),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(100))),
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 16.0,
                                                        color: Colors.grey),
                                                  )),
                                            ),
                                            Container(
                                                width: 25,
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.only(top: 10, left: 20),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: MyColors.primaryColor,
                                                        width: 2,
                                                        style: BorderStyle.solid),
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(5))),
                                                child: Text(
                                                  provider.localCartList[index]["count"].toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14.0,
                                                      color: MyColors.primaryColor),
                                                )),
                                            GestureDetector(
                                              onTap: (){
                                                provider.changeCount(
                                                    provider.localCartList[index]["count"].toString(),true,index);

                                              },
                                              child: Container(
                                                  width: 25,
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.only(top: 10, left: 20),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: HexColor("4E4E4E"),
                                                          width: 2,
                                                          style: BorderStyle.solid),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(100))),
                                                  child: Text(
                                                    '+',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 15.0,
                                                        color: Colors.grey),
                                                  )),
                                            ),
                                          ]),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  provider.goCUstomizationPage(context,context,index);
                                                },
                                                child: Container(
                                                  width: 75,
                                                  margin: EdgeInsets.only(top: 15),
                                                  padding: EdgeInsets.only(
                                                      left: 4, right: 4, top: 5, bottom: 5),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: MyColors.primaryColor,
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(20)),
                                                  ),
                                                  child: Text(
                                                    // "",
                                                    Languages.of(context)!.Edit,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 13.0,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: (){
                                                  provider.deleteLocalCartItem(index,provider.localCartList[index]["id"]);
                                                  //provider.deleteItem(index);0
                                                },
                                                child: Container(
                                                  width: 80,
                                                  margin: EdgeInsets.only(top: 15,right: 8,left: 10),
                                                  padding: EdgeInsets.only(
                                                      left: 4, right: 4, top: 5, bottom: 5),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: MyColors.primaryColor,
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(20)),
                                                  ),
                                                  child: Text(
                                                    Languages
                                                        .of(context)!
                                                        .Delete,
                                                    // '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 13.0,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ):Container(),
                                  ],
                                )));
                      })) : Container(child: CircularProgressIndicator(),)
                      : Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.8,
                          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * .15,
                              0, MediaQuery.of(context).size.width * .15, 0),
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
                                        .ThereisnothingincartPleaseaddbyclickonbelowbutton,
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
                                InkWell(
                                  onTap: (){
                                    provider.changeTabpagePosition(0);
                                    // Navigator.push( context, MaterialPageRoute(builder: (context) => TabsPage(/*contextmain,2,""*/)));
                                    provider.changeTabpagePosition(0);
                                    Navigator.pushAndRemoveUntil<dynamic>(
                                      context,
                                      MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) => TabsPage(),
                                      ),
                                          (route) => false,//if you want to disable back feature set to false
                                    );
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      width: MediaQuery.of(context).size.width * 0.9,
                                      alignment: Alignment.center,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 2.0, color: Colors.black),
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                      child: Text( Languages
                                          .of(context)!
                                          .AddMoreProducts,
                                          style: TextStyle(
                                              color: HexColor("282828"),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.0))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  provider.empty == false?provider.localCartList.length>0 ?Container(

                    margin: EdgeInsets.only(bottom: 10),
                    child: Card(
                        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Languages
                                      .of(context)!
                                      .Total,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0,

                                      color: MyColors.primaryColor),
                                ),
                                provider.localCartList.length>0 ? Text(
                                  provider.totalprice+' \u{20AC}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0,
                                      color: MyColors.primaryColor),
                                ) : Text(""),
                              ],
                            ))),
                  ):Container():Container(),
                  // provider.empty == false?provider.cartList.length>0 ?
                  provider.empty == false?provider.localCartList.length>0 ?InkWell(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
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
                                fontSize: 16.0))),
                    onTap: () {
                      //provider.changeTabpagePosition(0);
                      //Navigator.push( context, MaterialPageRoute(builder: (context) => TabsPage(/*contextmain,2,""*/)));
                      provider.changeTabpagePosition(0);
                      Navigator.pushAndRemoveUntil<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => TabsPage(),
                        ),
                            (route) => false,//if you want to disable back feature set to false
                      );
                      /* Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TabsPage()));*/
                    },
                  ):Container():Container(),
                  // provider.empty == false?provider.cartList.length>0 ?
                  provider.empty == false?provider.localCartList.length>0 ?InkWell(
                    child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 40,
                        decoration: BoxDecoration(
                          color: MyColors.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(
                          Languages
                              .of(context)!
                              .Checkout,
                          // '',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0),
                        )),
                    onTap: () {
                      provider.checkaddress(context,context, provider.totalprice);
                    },
                  ):Container():Container(),
                ],
              ),
            ),
            // provider.imageprocessing?
            // Center(
            // child: CircularProgressIndicator(),
            // ):Container(),
          ],
        )
    );
  }
}
