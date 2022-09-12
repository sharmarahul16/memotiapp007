import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:memotiapp/localization/language/languages.dart';
import 'package:memotiapp/localization/locale_constant.dart';
import 'package:memotiapp/provider/appaccess.dart';
import 'package:memotiapp/provider/statics.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';

class OrderHistoryPage extends StatefulWidget {
  BuildContext contextmain;
  OrderHistoryPage(this.contextmain);

  // @override
  // Widget build(BuildContext context) {

  //   return InnerOrderHistoryPage(contextmain);
  // }
  @override
  InnerOrderHistoryPage createState() => InnerOrderHistoryPage(contextmain);
}

class InnerOrderHistoryPage extends State<OrderHistoryPage>{
  BuildContext contextmain;
  InnerOrderHistoryPage(this.contextmain);
    int count = 0;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    PaintingBinding.instance!.imageCache!.clear();
    PaintingBinding.instance!.imageCache!.clearLiveImages();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  /*  double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;*/
    final provider = Provider.of<NavigationProvider>(context);

    if(count == 0){
      count++;
      provider.addorderItem();

    }
    return Scaffold(
      backgroundColor: HexColor("#F0F0F2"),
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(Languages.of(contextmain)!.OrderHistory,
        style:TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 26.0,

                ),
              )
          ),
        ],
      ),
      body: Container(
        child: provider.iswating?Center(child: CircularProgressIndicator(),):
        provider.soethingWentWrong?somethingWentScreen(contextmain,context,provider):
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 16),
              padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
              color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Languages.of(contextmain)!.Last3months,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          wordSpacing: 1.5
                      ),
                    ),

                    Row(
                      children: [
                        Text(
                        Languages.of(contextmain)!.FilterOrders,
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColors.primaryColor,
                              wordSpacing: 1.5
                          ),
                        ),
                        Icon(
                          Icons.label_important,
                          color: MyColors.primaryColor,
                        ),
                      ],
                    ),
                  ],
                )
            ),
            provider.isOrderListEmpty?Expanded(
              child: Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Languages.of(contextmain)!.NOorderItems,
                style: TextStyle(fontSize: 16,),),
              ),),
            ):Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                  itemCount: provider.orders.length,
                  itemBuilder: (BuildContext context, int index){
                  return OrderHistoryItem(contextmain,
                      provider, index, context, provider.orders[index]
                  );
                  }),
            ),
          ],
        ),
      ),
    );
  }
  Widget somethingWentScreen(BuildContext contextmain,BuildContext context, provider,){
    return Container(
      height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,
      child: Center(child: Column(
        children: [
          Text(Languages.of(contextmain)!.SomeThingwentwrong,
          style: TextStyle(color: MyColors.primaryColor,fontSize: 20,fontWeight: FontWeight.w600),),
          SizedBox(width: 20),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                side: BorderSide(color: MyColors.primaryColor)),
            onPressed: () {
              provider.addorderItem();
            },
            color: Colors.white,
            textColor: MyColors.primaryColor,
            child: Text(Languages.of(contextmain)!.Tryagain.toUpperCase(),
                style: TextStyle(fontSize: 14)),
          ),
        ],
      ),),
    );
  }

  Widget getNoDataView(BuildContext contextmain , BuildContext context) {
    return Container(
//width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white38,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.8,
          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * .15,
              0, MediaQuery.of(context).size.width * .15, 0),
          child: Card(
            color: Colors.white,
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
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      Languages.of(contextmain)!.Thereisnothinginorderlist,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: MyColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          alignment: Alignment.center,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2.0, color: Colors.black),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text(Languages.of(contextmain)!.AddMoreProducts,
                              style: TextStyle(
                                  color: HexColor("282828"),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0))),
/* onTap: () {
Navigator.pushNamed(context, UiData.loginRoute,
arguments: ScreenNameArguments("cart"));
},*/
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class PDFScreen extends StatelessWidget {
  final GlobalKey<State<StatefulWidget>> shareWidget = GlobalKey();
  var appState;
  String pathPDF = "";
  // PDFDocument? document;
  PDFScreen(this.pathPDF);
  @override
  Widget build(BuildContext context) {
    print(pathPDF);
    return Scaffold(
    appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
      // title: Text( pathName ),
    ),
      body: SfPdfViewer.network(
      pathPDF, 
      scrollDirection: PdfScrollDirection.horizontal,
      enableDoubleTapZooming: false,
      canShowScrollHead: false,
      canShowScrollStatus: false
      )
    );
  }
}


class PdfPage extends StatefulWidget {  

  String pdf_url;
  PdfPage(this.pdf_url);

 @override
  _PdfPageState createState() =>
      _PdfPageState(pdf_url);
}

class _PdfPageState
    extends State<PdfPage> {
  String? pdf_url;
  // PDFDocument? document;
  _PdfPageState(pdf_url);

    @override
    void initState() {
      super.initState();
    }

  @override
  void dispose() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(pdf_url);
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF'),
      ),
      body: 
      // PDFViewer(
      //     document: document!,
      //   )
      SfPdfViewer.network(
        pdf_url!,
      ),
    );
  }
}
bool _isLoading = false;
class OrderHistoryItem extends StatelessWidget {
  final provider;
  int index;
  BuildContext context;
  BuildContext contextmain;
  dynamic order;
  OrderHistoryItem(this.contextmain,this.provider, this.index, this.context, this.order);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Card(
      elevation: 6,
      shadowColor: Colors.black38,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Container(
        width: _width,
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: order["openingpdf"] ? Container(height:40, width: 20,child:Center(child:CircularProgressIndicator())): Container(
                height: 120,
                color: HexColor("#F5F5F7"),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: 
                  InkWell(child: Image.asset("assets/images/pdf.png"), 
                onTap: () async {
                  print('Open PDF');
                  print(order["pdf_url"]);
                  // return ;
                  // PDFDocument documents = await PDFDocument.fromURL(
                  //     order["pdf_url"],
                  //   );
                  //   print(jsonEncode(documents));
                  //   if(documents!=null){
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => 
                  //         PDFScreen(documents)
                  //       ),);
                  //   }
                  // provider.createFileOfPdfUrl(order["pdf_url"], index, "outer").then((f) {
                    // createdpathPDF = f.path;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => 
                      // PDFScreen( f.path)
                        PDFScreen(order["pdf_url"])
                      ),);
                  // });
                }, )
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 0),
                      child: Text(
                        langcode == "en" || langcode == "en_" ? order["title"] : order["slovaktitles"],
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 16,
                            letterSpacing: 1.2,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            wordSpacing: 1.5
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        order["price"],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: MyColors.primaryColor,
                            wordSpacing: 1.5,
                          letterSpacing: 1.3
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Container(
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: MyColors.primaryColor,
                                onPressed: () {
                                  for(int i = 0;i<provider.ordersData.length;i++){
                                    if(provider.ordersData[i]["ii"].toString()==order["ii"]){
                                      print("eeee");
                                      print(i);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => OrderSummeryPage(contextmain,provider.ordersData[i])),);
                                      break;
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Text(Languages.of(contextmain)!.ViewOrders,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //statusWidget(context,order.status),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statusWidget(BuildContext context, String status){
    HexColor? color;
    Icon? icon;
    switch(status){
      case "Delievered":
        color = HexColor("#1FBA35");
        icon = Icon(Icons.check,color: Colors.white,size: 16,);
        break;
      case "Canceled":
        color = HexColor("#F13C3B");
        icon = Icon(Icons.clear,color: Colors.white,size: 16,);
        break;
      case "Shipped":
        color = HexColor("#1B73E7");
        icon = Icon(Icons.local_shipping,color: Colors.white,size: 16,);
        break;
      case "":
        color = HexColor("#1FBA35");
        icon = Icon(Icons.check,color: Colors.white,size: 16,);
        break;
    }
    return Column(
      children: [
        Text(
          order["status"],
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
              wordSpacing: 1.1
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
            ),

            padding: EdgeInsets.all(6),
            child: Center(
              child: icon,
            ),
          ),
        ),
      ],
    );
  }
}



class OrderSummeryPage extends StatelessWidget {
  var orderDataitem;
  BuildContext contextmain;
  OrderSummeryPage(this.contextmain,this.orderDataitem);

  @override
  Widget build(BuildContext context) {
    return InnerOrderSummeryPage(contextmain,orderDataitem);
  }
}

class InnerOrderSummeryPage extends StatelessWidget {
  var orderDataitem;
  BuildContext contextmain;
  InnerOrderSummeryPage(this.contextmain,this.orderDataitem);
  int count = 0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    if(count==0){
      count++;
      provider.setDataorder(orderDataitem);
    }


    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(Languages.of(contextmain)!.OrderSummary,
        style:TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
      ),
      body: provider.orderDataitem!=null?Container(
        height: _height,
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.only(top: 16),
                elevation: 6,
                shadowColor: Colors.black38,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                  ),
                  child: Column(
                    children: [
                        Container(
                        decoration: BoxDecoration(
                          color: HexColor("#CDCED3"),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(12, 22, 12, 12),
                        width: _width,
                        child: Text(
                            Languages.of(contextmain)!.PriceSummary,
                            // "",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              wordSpacing: 1.5,
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          decoration: BoxDecoration(
                            color: HexColor("#F5F5F7"),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Languages.of(contextmain)!.Numberofitems,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    wordSpacing: 1.5
                                ),
                              ),
                              Text(
                                provider.itemList.length.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    wordSpacing: 1.5
                                ),
                              ),
                            ],
                          )
                      ),
                      Container(
                        height: 250,
                        child:ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: provider.itemList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      bottom: BorderSide(
                                        color: HexColor("#F0F0F2"),
                                        width: 0.80,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(right: 8),
                                        child: Row(
                                          children: [
                                                provider.itemList[index]["openingpdf"]!=null && provider.itemList[index]["openingpdf"]==true ? Container(child: Center(child: CircularProgressIndicator())):InkWell(child: Image.asset("assets/images/pdf.png", fit: BoxFit.cover,
                                              width: 50,
                                              height: 50), 
                                              onTap: () {

                                                // provider.createFileOfPdfUrl(provider.itemList[index]["pdf_url"], index, "inner").then((f) {

                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => 
                                                      // PDFScreen( f.path)
                                                      PDFScreen(provider.itemList[index]["pdf_url"])
                                                      ),);
                                                  // });
                                              }, ),
                                            Container(
                                              padding: EdgeInsets.only(left: 12),
                                              alignment: Alignment.center,
                                              child: Text(
                                                langcode == "en" || langcode == "en_"?provider.itemList[index]["product_names"]:provider.itemList[index]["slovaktitle"],
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black,
                                                    wordSpacing: 1.5
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Text(
                                        (double.parse(provider.itemList[index]["product_prices"].toString().replaceAll("€", "").trim())*double.parse(provider.itemList[index]["count"])).toStringAsFixed(2)+' \u{20AC}',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                            wordSpacing: 1.5
                                        ),
                                      ),
                                    ],
                                  )
                              );
                            }), ),
                      Container(
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: HexColor("#F0F0F2"),
                                width: 0.80,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Languages.of(contextmain)!.ShippingPayment,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    wordSpacing: 1.5
                                ),
                              ),
                              Text(
                                provider.shipment_charges+' \u{20AC}',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    wordSpacing: 1.5
                                ),
                              ),
                            ],
                          )
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: HexColor("#F0F0F2"),
                                width: 3,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Languages.of(contextmain)!.Discount,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: MyColors.primaryColor,
                                    wordSpacing: 1.5
                                ),
                              ),
                              Text(
                                provider.discount+' \u{20AC}',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: MyColors.primaryColor,
                                    wordSpacing: 1.5
                                ),
                              ),
                            ],
                          )
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: HexColor("#F5F5F7"),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Languages.of(contextmain)!.TotalPrice,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    wordSpacing: 1.5
                                ),
                              ),
                              Text(
                                provider.total_price+' \u{20AC}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    wordSpacing: 1.5
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ),
              // provider.ordersummaryimageList.length>0? 
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 36.0, 0.0, 0.0),
                child: Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width*1.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    color: MyColors.primaryColor,
                    onPressed: () async {
                      provider.addDataTocart(context);
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddressListPage(provider.token,"order",)),);*/
                    },

                    child: Text(Languages.of(contextmain)!.BuyitAgain,
                        style: TextStyle(
                            letterSpacing: 2,
                            wordSpacing: 2,
                            color: Colors.white, fontSize: 18)
                    ),
                  ),
                ),
              )
              // :Container(),
            ],
          ),
        ),
      ):Center(child: CircularProgressIndicator(),),
    );
  }

}
