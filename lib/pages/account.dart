
import 'dart:math';
import 'dart:convert';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:flutter/services.dart';
import 'package:memotiapp/pages/tabs.dart';
import 'package:memotiapp/provider/database.dart';
import 'package:stripe_sdk/stripe_sdk.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:memotiapp/pages/address.dart';
import 'package:memotiapp/pages/login.dart';
import 'package:memotiapp/pages/ordersummary.dart';
import 'package:memotiapp/pages/signup.dart';
import 'package:provider/provider.dart';
import 'package:memotiapp/provider/appaccess.dart';
import 'package:memotiapp/provider/statics.dart';

import 'package:memotiapp/localization/language/languages.dart';
import 'package:memotiapp/localization/locale_constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart';


class AccountPage extends StatefulWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);  
    var count = 0;
    if (count == 0) {
      count++;
      provider.getuserId();
    }
    Widget setuphelpdialog(contextmain, context, provider){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 160,
        child: Column(
          children: [
            InkWell(
              onTap: (){
                final Uri _emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'example@gmail.com',
                    queryParameters: {
                      'subject': 'Example Subject & Symbols are allowed!'
                    }
                );
                // launch(_emailLaunchUri.toString());
                //launch("mailto:example@gmail.com?subject=subject&body=body");

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Languages.of(context)!.EmailAddress,
                  style:TextStyle(color: Colors.black,fontSize: 14),),
                  Text("example@gmail.com",style:TextStyle(color: Colors.grey,fontSize: 13),)
                ],
              ),
            ),
            SizedBox(height: 24,),
            InkWell(
              onTap: (){
                // launch("tel:+91 9999922299");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Languages.of(context)!.ContactUs,
                  style:TextStyle(color: Colors.black,fontSize: 14),),
                  Text("9999922299",style:TextStyle(color: Colors.grey,fontSize: 13),)
                ],
              ),
            )
          ],
        ),
      );
    }
    //user_profile
    Container body = Container(
        child: Column(
//            mainAxisAlignment: MainAxisAlignment.,
            children: [
          Container(
              child: Column(children: [
                Container(
                    margin: EdgeInsets.only(top: 80),
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/img/white_logo.png'),
                            fit: BoxFit.fill))
                            ),
                // Container(
                //     alignment: Alignment.center,
                //     margin: EdgeInsets.only(top: 40.0),
                //     child: CircleAvatar(
                //       radius: 40,
                //       backgroundColor: Colors.white,
                //       backgroundImage: provider.IsloggedIn
                //           ? provider.a_image == "" || provider.a_image == null
                //           ? AssetImage(
                //         "assets/images/dummy_user.png",
                //       ) : 
                //       // CachedNetworkImage(imageUrl: provider.a_image)
                //           NetworkImage(provider.a_image)
                //           : AssetImage(
                //         "assets/images/dummy_user.png",
                //       ),
                //     )),
                Container(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    provider.IsloggedIn ? provider.a_name == null ? "": provider.a_name : 
                    "James Smith",
                    style: TextStyle(
                        fontSize: 22,
                        /*fontWeight: FontWeight.w600,*/
                        color: Colors.white),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    provider.IsloggedIn ? provider.a_email == null ? "": provider.a_email : 
                    "your@email.com",
                    style: TextStyle(
                        fontSize: 18,
                        /*fontWeight: FontWeight.w600,*/
                        color: Colors.white),
                  ),
                ),
              ]),),
              SizedBox(height: 16),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // provider.fetchAlbums();
                        changeLanguage(context, "en");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white),
                        padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(right: 12),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Center(
                                    child: langcode == 'en'||langcode == 'en_'
                                        ? Icon(
                                      Icons.check_circle,
                                      size: 30,
                                      color: MyColors.primaryColor,
                                    )
                                        : Icon(
                                      Icons.check_circle_outline,
                                      size: 30,
                                      color: MyColors.primaryColor,
                                    ),
                                  ),
                                )),
                            Text(
                              "English",
                                style: TextStyle(
                                    color: MyColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        changeLanguage(context, "sk");
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white),
                        padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(right: 12),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Center(
                                    child: langcode == 'sk'||langcode == '_sk'
                                        ? Icon(
                                      Icons.check_circle,
                                      size: 30,
                                      color: MyColors.primaryColor,
                                    )
                                        : Icon(
                                      Icons.check_circle_outline,
                                      size: 30,
                                      color: MyColors.primaryColor,
                                    ),
                                  ),
                                )),
                            Text("Slovak",
                                style: TextStyle(
                                    color: MyColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ShareAndHelpBtn(
                text: Languages.of(context)!.ShareApp,
                icon: "assets/icon/Icon_Share.svg",
                onPressed: () async => {
                  await Share.share(" https://play.google.com/apps/internaltest/4698636625809416269")
                },
              ),
              SizedBox(
                width: 40,
              ),
              InkWell(
                onTap: (){
                  showDialog(
                      context: context,
                      //useRootNavigator: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(Languages.of(context)!.Help
                          ),
                          content: setuphelpdialog(context, context, provider),
                          actions: [
                            ElevatedButton(
                                child: Text(Languages.of(context)!.Cancel,
                                ),
                                onPressed:  () {
                                  Navigator.of(context).pop();
                                }),
                          ],
                        );
                      });
                },
                child: ShareAndHelpBtn(
                  text: Languages.of(context)!.HelpContact,
                  icon: "assets/icon/Icon_Help.svg", onPressed: () {  },
               /*   onPressed: () {
                    print("111");

                  },*/
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BtnWithIconOnLeft(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderHistoryPage(context)),
                  )
                },
                icon: "assets/icon/Icon_Order.svg",
                text: 
                Languages.of(context)!.OrderSummary,
              ),
              SizedBox(
                width: 10,
              ),
              BtnWithIconOnLeft(
                onPressed: () {
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) =>
                               CardListPage("account")
                               ));
                  // MemotiDbProvider.db.deleteAllData();
                },
                icon: "assets/icon/Icon_Payment.svg",
                text: Languages.of(context)!.PaymentMethod,
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BtnWithIconOnLeft(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddressListPage(context, provider.token, "account")),
                  )
                },
                icon: "assets/icon/Icon_Addresses.svg",
                text: Languages.of(context)!.MyAddresses,
              ),
              SizedBox(
                width: 10,
              ),
              BtnWithIconOnLeft(
                onPressed: () => {
                  provider.logout()
                },
                icon: "assets/icon/Icon_LogOut.svg",
                text: Languages.of(context)!.Logout,
              ),
//
            ],
          ),
              SizedBox(height: 16),
        ]));

    // welcome
    welcomeHeader(BuildContext context, BuildContext contextmain) =>  Column(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 50),
            width: 200,
            height: 50,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/white_logo.png'),
                    fit: BoxFit.fill))),
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                top: SizeConfig.accountImagePlacementHeight),
            child: Image(
              width: 180,
              height: 150,
              image: AssetImage("assets/img/welcome.png"),
            )),
        SizedBox(
          height: 30.0,
        ),
      ],
    );

    welomeFields(BuildContext context, BuildContext contextmain) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () {
                  // provider.setCheck();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SignupPage()),
                  );
                },
                child: Container(
                    width: 290,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email,
                          color: MyColors.primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(Languages.of(context)!.SignupwithMail
                        ),
                      ],
                    )),
              ),
              InkWell(
                onTap: () {
                  provider.facebook_logins(context);
                  // provider.facebook_login(context);
                },
                child: WithFbButton(
                    text: Languages.of(context)!.SignupwithFacebook
                    ),
              ),
              SizedBox(height: 16),
              Container(
                width: MediaQuery.of(context).size.width ,
                height: 2,
                color: Colors.white,
              ),
              SizedBox(height: 16),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        changeLanguage(context, "en", );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white),
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(right: 12),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Center(
                                    child: langcode == 'en'||langcode == 'en_'
                                        ? Icon(
                                            Icons.check_circle,
                                            size: 30,
                                            color: MyColors.primaryColor,
                                          )
                                        : Icon(
                                            Icons.check_circle_outline,
                                            size: 30,
                                            color: MyColors.primaryColor,
                                          ),
                                  ),
                                )),
                            Text("English",
                                style: TextStyle(
                                    color: MyColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        changeLanguage(context, 'sk');
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white),
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(right: 12),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Center(
                                    child: langcode == 'sk'||langcode == '_sk'
                                        ? Icon(
                                            Icons.check_circle,
                                            size: 30,
                                            color: MyColors.primaryColor,
                                          )
                                        : Icon(
                                            Icons.check_circle_outline,
                                            size: 30,
                                            color: MyColors.primaryColor,
                                          ),
                                  ),
                                )),
                            Text("Slovak",
                                style: TextStyle(
                                    color: MyColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 8),
              InkWell(
                  onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text(
                          Languages.of(context)!.Alreadyhaveanaccount,
                          style: TextStyle(
                              color: MyColors.primaryColoralredayHaveAccount,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          Languages.of(context)!.LoginNow,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ShareAndHelpBtn(
                    text: "Share\nApp",
                    icon: "assets/icon/Icon_Share.svg",
                    onPressed: () async => {
                      await Share.share("http://play.google.com/store/apps/details?id=")
                    },
                  ),
                  SizedBox(width: 40),
                  InkWell(
                    onTap: (){
                      print("111");
                      showDialog(
                          context: context,
                          useRootNavigator: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(Languages.of(context)!.Help
                              ),
                              content: setuphelpdialog(contextmain, context, provider),
                              actions: [
                                // ElevatedButton(
                                //     child: Text(Languages.of(context)!.Cancel,),
                                //     onPressed:  () {
                                //       Navigator.of(context).pop();
                                //     }),
                              ],
                            );
                          });
                    },
                    child: ShareAndHelpBtn(
                      text: "Help &\nContact",
                      icon: "assets/icon/Icon_Help.svg",
                      onPressed: () {

                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        );

    welcomeBody(BuildContext context, BuildContext contextmain) => Container(
          child: Column(
            children: <Widget>[
              welcomeHeader(context, contextmain),
              welomeFields(context, contextmain)
            ],
          ),
        );

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/account_bg.png'),
                fit: BoxFit.fill)),
        padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
        child: SingleChildScrollView(
          child: provider.busy
              ? Container(child: Center(child: CircularProgressIndicator()))
              : provider.IsloggedIn
                  ? body
                  : welcomeBody(context, context),
        ),
      ),
    );
  }

  
}


class BtnWithIconOnLeft extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback onPressed;

  BtnWithIconOnLeft({ required this.text,  required this.icon,  required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: 
        Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width * 0.48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               SvgPicture.asset(icon,width: 20,height: 20,),
                Container(
                  margin: EdgeInsets.only(left: 9),
                  child: Text(
                    text,
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            )
          )
        );
  }
}

class ShareAndHelpBtn extends StatelessWidget {
  final text;
  final String icon;
  final VoidCallback onPressed;
  ShareAndHelpBtn({this.text,  required this.icon,  required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
            alignment: Alignment.center,
            width: 100,
            margin: EdgeInsets.only(
                bottom: 20, top: (MediaQuery.of(context).size.height/100) * 3),
            padding: EdgeInsets.only(top: 20, bottom: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(icon),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                   text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )));
  }
}

class WithFbButton extends StatelessWidget {
  final text;

  WithFbButton({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: 290,
        height: 50,
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
                color: Colors.white, width: 2, style: BorderStyle.solid)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.facebook,
              color: Colors.blue,
            ),
            SizedBox(
              width: 10,
            ),
//
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ));
  }
}


class CardListPage extends StatelessWidget {
  String where;
  CardListPage(this.where);

  @override
  Widget build(BuildContext context) {
    return InnerCardListPage(where);
  }
}
class InnerCardListPage extends StatelessWidget {
  String where;
  InnerCardListPage(this.where);
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
    final provider = Provider.of<NavigationProvider>(context);
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    if(provider.fetchcard){
      provider.fetchAllDatacards();
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(Languages.of(context)!.PaymentOption,
        style:TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              height: _height,
              width: _width,
              child: Column(
                children: [
                  Expanded(child: case2(
                    provider.apiResponse,
                    {
                      "nodata": showReponse(context,provider, context),
                      "apierror": apiError(context,provider, context),
                      "responsesuccess": showReponse(context,provider, context),
                    },
                     Container(child: Text(Languages.of(context)!.Gettingcards
                     )),
                  ),),
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 0.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Map<dynamic,dynamic>? map = null;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AddCardPage(context, where)),);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(
                                  color: Colors.black, style: BorderStyle.solid, width: 2),
                            ),

                            child: Container(
                              height: 50.0,
                              width: MediaQuery.of(context).size.width*1.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 12),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 20.0,
                                    ),
                                  ),
                                  Text(Languages.of(context)!.AddNewCard,
                                      style: TextStyle(
                                          letterSpacing: 2,
                                          wordSpacing: 2,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black, fontSize: 18)
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                          child: Container(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width*1.0,
                            child: 
                            ElevatedButton(
                              child: Text(
                                Languages.of(context)!.Done
                                ),
                              style: ElevatedButton.styleFrom(
                                primary: MyColors.primaryColor,
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                ),
                                side: BorderSide(color: MyColors.primaryColor),
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2,
                                    wordSpacing: 2,
                                ),
                              ),
                              onPressed: () {
                                switch(where){
                                  case "cart":{
                                    if(provider.card){
                                      if(provider.cards.length>0){
                                        for(var x = 0; x<provider.cards.length; x++){
                                          if(provider.cards[x]["isSelected"]){
                                            provider.setcardDetail(provider.cards[x]);
                                            provider.setCashondeleveryPrice(provider.cash_on_deleviery_price);
                                            Navigator.push( context, MaterialPageRoute(builder: (context) => ShippingAddressPage(context,provider.card)));
                                          }
                                        }
                                      }
                                    }else{
                                      provider.setCashondeleveryPrice(provider.cash_on_deleviery_price);
                                      Navigator.push( context, MaterialPageRoute(builder: (context) => ShippingAddressPage(context,provider.card)));
                                    }
                                    break;
                                  }
                                  case "account":{
                                    Navigator.pop(context);
                                    break;
                                  }
                                }
                              },
                            )
                            // RaisedButton(
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(25)),
                            //   color: MyColors.primaryColor,
                            //   onPressed: ()  {
                            //     switch(where){
                            //       case "cart":{
                            //         if(provider.card){
                            //           if(provider.cards.length>0){
                            //             for(var x = 0; x<provider.cards.length; x++){
                            //               if(provider.cards[x]["isSelected"]){
                            //                 provider.setcardDetail(provider.cards[x]);
                            //                 provider.setCashondeleveryPrice(provider.cash_on_deleviery_price);
                            //                 Navigator.push( context, MaterialPageRoute(builder: (context) => ShippingAddressPage(context,provider.card)));
                            //               }
                            //             }
                            //           }
                            //         }else{
                            //           provider.setCashondeleveryPrice(provider.cash_on_deleviery_price);
                            //           Navigator.push( context, MaterialPageRoute(builder: (context) => ShippingAddressPage(context,provider.card)));
                            //         }
                            //         break;
                            //       }
                            //       case "account":{
                            //         Navigator.pop(context);
                            //         break;
                            //       }
                            //     }
                            //   },
                            //   child: Text(Languages.of(context)!.Done,
                            //       style: TextStyle(
                            //           letterSpacing: 2,
                            //           wordSpacing: 2,
                            //           color: Colors.white, fontSize: 18)
                            //   ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            provider.showProgress?Container(child: Center(child: CircularProgressIndicator(),),):Container(),
          ],
        ),
      ),

    );
  }
}

Widget apiError(BuildContext contextmain,  provider, BuildContext context){

  return Center(child: Column(
    children: [
      Text(Languages.of(contextmain)!.SomeThingwentwrong,
      style: TextStyle(color: MyColors.primaryColor,fontSize: 20,fontWeight: FontWeight.w600),),
        SizedBox(width: 20),

        ElevatedButton(
          child: Text(
            Languages.of(contextmain)!.Tryagain.toUpperCase()
            ),
          style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
            ),
            side: BorderSide(color: MyColors.primaryColor),
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
            ),
          ),
          onPressed: () {
          },
        )
      // RaisedButton(
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(0.0),
      //       side: BorderSide(color: MyColors.primaryColor)),
      //   onPressed: () {
      //   //provider.getAllCartproduct1(context);
      //   },
      //   color: Colors.white,
      //   textColor: MyColors.primaryColor,
      //   child: Text(Languages.of(contextmain)!.Tryagain.toUpperCase(),
      //       style: TextStyle(fontSize: 14)),
      // ),
    ],
  ),);

}
Widget showReponse(BuildContext contextmain, provider, BuildContext context){
  
  return provider.apiResponse=="nodata"? Container(
    child: Column(
       children: [
         Container(child:  Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Checkbox(
               value: provider.card,
               onChanged: (value) {
                 provider.setcheckbox(value,"card");
               },
             ),
             /* new Radio(
              value: 0,
              groupValue: provider.radioValue,
              onChanged: provider.handleRadioValueChange(0),
            ),*/
             new Text(
               'Card',
               style: new TextStyle(fontSize: 18.0,color: Colors.black),
             ),
             Checkbox(
               value: provider.cod,
               onChanged: (value) {
                 provider.setcheckbox(value,"cod");
               },
             ),
             /*  new Radio(
              value: 1,
              groupValue: provider.radioValue,
              onChanged: provider.handleRadioValueChange(1),
            ),*/
             new Text(
               Languages.of(contextmain)!.CashonDelievery,
               style: new TextStyle(
                   fontSize: 18.0,color: Colors.black
               ),
             ),
           ],
         ),),
    //      Stack(
    // children: [
    //   Visibility(visible: provider.card?true:false,child:Container(child: Text(Languages.of(contextmain)!.NoCardaddedyet
    //   ))),
    //   Visibility(visible: provider.card?false:true, child:
    //   Card(
    //     elevation: 6,
    //     shadowcolor: Colors.black26,
    //     color: Colors.white,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: const BorderRadius.all(
    //         Radius.circular(12.0),
    //       ),
    //     ),
    //     child: Container(

    //       padding: EdgeInsets.all(16),
    //       child: Row(
    //         children: [
    //           Expanded(child: Text(Languages.of(contextmain)!.CashonDelievery,
    //           style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),),
    //           Container(padding:EdgeInsets.only(left: 12),child: Text("+ "+provider.cash_on_deleviery_price+" €",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600)),)
    //         ],
    //       ),
    //     ),
    //   )),
    // ],),
       ],
    ),
  ):
  Container(
    child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: provider.cards.length+1,
        itemBuilder: (BuildContext context, int index){
       if(index==0){
        return Container(child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: provider.card,
              onChanged: (value) {
                provider.setcheckbox(value,"card");
              },
            ),
           /* new Radio(
              value: 0,
              groupValue: provider.radioValue,
              onChanged: provider.handleRadioValueChange(0),
            ),*/
            new Text(
              'Card',
              style: new TextStyle(fontSize: 18.0,color: Colors.black),
            ),
            Checkbox(
              value: provider.cod,
              onChanged: (value) {
                provider.setcheckbox(value,"cod");
              },
            ),
          /*  new Radio(
              value: 1,
              groupValue: provider.radioValue,
              onChanged: provider.handleRadioValueChange(1),
            ),*/
            new Text(
              Languages.of(contextmain)!.CashonDelievery,
              style: new TextStyle(
                fontSize: 18.0,color: Colors.black
              ),
            ),
          ],
        ),);
      }else{
         return Stack(
             children: [
         Visibility(visible: provider.card?true:false,child: CardItem(provider, (index-1), context, provider.cards[index-1])),
        //  Visibility(visible: provider.card?false:true, child:
        //  Card(
        //    elevation: 6,
        //    shadowcolor: Colors.black26,
        //    color: Colors.white,
        //    shape: RoundedRectangleBorder(
        //      borderRadius: const BorderRadius.all(
        //        Radius.circular(12.0),
        //      ),
        //    ),
        //    child: Container(

        //      padding: EdgeInsets.all(16),
        //      child: Row(
        //        children: [
        //          Expanded(child: Text(Languages.of(contextmain)!.CashonDelievery,
        //          style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),),
        //          Container(padding:EdgeInsets.only(left: 12),child: Text("+ "+provider.cash_on_deleviery_price+" €",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600)),)
        //        ],
        //      ),
        //    ),
        //  )
        // ),
             ],);
       }
    }),
  );
}

class CardItem extends StatelessWidget {
  final provider;
  late int index;
  late BuildContext context;
  late Map cards;
  late String token;
  CardItem(this.provider, this.index, this.context, this.cards);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
      // Card(
      //   elevation: 6,
      //   shadowcolor: Colors.black26,
      //   color: Colors.white,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: const BorderRadius.all(
      //       Radius.circular(12.0),
      //     ),
      //   ),
      //   child: 
        Container(
          padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => provider.changecard(index),
                child: Container(
                    padding: EdgeInsets.only(right: 24),
                    alignment: Alignment.centerLeft,
                    child: cards["isSelected"]?
                    Container(
                      child: Center(
                        child: Icon(
                          Icons.check_circle,
                          size: 50,
                          color: MyColors.primaryColor,
                        ),
                      ),
                    )
                        :
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 4, 0),
                      height: 41,
                      width: 41,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(
                            color: Colors.black, width: 0.80),
                      ),
                    )
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          cards["cardHolderName"],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),),
                      Padding(padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                        child: Text(
                          cards["cardNumber"],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                      Padding(padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                        child: Text(
                          cards["expiryDate"]+"     cvv  -  ***",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),),
                    ],
                  ),

                ),),
              Container(
                child: Column(

                  children: [
                    SizedBox(height: 70,),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: MyColors.primaryColor,
                        size: 20,
                      ),
                      onPressed: () {
                        provider.deleteCard(index,cards["ii"]);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      // ),
    );
  }
}


class AddCardPage extends StatefulWidget {
  String where;
  BuildContext contextmain;
  AddCardPage(this.contextmain, this.where);

  @override
  State<StatefulWidget> createState() {
    return AddCardPageState(contextmain, where);
  }
}

class AddCardPageState extends State<AddCardPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool isloading = false;
  String where;
  Map<dynamic, dynamic>? cards;
  BuildContext contextmain;
  AddCardPageState(this.contextmain, this.where);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // if(cards!=null){
    //   cardHolderName = cards["cardHolderName"];
    //   cardNumber = cards["cardNumber"];
    //   expiryDate = cards["expiryDate"];
    // }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          Languages.of(contextmain)!.AddCardDetail,
        style:TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
      ),
      body: SafeArea(
        child: Stack(
          children: [Column(
            children: <Widget>[
              // CreditCardWidget(
              //   cardNumber: cardNumber,
              //   expiryDate: expiryDate,
              //   cardHolderName: cardHolderName,
              //   cvvCode: cvvCode,
              //   showBackView: isCvvFocused,
              //   obscureCardNumber: true,
              //   obscureCardCvv: true, cardType: CardType(), height: 0, textStyle: TextStyle, width: 0,
              // ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumberDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                        ),
                        expiryDateDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Holder',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange, cardHolderName: '', cardNumber: '', cursorColor: Colors.transparent, cvvCode: '', expiryDate: '', themeColor: Colors.transparent,
                      ),
                      ElevatedButton(
                        child: Text(
                          'Validate'
                          ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff1b447b),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                          ),
                          side: BorderSide(color: Colors.white),
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'halter',
                              fontSize: 14,
                              package: 'flutter_credit_card',
                          ),
                        ),
                        onPressed: () async{
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isloading  = true;
                            });
                            dynamic cardData = {
                              "cardNumber":cardNumber,
                              "expiryDate":expiryDate,
                              "cardHolderName":cardHolderName,
                              "cvvCode":cvvCode,
                            };
                            SharedPreferences preferences  = await SharedPreferences.getInstance();
                            String customer_id = preferences.get(UiData.user_id)??"";
                            String token = preferences.get(UiData.token)??"";
                            String body;
                            if(cards!=null){
                              dynamic data = {
                                "cardid":cards!["ii"],
                                "cardDetail":cardData,
                                "customer_id":customer_id
                              };
                              body = json.encode(data);
                              print(body);
                            }else{
                              dynamic data = {
                                "cardDetail":cardData,
                                "customer_id":customer_id
                              };
                              body = json.encode(data);
                              print(body);
                            }
                            var url = Uri.parse("https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/savecard");
                            http.Response response = await http.post(
                                url,
                                headers: <String, String>{
                                  'Content-Type': 'application/json; charset=UTF-8',
                                  'Authorization': token,
                                },
                                body: body
                            );
                            print(response.body);
                            setState(() {
                              isloading  =false;
                            });
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CardListPage(where)),
                            );
                          } else {
                            print('invalid!');
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
            isloading ? Container(child: Center(
            child: CircularProgressIndicator(),
          ),):Container()],
        ),
      ),
    );
  }

  void onCreditCardModelChange( creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
class CreditCardWidget extends StatefulWidget {
  const CreditCardWidget({
    Key? key,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    required this.showBackView,
    this.animationDuration = const Duration(milliseconds: 500),
    required this.height,
    required this.width,
    required this.textStyle,
    this.cardBgColor = const Color(0xff1b447b),
    this.obscureCardNumber = true,
    this.obscureCardCvv = true,
    this.labelCardHolder = 'CARD HOLDER',
    this.labelExpiredDate = 'MM/YY',
    required this.cardType,
  })  : assert(cardNumber != null),
        assert(showBackView != null),
        super(key: key);

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final TextStyle textStyle;
  final Color cardBgColor;
  final bool showBackView;
  final Duration animationDuration;
  final double height;
  final double width;
  final bool obscureCardNumber;
  final bool obscureCardCvv;

  final String labelCardHolder;
  final String labelExpiredDate;

  final CardType cardType;

  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _frontRotation;
  late Animation<double> _backRotation;
  late Gradient backgroundGradientColor;

  bool isAmex = false;

  @override
  void initState() {
    super.initState();

    ///initialize the animation controller
    controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    backgroundGradientColor = LinearGradient(
      // Where the linear gradient begins and ends
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const <double>[0.1, 0.4, 0.7, 0.9],
      colors: <Color>[
        widget.cardBgColor.withOpacity(1),
        widget.cardBgColor.withOpacity(0.97),
        widget.cardBgColor.withOpacity(0.90),
        widget.cardBgColor.withOpacity(0.86),
      ],
    );

    ///Initialize the Front to back rotation tween sequence.
    _frontRotation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: pi / 2).chain(CurveTween(curve: Curves.easeIn)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
      ],
    ).animate(controller);

    _backRotation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: -pi / 2, end: 0.0).chain(CurveTween(curve: Curves.easeOut)),
          weight: 50.0,
        ),
      ],
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Orientation orientation = MediaQuery.of(context).orientation;

    ///
    /// If uer adds CVV then toggle the card from front to back..
    /// controller forward starts animation and shows back layout.
    /// controller reverse starts animation and shows front layout.
    ///
    if (widget.showBackView) {
      controller.forward();
    } else {
      controller.reverse();
    }

    return Stack(
      children: <Widget>[
        AnimationCard(
          animation: _frontRotation,
          child: buildFrontContainer(width, height, context, orientation),
        ),
        AnimationCard(
          animation: _backRotation,
          child: buildBackContainer(width, height, context, orientation),
        ),
      ],
    );
  }

  ///
  /// Builds a back container containing cvv
  ///
  Container buildBackContainer(
    double width,
    double height,
    BuildContext context,
    Orientation orientation,
  ) {
    final TextStyle defaultTextStyle =
        Theme.of(context).textTheme.headline6!.merge(
              TextStyle(
                color: Colors.black,
                fontFamily: 'halter',
                fontSize: 16,
                package: 'flutter_credit_card',
              ),
            );

    final String cvv = widget.obscureCardCvv
        ? widget.cvvCode.replaceAll(RegExp(r'\d'), '*')
        : widget.cvvCode;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: backgroundGradientColor,
      ),
      margin: const EdgeInsets.all(16),
      width: widget.width,
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              height: 48,
              color: Colors.black,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 9,
                    child: Container(
                      height: 48,
                      color: Colors.white70,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          widget.cvvCode.isEmpty
                              ? isAmex ? 'XXXX' : 'XXX'
                              : cvv,
                          maxLines: 1,
                          style: widget.textStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: widget.cardType != null ? getCardTypeImage(widget.cardType) : getCardTypeIcon(widget.cardNumber),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Builds a front container containing
  /// Card number, Exp. year and Card holder name
  ///
  Container buildFrontContainer(
    double width,
    double height,
    BuildContext context,
    Orientation orientation,
  ) {
    final TextStyle defaultTextStyle =
        Theme.of(context).textTheme.headline6!.merge(
              TextStyle(
                color: Colors.white,
                fontFamily: 'halter',
                fontSize: 16,
                package: 'flutter_credit_card',
              ),
            );

    final String number = widget.obscureCardNumber
        ? widget.cardNumber.replaceAll(RegExp(r'(?<=.{4})\d(?=.{4})'), '*')
        : widget.cardNumber;

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: backgroundGradientColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
          ),
        ],
      ),
      width: widget.width,
      height: widget.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: widget.cardType != null ? getCardTypeImage(widget.cardType) : getCardTypeIcon(widget.cardNumber),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                widget.cardNumber.isEmpty || widget.cardNumber == null
                    ? 'XXXX XXXX XXXX XXXX'
                    : number,
                style: widget.textStyle,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                widget.expiryDate.isEmpty || widget.expiryDate == null ? widget.labelExpiredDate : widget.expiryDate,
                style: widget.textStyle,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Text(
                widget.cardHolderName.isEmpty || widget.cardHolderName == null ? widget.labelCardHolder : widget.cardHolderName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: widget.textStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Credit Card prefix patterns as of March 2019
  /// A [List<String>] represents a range.
  /// i.e. ['51', '55'] represents the range of cards starting with '51' to those starting with '55'
  Map<CardType, Set<List<String>>> cardNumPatterns =
      <CardType, Set<List<String>>>{
    CardType.visa: <List<String>>{
      <String>['4'],
    },
    CardType.americanExpress: <List<String>>{
      <String>['34'],
      <String>['37'],
    },
    CardType.discover: <List<String>>{
      <String>['6011'],
      <String>['622126', '622925'],
      <String>['644', '649'],
      <String>['65']
    },
    CardType.mastercard: <List<String>>{
      <String>['51', '55'],
      <String>['2221', '2229'],
      <String>['223', '229'],
      <String>['23', '26'],
      <String>['270', '271'],
      <String>['2720'],
    },
  };

  /// This function determines the Credit Card type based on the cardPatterns
  /// and returns it.
  CardType detectCCType(String cardNumber) {
    //Default card type is other
    CardType cardType = CardType.otherBrand;

    if (cardNumber.isEmpty) {
      return cardType;
    }

    cardNumPatterns.forEach(
      (CardType type, Set<List<String>> patterns) {
        for (List<String> patternRange in patterns) {
          // Remove any spaces
          String ccPatternStr = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
          final int rangeLen = patternRange[0].length;
          // Trim the Credit Card number string to match the pattern prefix length
          if (rangeLen < cardNumber.length) {
            ccPatternStr = ccPatternStr.substring(0, rangeLen);
          }

          if (patternRange.length > 1) {
            // Convert the prefix range into numbers then make sure the
            // Credit Card num is in the pattern range.
            // Because Strings don't have '>=' type operators
            final int ccPrefixAsInt = int.parse(ccPatternStr);
            final int startPatternPrefixAsInt = int.parse(patternRange[0]);
            final int endPatternPrefixAsInt = int.parse(patternRange[1]);
            if (ccPrefixAsInt >= startPatternPrefixAsInt && ccPrefixAsInt <= endPatternPrefixAsInt) {
              // Found a match
              cardType = type;
              break;
            }
          } else {
            // Just compare the single pattern prefix with the Credit Card prefix
            if (ccPatternStr == patternRange[0]) {
              // Found a match
              cardType = type;
              break;
            }
          }
        }
      },
    );

    return cardType;
  }

  Widget getCardTypeImage(CardType cardType) => Image.asset(
        CardTypeIconAsset[cardType]!,
        height: 48,
        width: 48,
        package: 'flutter_credit_card',
      );

  // This method returns the icon for the visa card type if found
  // else will return the empty container
  Widget getCardTypeIcon(String cardNumber) {
    Widget icon;
    switch (detectCCType(cardNumber)) {
      case CardType.visa:
        icon = Image.asset(
          'icons/visa.png',
          height: 48,
          width: 48,
          package: 'flutter_credit_card',
        );
        isAmex = false;
        break;

      case CardType.americanExpress:
        icon = Image.asset(
          'icons/amex.png',
          height: 48,
          width: 48,
          package: 'flutter_credit_card',
        );
        isAmex = true;
        break;

      case CardType.mastercard:
        icon = Image.asset(
          'icons/mastercard.png',
          height: 48,
          width: 48,
          package: 'flutter_credit_card',
        );
        isAmex = false;
        break;

      case CardType.discover:
        icon = Image.asset(
          'icons/discover.png',
          height: 48,
          width: 48,
          package: 'flutter_credit_card',
        );
        isAmex = false;
        break;

      default:
        icon = Container(
          height: 48,
          width: 48,
        );
        isAmex = false;
        break;
    }

    return icon;
  }
}
enum CardType {
  otherBrand,
  mastercard,
  visa,
  americanExpress,
  discover,
}

class AnimationCard extends StatelessWidget {
  const AnimationCard({
    required this.child,
    required this.animation,
  });

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final Matrix4 transform = Matrix4.identity();
        transform.setEntry(3, 2, 0.001);
        transform.rotateY(animation.value);
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: child,
    );
  }
}
const Map<CardType, String> CardTypeIconAsset = {
  CardType.visa: 'icons/visa.png',
  CardType.americanExpress: 'icons/amex.png',
  CardType.mastercard: 'icons/mastercard.png',
  CardType.discover: 'icons/discover.png',
};

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({
    Key? key,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    this.obscureCvv = false,
    this.obscureNumber = false,
    required this.onCreditCardModelChange,
    required this.themeColor,
    this.textColor = Colors.black,
    required this.cursorColor,
    this.cardHolderDecoration = const InputDecoration(
      labelText: 'Card holder',
    ),
    this.cardNumberDecoration = const InputDecoration(
      labelText: 'Card number',
      hintText: 'XXXX XXXX XXXX XXXX',
    ),
    this.expiryDateDecoration = const InputDecoration(
      labelText: 'Expired Date',
      hintText: 'MM/YY',
    ),
    this.cvvCodeDecoration = const InputDecoration(
      labelText: 'CVV',
      hintText: 'XXX',
    ),
    required this.formKey,
    this.cvvValidationMessage = 'Please input a valid CVV',
    this.dateValidationMessage = 'Please input a valid date',
    this.numberValidationMessage = 'Please input a valid number',
  }) : super(key: key);

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final String cvvValidationMessage;
  final String dateValidationMessage;
  final String numberValidationMessage;
  final void Function(CreditCardModel) onCreditCardModelChange;
  final Color themeColor;
  final Color textColor;
  final Color cursorColor;
  final bool obscureCvv;
  final bool obscureNumber;
  final GlobalKey<FormState> formKey;

  final InputDecoration cardNumberDecoration;
  final InputDecoration cardHolderDecoration;
  final InputDecoration expiryDateDecoration;
  final InputDecoration cvvCodeDecoration;

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  late String cardNumber;
  late String expiryDate;
  late String cardHolderName;
  late String cvvCode;
  late bool isCvvFocused = false;
  late Color themeColor;

  late void Function(CreditCardModel) onCreditCardModelChange;
  late CreditCardModel creditCardModel;

  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '0000');

  FocusNode cvvFocusNode = FocusNode();
  FocusNode cardNumberNode = FocusNode();
  FocusNode expiryDateNode = FocusNode();
  FocusNode cardHolderNode = FocusNode();

  void textFieldFocusDidChange() {
    creditCardModel.isCvvFocused = cvvFocusNode.hasFocus;
    onCreditCardModelChange(creditCardModel);
  }

  void createCreditCardModel() {
    cardNumber = widget.cardNumber;
    expiryDate = widget.expiryDate;
    cardHolderName = widget.cardHolderName;
    cvvCode = widget.cvvCode;

    creditCardModel = CreditCardModel(
        cardNumber, expiryDate, cardHolderName, cvvCode, isCvvFocused);
  }

  @override
  void initState() {
    super.initState();

    createCreditCardModel();

    onCreditCardModelChange = widget.onCreditCardModelChange;

    cvvFocusNode.addListener(textFieldFocusDidChange);

    _cardNumberController.addListener(() {
      setState(() {
        cardNumber = _cardNumberController.text;
        creditCardModel.cardNumber = cardNumber;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _expiryDateController.addListener(() {
      setState(() {
        expiryDate = _expiryDateController.text;
        creditCardModel.expiryDate = expiryDate;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cardHolderNameController.addListener(() {
      setState(() {
        cardHolderName = _cardHolderNameController.text;
        creditCardModel.cardHolderName = cardHolderName;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cvvCodeController.addListener(() {
      setState(() {
        cvvCode = _cvvCodeController.text;
        creditCardModel.cvvCode = cvvCode;
        onCreditCardModelChange(creditCardModel);
      });
    });
  }

  @override
  void dispose() {
    cardHolderNode.dispose();
    cvvFocusNode.dispose();
    expiryDateNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    themeColor = widget.themeColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: themeColor.withOpacity(0.8),
        primaryColorDark: themeColor,
      ),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: TextFormField(
                obscureText: widget.obscureNumber,
                controller: _cardNumberController,
                cursorColor: widget.cursorColor,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(expiryDateNode);
                },
                style: TextStyle(
                  color: widget.textColor,
                ),
                decoration: widget.cardNumberDecoration,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: ( value) {
                  // Validate less that 13 digits +3 white spaces
                  if (value!.isEmpty || value.length < 16) {
                    return widget.numberValidationMessage;
                  }
                  return null;
                },
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
                    child: TextFormField(
                      controller: _expiryDateController,
                      cursorColor: widget.cursorColor,
                      focusNode: expiryDateNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(cvvFocusNode);
                      },
                      style: TextStyle(
                        color: widget.textColor,
                      ),
                      decoration: widget.expiryDateDecoration,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return widget.dateValidationMessage;
                        }

                        final DateTime now = DateTime.now();
                        final List<String> date = value.split(RegExp(r'/'));
                        final int month = int.parse(date.first);
                        final int year = int.parse('20${date.last}');
                        final DateTime cardDate = DateTime(year, month);

                        if (cardDate.isBefore(now) || month > 12 || month == 0) {
                          return widget.dateValidationMessage;
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
                    child: TextFormField(
                      obscureText: widget.obscureCvv,
                      focusNode: cvvFocusNode,
                      controller: _cvvCodeController,
                      cursorColor: widget.cursorColor,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(cardHolderNode);
                      },
                      style: TextStyle(
                        color: widget.textColor,
                      ),
                      decoration: widget.cvvCodeDecoration,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onChanged: (String text) {
                        setState(() {
                          cvvCode = text;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty || value.length < 3) {
                          return widget.cvvValidationMessage;
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
              child: TextFormField(
                controller: _cardHolderNameController,
                cursorColor: widget.cursorColor,
                focusNode: cardHolderNode,
                style: TextStyle(
                  color: widget.textColor,
                ),
                decoration: widget.cardHolderDecoration,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  onCreditCardModelChange(creditCardModel);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ShippingAddressPage extends StatelessWidget {
  BuildContext contextmain;
  bool card ;
  ShippingAddressPage(this.contextmain,this.card);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    if(!provider.firstcall){
      provider.init();
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: HexColor("#F0F0F2"),
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(Languages
            .of(contextmain)!
            .ShippingAddress,
          style:TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: HexColor("#F0F0F2"),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: provider.items.length,
                  itemBuilder: (BuildContext context, int index){
                    return ShippingItem(contextmain, provider,index, context, provider.items[index]);
                  }),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width*1.0,
                child: 
                  ElevatedButton(
                    child: Text(
                        Languages.of(contextmain)!.Done
                      ),
                    style: ElevatedButton.styleFrom(
                      primary: MyColors.primaryColor,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                      ),
                      side: BorderSide(color: MyColors.primaryColor),
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                      ),
                    ),
                    onPressed: () {
                      for(var x = 0; x<provider.items.length; x++){
                        if(provider.items[x]["itsdefault"]=="true"){
                          provider.setShippingDetail(provider.items[x]);
                          Navigator.push( context, MaterialPageRoute(builder: (context) => OrderDetailPage(contextmain,card)));
                        }
                      }
                    },
                  )
                // RaisedButton(
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(25)),
                //   color: MyColors.primaryColor,
                //   onPressed: ()  {
                //     for(var x = 0; x<provider.items.length; x++){
                //       if(provider.items[x]["itsdefault"]=="true"){
                //         provider.setShippingDetail(provider.items[x]);
                //         Navigator.push( context, MaterialPageRoute(builder: (context) => OrderDetailPage(contextmain,card)));
                //       }
                //     }

                //   },
                //   child: Text(Languages.of(contextmain)!.Done,
                //       style: TextStyle(
                //           letterSpacing: 2,
                //           wordSpacing: 2,
                //           color: Colors.white, fontSize: 18)
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ShippingItem extends StatelessWidget {
  final provider;
  int index;
  BuildContext context;
  BuildContext contextmain;
  Map shippingAddress;
  ShippingItem(this.contextmain,this.provider, this.index, this.context, this.shippingAddress);

  @override
  Widget build(BuildContext context) {
    print("contextmain - --"+shippingAddress.toString());
    print("lang - --"+lang.toString());
    return Container(
      child: 
      Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
                offset: Offset(2, 2),
                blurRadius: 6,
                color: Colors.black26,
          )
          ]),
        // Card(
        // elevation: 6,
        // shadowcolor: Colors.black26,
        // color: Colors.white,
        // shape: RoundedRectangleBorder(
        //   borderRadius: const BorderRadius.all(
        //     Radius.circular(12.0),
        //   ),
        // ),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => provider.changeShippingAddress(index),
                child: Container(
                    padding: EdgeInsets.only(right: 24),
                    alignment: Alignment.centerLeft,
                    child:
                    Container(
                      child: Center(
                        child: shippingAddress["itsdefault"]=="true"?Icon(
                          Icons.check_circle,
                          size: 30,
                          color: MyColors.primaryColor,
                        ):Icon(
                          Icons.check_circle_outline,
                          size: 30,
                          color: MyColors.primaryColor,
                        ),
                      ),
                    )
                ),
              ),
              Expanded(
                child: Text(
                  getLocal()=="en"?shippingAddress["title"]:shippingAddress["slovak"],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),),
              Container(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Text(
                  double.parse(shippingAddress["price"].toString()).toStringAsFixed(2)+" €",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}



String stripeAcc = "acct_1HzceuEwF66xBR4c";
class OrderDetailPage extends StatelessWidget {
  late bool card ;
  late BuildContext contextmain;

  OrderDetailPage(this.contextmain,this.card);
  String? validatePassword(String value,BuildContext contextmain) {
    if (!(value.length > 2) && value.isNotEmpty) {
      return Languages.of(contextmain)!.Cvvshouldcontain3characters;
    }
    return null;
  }
  int count  = 0;

  final String postCreateIntentURL = "https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/stripepayment";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final StripeCard cards = StripeCard();
  final Stripe stripe = Stripe(
          "pk_test_51HzceuEwF66xBR4clyYKhf4KnccDrC2D9fWn0NpeIC2iHwfWjbe9NKDpJtANbZh2wZCyNFvL7A8rV9QzJv2LmbO100DBX1Uia4",
          // stripeAccount: stripeAcc,
          returnUrlForSca: "stripesdk://3ds.stripesdk.io",
      );
    showAlertDialog(BuildContext context, String title, String message) {
        showDialog(
                context: context,
                builder: (BuildContext context) {
                    return  AlertDialog(
                            title: Text(title),
                            content: Text(message),
                            actions: [
                                FlatButton(
                                        child: Text("OK"),
                                        onPressed: () => Navigator.of(context).pop(), // dismiss dialog
                                ),
                            ],
                    );
                },
        );
    }

        late String clientSecret;
        Map<String, dynamic>? paymentIntentRes, paymentMethod;
  Future<Map<String, dynamic>?> createPaymentIntent(StripeCard stripeCard, String customerEmail, context, price) async{
        try{
            paymentMethod = await stripe.api.createPaymentMethodFromCard(stripeCard);
            print("paymentMethod['id']");
            print(paymentMethod!['id']);
            clientSecret = await postCreatePaymentIntent(customerEmail, paymentMethod!['id'], price);
            print("clientSecret");
            print(clientSecret);
            // paymentIntentRes = await postConfirmPaymentIntent(clientSecret);
            paymentIntentRes = await stripe.api.retrievePaymentIntent(clientSecret);
            print("paymentIntentRes");
            print(paymentIntentRes);
        }catch(e){
            print("ERROR_CreatePaymentIntentAndSubmit: $e");
            showAlertDialog(context, "Error", "Something went wrong.");
        }
        return paymentIntentRes;
    }

    Future<String> postCreatePaymentIntent(String email, String paymentMethodId, price) async{
      print('price');
      print(price.round().toString());
        String clientSecret;
        http.Response response = await http.post(
                Uri.parse("https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/stripepayments"),
                headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode(<String, String>{
                    'email': email,
                    'payment_method_id' : paymentMethodId,
                    'price': price.round().toString(),
                    'currency': 'eur',
                    'stripeaccount': stripeAcc,
                }),
        );
        print(json.decode(response.body));
        print(json.decode(response.body)["client_secret"]);
        clientSecret = json.decode(response.body)["client_secret"];
        return clientSecret;
    }

        // String clientSecret;
    postConfirmPaymentIntent(String clientSecret) async{
        http.Response response = await http.get(
                Uri.parse("https://api.stripe.com/v1/payment_intents/"+clientSecret),
                headers: <String, String>{
                    // 'Content-Type': 'application/json; charset=UTF-8',
                    'Authorization': 'sk_test_51HzceuEwF66xBR4cUrJWBeJVGHR5cWL4YdVLqh7kRVrp9ezgxr6mm6fGbp6APLIWF5zK0alUoyLCz5R2dzbwoUSD00tQ06ghYy'
                }
        );
        print("postConfirmPaymentIntent");
        print(json.decode(response.body));
        // print(json.decode(response.body)["id"]);
        // clientSecret = json.decode(response.body)["id"];
        return json.decode(response.body);
    }

        late Map<String, dynamic> paymentIntentRes_3dSecure;
    Future<Map<String, dynamic>> confirmPayment3DSecure(String clientSecret, String paymentMethodId, context) async{
        try{
            await stripe.confirmPayment(clientSecret, paymentMethodId: paymentMethodId);
            paymentIntentRes_3dSecure = await stripe.api.retrievePaymentIntent(clientSecret);
            print('paymentIntentRes_3dSecure');
            print(paymentIntentRes_3dSecure);
        }catch(e){
            print("ERROR_ConfirmPayment3DSecure: $e");
            showAlertDialog(context, "Error", "Something went wrong.");
        }
        return paymentIntentRes_3dSecure;
    }

createorder(provider, context, contextmain, status, paymentIntentId, requireAction, paymentMethodId)async {
    provider.setforwaiting();
    double shipping_price = double.parse(provider.getshippingDetail["price"].toString());
    double cashDelCharge  = double.parse(provider.cashPrice);
    double intprice = (double.parse(provider.getpricesummary["price"].toString())+shipping_price+cashDelCharge)*100;
    String price = intprice.toString();
    dynamic data1 = {
      "customer_id": provider.user_id,
      "payment_method": "Stripe",
      "payment_id": paymentIntentId,
      "cartid": provider.dddata["ii"],
      "currency": "eur",
      "price": price,
      "product_names": "",
      "selectedSizes": "",
      "order_status": status,//Delievered,Shipped,Canceled,Pending, Payment Pending, Payment Failed
      "discount": "0",
      "shipment_charges": provider.getshippingDetail,
      "orderid": paymentIntentId,
      "shipping_address": provider.getselectedaddress,
      "cartItems": provider.cartList,
      /*"pdfItems":provider.pdfItems*/
    };
    String body1 = json.encode(data1);
    print('provider.token');
    print(provider.token);
    var url1 = Uri.parse("https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/ordersuccess");
    http.Response response1 = await http.post(
        url1,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': provider.token,
        },
        body: body1
    );
    print(jsonDecode(response1.body)['code']);
    if(jsonDecode(response1.body)['code'] == 200){



        for(int i = 0 ;i<provider.localCartList.length;i++){
          Map<String, dynamic>  map = {
            "categorytype":provider.localCartList[i]["categorytype"],
            "id":provider.localCartList[i]["id"],
            "images":provider.localCartList[i]["images"],
            "productItem":provider.localCartList[i]["productItem"],
            "max_photo":provider.localCartList[i]["max_photo"],
            "min_photo":provider.localCartList[i]["min_photo"],
            "product_id":provider.localCartList[i]["product_id"],
            "product_price":provider.localCartList[i]["product_price"],
            "product_name":provider.localCartList[i]["product_name"],
            "slovaktitle":provider.localCartList[i]["slovaktitle"],
            "lasteditdate":provider.localCartList[i]["lasteditdate"],
            "pdfUrl":provider.localCartList[i]["pdfUrl"],
            "count":provider.localCartList[i]["count"],
            "order_status":"processing",
          };
          provider.localCartList.removeAt(i);
          provider.localCartList.insert(i, map);
          MemotiDbProvider.db.updateCart(provider.localCartList[i]).then((value) {
            print('value');
            print(value);
          });
            if(i==provider.localCartList.length-1){
              provider.closedwaiting();

      Future.delayed(Duration(milliseconds: requireAction?2000:500), () {
              showDialog(
                  context: context,
                  useRootNavigator: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Alert'),
                      content: setupAlertDialoadContainer( contextmain,context,Languages.of(contextmain)!.Thankufororderingfromuswewillcontactyousoon
                      ),);
                  });
      });
            }
        }
          
      if(requireAction){
        paymentIntentRes = await confirmPayment3DSecure(clientSecret, paymentMethodId, context);
        print('paymentIntentRes');
        print(paymentIntentRes);
        if(paymentIntentRes!['status'] == 'succeeded'){

            // showAlertDialog(context, "Success", "Thanks for buying!");
            // return;
        }     

      }
    }
}

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    if (count==0) {
      count++;
      print(provider.getpricesummary["price"]);
      provider.initOrderDeatail(card,context);
    }
  /*  if(!provider.firstcall){
      print(provider.getpricesummary["price"]);
      provider.initOrderDeatail(card,context);
    }*/
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
        title: Text(
          Languages.of(contextmain)!.OrderDetails,
          style:TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
      body: DirectSelectContainer(
        child:Stack(
          children: [
            ListView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              children: [
      Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
                offset: Offset(2, 2),
                blurRadius: 6,
                color: Colors.black26,
          )
          ]),
                // Card(
                //   elevation: 6,
                //   shadowcolor: Colors.black26,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: const BorderRadius.all(
                //       Radius.circular(12.0),
                //     ),
                //   ),
                  child: Container(
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
                          width: _width,
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          child: Text(
                            Languages.of(contextmain)!.ShippingAddress,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                wordSpacing: 1.5),
                          ),
                        ),
                        Container(

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                          child: Row(
                            children: [

                              Container(
                                padding: EdgeInsets.only(right: 24),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Center(
                                    child: Icon(
                                      Icons.check_circle,
                                      size: 45,
                                      color: MyColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Text(
                                          provider.getselectedaddress["title"],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                        child: Text(
    provider.getselectedaddress["address"],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Container(

                                        padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                        child: Text(
    provider.getselectedaddress["postCode"]+", "+provider.getselectedaddress["cityRegion"]+", "+provider.getselectedaddress["Country"],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Visibility(
                                visible: false,
                                child: Container(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        child: Text(
                                          Languages.of(contextmain)!.Edit,
                                          style: TextStyle(
                                            color: MyColors.primaryColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      GestureDetector(
                                        child: Icon(
                                          Icons.delete,
                                          color: MyColors.primaryColor,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),


                card?
      Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
                offset: Offset(2, 2),
                blurRadius: 6,
                color: Colors.black26,
          )
          ]),
                // Card(
                //   margin: EdgeInsets.only(top: 16),
                //   elevation: 6,
                //   shadowcolor: Colors.black26,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: const BorderRadius.all(
                //       Radius.circular(12.0),
                //     ),
                //   ),
                  child: Container(
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
                          width: _width,
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          child: Text(
                            Languages.of(contextmain)!.CardDetail,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                wordSpacing: 1.5),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 24),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Center(
                                    child: Icon(
                                      Icons.check_circle,
                                      size: 45,
                                      color: MyColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Text(
                                          provider.getcardDetail["cardHolderName"],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(

                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                        child: Text(
                                          provider.getcardDetail["cardNumber"],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                        child: TextField(
                                          maxLines: 1,
                                          inputFormatters: [LengthLimitingTextInputFormatter(3)],
                                          textAlign: TextAlign.left,
                                          controller: provider.cvvController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            errorText: validatePassword(provider.cvvController.text.trim(),contextmain),
                                            hintText: 'cvv',
                                            hintStyle: TextStyle(fontSize: 16),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: MyColors.primaryColor,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            filled: true,
                                            contentPadding: EdgeInsets.all(8),
                                            fillColor: Colors.white70,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      child: Text(
                                        provider.getcardDetail["expiryDate"],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
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
                ):Container(),
                // Card(
                //   margin: EdgeInsets.only(top: 16),
                //   elevation: 6,
                //   shadowcolor: Colors.black26,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: const BorderRadius.all(
                //       Radius.circular(12.0),
                //     ),
                //   ),
      Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
                offset: Offset(2, 2),
                blurRadius: 6,
                color: Colors.black26,
          )
          ]),
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
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          width: _width,
                          child: Text(
                            Languages.of(contextmain)!.PriceSummary,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                wordSpacing: 1.5),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 0.80,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Languages.of(contextmain)!.ItemPrice,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      wordSpacing: 1.5),
                                ),
                                Text(
                                  double.parse(provider.getpricesummary["price"]).toStringAsFixed(2)+" €",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      wordSpacing: 1.5),
                                ),
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 0.80,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  langcode=="en" || langcode=="en_"?provider.getshippingDetail["title"]:provider.getshippingDetail["slovak"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      wordSpacing: 1.5),
                                ),
                                Text(
                                  double.parse(provider.getshippingDetail["price"].toString()).toStringAsFixed(2)+" €",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      wordSpacing: 1.5),
                                ),
                              ],
                            )),
                        card? Container():Container(
                            padding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 0.80,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Languages.of(contextmain)!.CashonDelievery,
                                  style: TextStyle(

                                      fontSize: 20,
                                      color: Colors.black,
                                      wordSpacing: 1.5),
                                ),
                                Text(provider.cashPrice+" €",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      wordSpacing: 1.5),
                                ),
                              ],
                            )),
                        /* provider.dataGet? Container(child: dsl,padding: EdgeInsets.fromLTRB(12, 0, 12, 0),):Container(),*/
                        /* Container(
                            padding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 0.80,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Shipping Price",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      wordSpacing: 1.5),
                                ),
                                Text(
                                  "0 €",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      wordSpacing: 1.5),
                                ),
                              ],
                            )),*/
                        // Container(
                        //     padding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       border: Border(
                        //         bottom: BorderSide(
                        //           color: Colors.grey,
                        //           width: 0.80,
                        //         ),
                        //       ),
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text(
                        //           "Shipping & payment",
                        //           style: TextStyle(
                        //               fontSize: 20,
                        //               color: Colors.black,
                        //               wordSpacing: 1.5),
                        //         ),
                        //         Text(
                        //           "4.99 €",
                        //           style: TextStyle(
                        //               fontSize: 20,
                        //               color: Colors.black,
                        //               wordSpacing: 1.5),
                        //         ),
                        //       ],
                        //     )),
                        // Container(
                        //   alignment: Alignment.centerLeft,
                        //   padding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //   ),
                        //   child: Text(
                        //     "Promo/Referral Code?",
                        //     style: TextStyle(
                        //         fontSize: 20,
                        //         color: MyColors.primaryColor,
                        //         wordSpacing: 1.5),
                        //   ),
                        // ),
                        Container(
                            decoration: BoxDecoration(
                              color: HexColor("#F5F5F7"),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0),
                              ),
                            ),
                            padding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Languages.of(contextmain)!.TotalPrice,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      wordSpacing: 1.5),
                                ),
                                Text(
                                  provider.total_price+" €",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      wordSpacing: 1.5),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: provider.agree,
                        onChanged: (value) {
                          provider.setcheckboxOrderDeatail(value!);
                        },
                      ),
                      Expanded(
                        child: Text(
                          Languages.of(contextmain)!.Ihavereadandaccepttermsandconditions,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                  // Container(
                  //   // local_cart_id
                  // height: 100,
                  // width: 100,
                  // child:Center(child:InkWell(child: Text("PDF"), onTap: () {

                  //     print(provider.pdfItems);
                  //     print(provider.localCartList[0]["pdfUrl"]);
                  //     return;

                  //   // provider.openpdf(context);
                  // },))),
                        // CardForm(
                        //         formKey: formKey,
                        //         card: cards
                        // ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 36.0, 0.0, 0.0),
                  child: Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * 1.0,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: 
                              ElevatedButton(
                                child: Text(
                                  Languages.of(contextmain)!.Cancel
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
                                      fontSize: 14,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => TabsPage(),
                                    ),
                                        (route) => false,
                                  );
                                },
                              )
                            // RaisedButton(
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(25)),
                            //   color: MyColors.primaryColor,
                            //   onPressed: () {
                            //     Navigator.pushAndRemoveUntil(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (BuildContext context) => TabsPage(),
                            //       ),
                            //           (route) => false,
                            //     );
                            //   },

                            //   child: Text(Languages.of(contextmain)!.Cancel,
                            //       style: TextStyle(
                            //           letterSpacing: 2,
                            //           wordSpacing: 2,
                            //           color: Colors.white,
                            //           fontSize: 18)),
                            // ),
                          ),
                        ),
                        SizedBox(width: 24,),
                        provider.pdfuploading()? Expanded(child: Center(child:Container(width: 18, height: 18, child:CircularProgressIndicator())) ): Expanded(
                          child: Container(
                            child:  Container(
                              child: 
                                ElevatedButton(
                                  child: Text(
                                    Languages.of(contextmain)!.submit
                                    // ""
                                    ),
                                  style: ElevatedButton.styleFrom(
                                    primary: provider.agree?MyColors.primaryColor:Colors.grey,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(30.0),
                                    ),
                                    side: BorderSide(color: provider.agree?MyColors.primaryColor:Colors.grey),
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                    ),
                                  ),
                                  onPressed: provider.agree ?() async{
                                    // formKey.currentState.save();
                                    DateTime now = DateTime.now();
                                    print('card');
                                    print(card);
                                    // return;
                                    if(card){
                                      if(provider.cvvController.text.trim().length==3){
                                        provider.setforwaiting();
                                        int month = int.parse(provider.getcardDetail["expiryDate"].split('/')[0].toString());
                                        int year = int.parse(provider.getcardDetail["expiryDate"].split('/')[1].toString());
                                        print(provider.cvvController.text.toString());
                                        print("Stripe pluggin");
                                        print("Stripe pluggin");
                                        print("Stripe pluggin");
                                        print(provider.getemail());
                                        // return;

                                        cards.cvc = provider.cvvController.text.toString();
                                        cards.expMonth = int.parse(provider.getcardDetail["expiryDate"].split('/')[0]) as int;
                                        cards.expYear = int.parse(provider.getcardDetail["expiryDate"].split('/')[1]) as int;
                                        cards.number = provider.getcardDetail["cardNumber"].toString();
                                        cards.last4 = provider.getcardDetail["cardNumber"].toString().substring(provider.getcardDetail["cardNumber"].toString().length - 4);


                                        // print(cards.cvc);
                                        final StripeCard stripeCard = cards;

        if(!stripeCard.validateCVC()){showAlertDialog(context, "Error", "CVC not valid."); return;}
        if(!stripeCard.validateDate()){showAlertDialog(context, "Errore", "Date not valid."); return;}
        if(!stripeCard.validateNumber()){showAlertDialog(context, "Error", "Number not valid."); return;}



                                        Map<String, dynamic>? paymentIntentRes = await createPaymentIntent(stripeCard, "dev1@yopmail.com", context, double.parse(
                                          provider.total_price
                                          )*100);
                                        print("paymentIntentRes");
                                        print(paymentIntentRes);
                                        String clientSecret = paymentIntentRes!['client_secret'];
                                        String paymentMethodId = paymentIntentRes['payment_method'];
                                        String status = paymentIntentRes['status']; 
                                        print("status");
                                        print(status);
                                        if(status == 'requires_action'){

                                            createorder(provider, context, contextmain, 'Payment Pending', paymentIntentRes!['id'], true, paymentMethodId);

                                        } //3D secure is enable in this card
                                      else{
                                        
                                            createorder(provider, context, contextmain, 'Pending', paymentIntentRes!['id'], false, paymentMethodId);
                                      }


                                        // return;
                                        // if(paymentIntentRes['status'] != 'succeeded'){
                                        //     showAlertDialog(context, "Warning", "Canceled Transaction.");
                                        //     return;
                                        // }

                                        // showAlertDialog(context, "Warning", "Transaction rejected.\nSomething went wrong");






                                      }else {
                                        showDialog(
                                            context: context,
                                            useRootNavigator: false,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(Languages.of(contextmain)!.Alert
                                                ),
                                                content: setupcvvErrorDialog(contextmain, context,Languages.of(contextmain)!.Cvvshouldcontain3characters
                                                ),);
                                            });
                                      }
                                    }else{
                                      provider.setforwaiting();
                                      double shipping_price = double.parse(provider.getshippingDetail["price"].toString());
                                      double cashDelCharge  = double.parse(provider.cashPrice);
                                      double intprice = (double.parse(provider.getpricesummary["price"].toString())+shipping_price+cashDelCharge)*100;
                                      String price = intprice.toString();
                                      dynamic data1 = {
                                        "customer_id": provider.user_id,
                                        "payment_method": "COD",
                                        "cartid": provider.dddata["ii"],
                                        "currency": "eur",
                                        "price": price,
                                        "product_names": "",
                                        "selectedSizes": "",
                                        "order_status": "Pending",//Delievered,Shipped,Canceled,Pending
                                        "discount": "0",
                                        "shipment_charges": provider.getshippingDetail,
                                        "orderid": "",
                                        "shipping_address": provider.getselectedaddress,
                                        "cartItems": provider.cartList,
                                        /*"pdfItems":provider.pdfItems*/
                                      };
                                      String body1 = json.encode(data1);
                                      print(data1);
                                      print(body1);
                                      var url1 = Uri.parse("https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/ordersuccess");
                                      http.Response response1 = await http.post(
                                          url1,
                                          headers: <String, String>{
                                            'Content-Type': 'application/json; charset=UTF-8',
                                            'Authorization': provider.token,
                                          },
                                          body: body1
                                      );
                                      for(int i = 0 ;i<provider.localCartList.length;i++){
                                        Map<String, dynamic>  map = {
                                          "categorytype":provider.localCartList[i]["categorytype"],
                                          "id":provider.localCartList[i]["id"],
                                          "images":provider.localCartList[i]["images"],
                                          "productItem":provider.localCartList[i]["productItem"],
                                          "max_photo":provider.localCartList[i]["max_photo"],
                                          "min_photo":provider.localCartList[i]["min_photo"],
                                          "product_id":provider.localCartList[i]["product_id"],
                                          "product_price":provider.localCartList[i]["product_price"],
                                          "product_name":provider.localCartList[i]["product_name"],
                                          "slovaktitle":provider.localCartList[i]["slovaktitle"],
                                          "lasteditdate":provider.localCartList[i]["lasteditdate"],
                                          "pdfUrl":provider.localCartList[i]["pdfUrl"],
                                          "count":provider.localCartList[i]["count"],
                                          "order_status":"processing",
                                        };
                                        provider.localCartList.removeAt(i);
                                        provider.localCartList.insert(i, map);
                                        MemotiDbProvider.db.updateCart(provider.localCartList[i]).then((value) {
                                          if(i==provider.localCartList.length-1){
                                            provider.closedwaiting();
                                            showDialog(
                                                context: context,
                                                useRootNavigator: false,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('Alert'),
                                                    content: setupAlertDialoadContainer( contextmain,context,Languages.of(contextmain)!.Thankufororderingfromuswewillcontactyousoon
                                                    ),);
                                                });
                                          }
                                        });
                                      }
                                    }
                                  }:null,
                                )
                              // RaisedButton(
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(25)),
                              //   color: provider.agree?MyColors.primaryColor:Colors.grey,
                              //   onPressed: provider.agree ?() async {
                              //     if(card){
                              //       if(provider.cvvController.text.trim().length==3){
                              //         provider.setforwaiting();
                              //         int month = int.parse(provider.getcardDetail["expiryDate"].split('/')[0].toString());
                              //         int year = int.parse(provider.getcardDetail["expiryDate"].split('/')[1].toString());
                              //         print(provider.cvvController.text.toString());
                              //         var url = Uri.parse("https://api.stripe.com/v1/payment_methods");

                              //         http.post(url,
                              //             headers: <String, String>{
                              //               'Content-Type': 'application/x-www-form-urlencoded',
                              //               'Authorization': 'Bearer sk_test_51HzceuEwF66xBR4cUrJWBeJVGHR5cWL4YdVLqh7kRVrp9ezgxr6mm6fGbp6APLIWF5zK0alUoyLCz5R2dzbwoUSD00tQ06ghYy',
                              //             },
                              //             body: {
                              //               'card[number]': provider.getcardDetail["cardNumber"].toString(),
                              //               'type' : 'card',
                              //               'card[exp_month]' : provider.getcardDetail["expiryDate"].split('/')[0].toString(),
                              //               'card[exp_year]' : provider.getcardDetail["expiryDate"].split('/')[1].toString(),
                              //               'card[cvc]' : provider.cvvController.text.toString(),
                              //             },
                              //             encoding: Encoding.getByName("utf-8")
                              //         ).then((response1) async {
                              //           print(json.decode(response1.body));
                              //           print(json.decode(response1.body)["id"]);
                              //           SharedPreferences preferences  = await SharedPreferences.getInstance();

                              //           double shipping_price = double.parse(provider.getshippingDetail["price"].toString());
                              //           double intprice = ((double.parse(provider.getpricesummary["price"])+shipping_price))*100;
                              //           String price = intprice.toStringAsFixed(0);
                              //           print(price);
                              //           var url = Uri.parse("https://api.stripe.com/v1/payment_intents");
                              //           http.post(
                              //               url,
                              //               headers: <String, String>{
                              //                 'Content-Type': 'application/x-www-form-urlencoded',
                              //                 'Authorization': 'Bearer sk_test_51HzceuEwF66xBR4cUrJWBeJVGHR5cWL4YdVLqh7kRVrp9ezgxr6mm6fGbp6APLIWF5zK0alUoyLCz5R2dzbwoUSD00tQ06ghYy',
                              //               },
                              //               body: {
                              //                 'payment_method_types[]': 'card',
                              //                 'payment_method' : json.decode(response1.body)["id"],
                              //                 'currency' : "eur",
                              //                 'amount' : price,
                              //               },
                              //               encoding: Encoding.getByName("utf-8")
                              //           ).then((response) {

                              //             print(jsonDecode(response.body));
                              //             Map<String, dynamic> map = jsonDecode(response.body);
                              //             var url = Uri.parse("https://api.stripe.com/v1/payment_intents/"+map["id"]+"/confirm");
                              //             http.post(
                              //               url,
                              //               headers: <  String, String>{
                              //                 'Content-Type': 'application/x-www-form-urlencoded',
                              //                 'Authorization': 'Bearer sk_test_51HzceuEwF66xBR4cUrJWBeJVGHR5cWL4YdVLqh7kRVrp9ezgxr6mm6fGbp6APLIWF5zK0alUoyLCz5R2dzbwoUSD00tQ06ghYy',
                              //               },
                              //               body: {'payment_method' : "pm_card_visa"},
                              //             ).then((value) async {
                              //               print(jsonDecode(value.body));
                              //               dynamic data = {
                              //                 "customer_id": provider.user_id,
                              //                 "payment_method": "stripe",
                              //                 "cartid": provider.dddata["ii"],
                              //                 "currency": "eur",
                              //                 "price": price,
                              //                 "product_names": "",
                              //                 "selectedSizes": "",
                              //                 "order_status": "Pending",//Delievered,Shipped,Canceled,Pending
                              //                 "discount": "0",
                              //                 "shipment_charges": provider.getshippingDetail,
                              //                 "shipping_address": provider.getselectedaddress,
                              //                 "orderid": json.decode(value.body)["id"],
                              //                 "cartItems": provider.cartList,
                              //                 //"pdfItems": provider.pdfItems
                              //               };
                              //               String body = json.encode(data);
                              //               var url = Uri.parse("https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/ordersuccess");
                              //               http.Response response = await http.post(
                              //                   url,
                              //                   headers: <String, String>{
                              //                     'Content-Type': 'application/json; charset=UTF-8',
                              //                     'Authorization': provider.token,
                              //                   },
                              //                   body: body
                              //               );

                              //               print(response.body);
                              //               for(int i = 0 ;i<provider.localCartList.length;i++){
                              //                 Map<String, dynamic>  map = {
                              //                   "categorytype":provider.localCartList[i]["categorytype"],
                              //                   "images":provider.localCartList[i]["images"],
                              //                   "id":provider.localCartList[i]["id"],
                              //                   "productItem":provider.localCartList[i]["productItem"],
                              //                   "max_photo":provider.localCartList[i]["max_photo"],
                              //                   "min_photo":provider.localCartList[i]["min_photo"],
                              //                   "product_id":provider.localCartList[i]["product_id"],
                              //                   "product_price":provider.localCartList[i]["product_price"],
                              //                   "product_name":provider.localCartList[i]["product_name"],
                              //                   "slovaktitle":provider.localCartList[i]["slovaktitle"],
                              //                   "lasteditdate":provider.localCartList[i]["lasteditdate"],
                              //                   "pdfUrl":provider.localCartList[i]["pdfUrl"],
                              //                   "count":provider.localCartList[i]["count"],
                              //                   "order_status":"processing",
                              //                 };
                              //                 provider.localCartList.removeAt(i);
                              //                 provider.localCartList.insert(i, map);
                              //                 MemotiDbProvider.db.updateCart(provider.localCartList[i]).then((value) {
                              //                   if(i==provider.localCartList.length-1){
                              //                     provider.closedwaiting();
                              //                     showDialog(
                              //                         context: context,
                              //                         useRootNavigator: false,
                              //                         builder: (BuildContext context) {
                              //                           return AlertDialog(
                              //                             title: Text('Alert'),
                              //                             content: setupAlertDialoadContainer( contextmain,context,Languages.of(contextmain)!.Thankufororderingfromuswewillcontactyousoon
                              //                             ),);
                              //                         });
                              //                   }
                              //                 });
                              //               }
                              //             });
                              //           });
                              //         });
                              //       }else {
                              //         showDialog(
                              //             context: context,
                              //             useRootNavigator: false,
                              //             builder: (BuildContext context) {
                              //               return AlertDialog(
                              //                 title: Text(Languages.of(contextmain)!.Alert
                              //                 ),
                              //                 content: setupcvvErrorDialog(contextmain, context,Languages.of(contextmain)!.Cvvshouldcontain3characters
                              //                 ),);
                              //             });
                              //       }
                              //     }else{
                              //       provider.setforwaiting()
                              //       double shipping_price = double.parse(provider.getshippingDetail["price"].toString());
                              //       double cashDelCharge  = double.parse(provider.cashPrice);
                              //       double intprice = (double.parse(provider.getpricesummary["price"].toString())+shipping_price+cashDelCharge)*100;
                              //       String price = intprice.toString();
                              //       dynamic data1 = {
                              //         "customer_id": provider.user_id,
                              //         "payment_method": "COD",
                              //         "cartid": provider.dddata["ii"],
                              //         "currency": "eur",
                              //         "price": price,
                              //         "product_names": "",
                              //         "selectedSizes": "",
                              //         "order_status": "Pending",//Delievered,Shipped,Canceled,Pending
                              //         "discount": "0",
                              //         "shipment_charges": provider.getshippingDetail,
                              //         "orderid": "",
                              //         "shipping_address": provider.getselectedaddress,
                              //         "cartItems": provider.cartList,
                              //         /*"pdfItems":provider.pdfItems*/
                              //       };
                              //       String body1 = json.encode(data1);
                              //       print(data1);
                              //       print(body1);
                              //       var url1 = Uri.parse("https://k6fq53z7n4.execute-api.eu-central-1.amazonaws.com/latest/ordersuccess");
                              //       http.Response response1 = await http.post(
                              //           url1,
                              //           headers: <String, String>{
                              //             'Content-Type': 'application/json; charset=UTF-8',
                              //             'Authorization': provider.token,
                              //           },
                              //           body: body1
                              //       );
                              //       print(response1.body);
                              //       for(int i = 0 ;i<provider.localCartList.length;i++){
                              //         Map<String, dynamic>  map = {
                              //           "categorytype":provider.localCartList[i]["categorytype"],
                              //           "id":provider.localCartList[i]["id"],
                              //           "images":provider.localCartList[i]["images"],
                              //           "productItem":provider.localCartList[i]["productItem"],
                              //           "max_photo":provider.localCartList[i]["max_photo"],
                              //           "min_photo":provider.localCartList[i]["min_photo"],
                              //           "product_id":provider.localCartList[i]["product_id"],
                              //           "product_price":provider.localCartList[i]["product_price"],
                              //           "product_name":provider.localCartList[i]["product_name"],
                              //           "slovaktitle":provider.localCartList[i]["slovaktitle"],
                              //           "lasteditdate":provider.localCartList[i]["lasteditdate"],
                              //           "pdfUrl":provider.localCartList[i]["pdfUrl"],
                              //           "count":provider.localCartList[i]["count"],
                              //           "order_status":"processing",
                              //         };
                              //         provider.localCartList.removeAt(i);
                              //         provider.localCartList.insert(i, map);
                              //         MemotiDbProvider.db.updateCart(provider.localCartList[i]).then((value) {
                              //           if(i==provider.localCartList.length-1){
                              //             provider.closedwaiting();
                              //             showDialog(
                              //                 context: context,
                              //                 useRootNavigator: false,
                              //                 builder: (BuildContext context) {
                              //                   return AlertDialog(
                              //                     title: Text('Alert'),
                              //                     content: setupAlertDialoadContainer( contextmain,context,Languages.of(contextmain)!.Thankufororderingfromuswewillcontactyousoon
                              //                     ),);
                              //                 });
                              //           }
                              //         });
                              //       }
                              //     }
                              //   }:null,
                              //   child: Text(Languages.of(contextmain)!.submit,
                              //       style: TextStyle(
                              //           letterSpacing: 2,
                              //           wordSpacing: 2,
                              //           color: Colors.white,
                              //           fontSize: 18)),
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            provider.waiting?Center(child: CircularProgressIndicator(),):Container(),
          ],
        ),
      ),
    );
  }
}

  // Future<void> _handlePayPress(_card, context) async {
  //   await Stripe.instance.dangerouslyUpdateCardDetails(_card);

  //   try {
  //     // 1. Gather customer billing information (ex. email)

  //     final billingDetails = BillingDetails(
  //       email: 'email@stripe.com',
  //       phone: '+48888000888',
  //       address: Address(
  //         city: 'Houston',
  //         country: 'US',
  //         line1: '1459  Circle Drive',
  //         line2: '',
  //         state: 'Texas',
  //         postalCode: '77063',
  //       ),
  //     ); // mocked data for tests

  //     // 2. Create payment method
  //     final paymentMethod =
  //         await Stripe.instance.createPaymentMethod(PaymentMethodParams.card(
  //       paymentMethodData: PaymentMethodData(
  //         billingDetails: billingDetails,
  //       ),
  //     ));

  //     // 3. call API to create PaymentIntent
  //     final paymentIntentResult = await callNoWebhookPayEndpointMethodId(
  //       useStripeSdk: true,
  //       paymentMethodId: paymentMethod.id,
  //       currency: 'usd', // mocked data
  //       items: [
  //         {'id': 'id'}
  //       ],
  //     );

  //     if (paymentIntentResult['error'] != null) {
  //       // Error during creating or confirming Intent
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Error: ${paymentIntentResult['error']}')));
  //       return;
  //     }

  //     if (paymentIntentResult['clientSecret'] != null &&
  //         paymentIntentResult['requiresAction'] == null) {
  //       // Payment succedeed

  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content:
  //               Text('Success!: The payment was confirmed successfully!')));
  //       return;
  //     }

  //     if (paymentIntentResult['clientSecret'] != null &&
  //         paymentIntentResult['requiresAction'] == true) {
  //       // 4. if payment requires action calling handleNextAction
  //       final paymentIntent = await Stripe.instance
  //           .handleNextAction(paymentIntentResult['clientSecret']);

  //       if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
  //         // 5. Call API to confirm intent
  //         await confirmIntent(paymentIntent.id);
  //       } else {
  //         // Payment succedeed
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //             content: Text('Error: ${paymentIntentResult['error']}')));
  //       }
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('Error: $e')));
  //     rethrow;
  //   }
  // }

Widget setupcvvErrorDialog(BuildContext contextmain,BuildContext context, String text) {
  return Container(
    height: 150.0, // Change as per your requirement
    width: 150.0, // Change as per your requirement
    child:Column(
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
                fontSize: 18,
                fontWeight: FontWeight.w600
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
        //             fontWeight: FontWeight.w600,
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


Widget setupAlertDialoadContainer(BuildContext contextmain,BuildContext context, String text) {
  return Container(
    height: 150.0, // Change as per your requirement
    width: 150.0, // Change as per your requirement
    child:Column(
      children: [
        Text(text),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          child: Text(
            Languages.of(contextmain)!.Close
            ),
          style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
            ),
            side: BorderSide(color: MyColors.primaryColor),
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => TabsPage(),
              ),
                  (route) => false,
            );
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
        //             fontWeight: FontWeight.w600,
        //             fontSize: 18
        //         ),
        //       ),
        //     ),
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //     Navigator.pushAndRemoveUntil(
        //       context,
        //       MaterialPageRoute(
        //         builder: (BuildContext context) => /*HomeTabsPage(contextmain,3,"")*/TabsPage(),
        //       ),
        //           (route) => false,
        //     );
        //   },),
      ],
    ),
  );
}