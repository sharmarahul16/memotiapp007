
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memotiapp/pages/signup.dart';
import 'package:provider/provider.dart';
import 'package:memotiapp/provider/appaccess.dart';
import 'package:memotiapp/provider/statics.dart';

import 'package:memotiapp/localization/language/languages.dart';
import 'package:memotiapp/localization/locale_constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  String? edtEmailrror = null;
  String? edtPasswordError = null;  
  TextEditingController edtEmailController = TextEditingController();
  TextEditingController edtPasswordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    edtEmailController.clear();
    edtPasswordController.clear();
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);  

    return WillPopScope(
      onWillPop: () {
        print("fdfff");
        print("cffff");
        print(provider.ispreviewPage);
        if(provider.ispreviewPage){
          print("cffff");
          provider.ispreviewPage = false;
          SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
        }
        Navigator.pop(context, false);
        return new Future(() => false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img/account_bg.png'),
                  fit: BoxFit.fill)),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        padding: EdgeInsets.all(16),
                        icon: Icon(Icons.clear, color: Colors.white),
                        onPressed: () {
                          print("Close");
                          if(provider.ispreviewPage){
                            provider.ispreviewPage = false;
                            SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                      SingleChildScrollView(
      child: Column(
        children: <Widget> [
          Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 00),
            width: 200,
            height: 50,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/white_logo.png'),
                    fit: BoxFit.fill))),
        Container(
            alignment: Alignment.center,
            margin:
            EdgeInsets.only(top: 60),
            child: Image(
              width: 90,
              height: 90,
              image: AssetImage("assets/img/Icon_BigKey.png"),
            )),
        SizedBox(
          height: 30.0,
        ),
        Text(
  Languages
        .of(context)!
        .WelcomeBack,
          style: TextStyle(
              fontWeight: FontWeight.w700, color: Colors.white, fontSize: 20),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          Languages
              .of(context)!
              .Chooseyoursigninmethodbelow,
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ],
  ),
        Container(
      margin: EdgeInsets.only(top: 30,left: 32,right: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: edtEmailController, maxLines: 1, keyboardType: TextInputType.emailAddress, textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white, height: 1, fontSize: 16),
            onChanged: (value) {
              setState(() {
                if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value.toString().trim())||value.isEmpty)  {
                  edtEmailrror = "Please enter a valid Email.";
                }else{
                  edtEmailrror = null;
                }
              });
              print(value);
            },
            decoration: InputDecoration(
                errorText: edtEmailrror,
                hintText: Languages.of(context)!.Enteryouremail,
                suffixIcon:  Icon(Icons.email, size: 20, color: Colors.white),
                errorStyle: TextStyle(color: Colors.red[400], wordSpacing: 5.0,),
                hintStyle: TextStyle(color: Colors.white, height: 1, fontSize: 15),
                contentPadding: EdgeInsets.all(20.0),
                border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(40.0), borderSide: new BorderSide(color: Colors.white, width: 2),),
                labelStyle: TextStyle(color: MyColors.primaryColor, letterSpacing: 1.3),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2), borderRadius: BorderRadius.circular(40.0),),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2), borderRadius: BorderRadius.circular(40.0),)
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: edtPasswordController, maxLines: 1, keyboardType: TextInputType.text, textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white, height: 1, fontSize: 16),
            onChanged: (value) {
              setState(() {
                if (value.toString().trim().length<8) {
                  edtPasswordError = "Password length should be 8.";
                }else{
                  edtPasswordError = null;
                }
              });
              print(value);
            },
            obscureText: true,
            decoration: InputDecoration(
                errorText: edtPasswordError,
                hintText: Languages.of(context)!.Password,
                suffixIcon:  Icon(Icons.lock, size: 20, color: Colors.white),
                errorStyle: TextStyle(color: Colors.red[400], wordSpacing: 5.0,),
                hintStyle: TextStyle(color: Colors.white, height: 1, fontSize: 15),
                contentPadding: EdgeInsets.all(20.0),
                border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(40.0), borderSide: new BorderSide(color: Colors.white, width: 2),),
                labelStyle: TextStyle(color: MyColors.primaryColor, letterSpacing: 1.3),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2), borderRadius: BorderRadius.circular(40.0),),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2), borderRadius: BorderRadius.circular(40.0),)
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          provider.busy?Center(child: CircularProgressIndicator()):
          Container(
            width: 290,
            margin: EdgeInsets.only(bottom: 20),
            height: 55,
            child: RaisedButton(
              shape: StadiumBorder(),
              child: Text(
                Languages
                    .of(context)!
                    .Login,
                style: TextStyle(color: MyColors.primaryColor, fontSize: 20),
              ),
              color: Colors.white,
              onPressed: () {
                 if(edtPasswordController.text.trim().length<8){
                  _showToast(context, "Password length should be 8.");
                }else if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(edtEmailController.text.trim())){
                  _showToast(context, "Please enter a valid Email.");
                }else{
                  FocusScope.of(context).unfocus();
                  provider.loginUser(context,edtEmailController.text.toString().trim(),edtPasswordController.text.toString().trim(), false);

                  // _showToast(context, "Please fill all detail");
                }
              },
            ),
          ),
          Container(
            width: 290,
            margin: EdgeInsets.only(top: 10, bottom: 10),
            height: 2.0,
            color: Colors.white,
          ),
          InkWell(
            onTap: ()=>Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupPage()),),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Languages.of(context)!.Donthaveanaccount,
                  style: TextStyle(color: HexColor("7BF7FA")),
                ),
                InkWell(
                  child: Text(
                    Languages.of(context)!.SignUp,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),);
                  },
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              provider.facebook_logins(context);
              // provider.facebook_login(context);
            },
            child: Container(
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
              Text(
                Languages.of(context)!.ContinueWithFacebook,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ))
          // WithFbButton(
          //     text: Languages.of(context)!.ContinueWithFacebook,
          //   ),
          )
        ],
      ),
  ),
        ],
      ),
  )
                    ],
                  ),
                ),
              ),
              case2(provider.status, {
               "true": DialogCard(context,provider),
               "false": DialogCard(context,provider),
               "": Container(),
              },Container()),
            ]
          ),
        ),
      ),
    );

    
  }

// TValue 
case2<TOptionType, TValue>(
  TOptionType selectedOption,
  Map<TOptionType, TValue> branches, [
  TValue? defaultValue
]) {
  if (!branches.containsKey(selectedOption)) {
    return defaultValue;
  }

  return branches[selectedOption];
}
  DialogCard(BuildContext context, provider) => Positioned(top: 0,bottom: 0,right: 0,left: 0,
    child: Container(
      color: Colors.black.withOpacity(0.7),
      child: GestureDetector(
          onTap: (){
          },
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width*0.7,
              height: MediaQuery.of(context).size.height*0.38,
              child: Card(
                color: Colors.white,
                elevation: 12,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        provider.dialog_icon,
                        color: MyColors.primaryColor,
                        size: 50,
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      Text(provider.msg,textAlign: TextAlign.center,
                        style: TextStyle(color: MyColors.primaryColor,fontSize: 16,fontWeight: FontWeight.bold),),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        width: 100,
                        height: 45,
                        child: RaisedButton(
                          shape: StadiumBorder(),
                          child: Text(
                            "Ok",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          color: MyColors.primaryColor,
                          onPressed: () {
                            if(provider.status=="true"){
                              provider.closedDialogl();
                              if(provider.ispreviewPage){
                                provider.ispreviewPage = false;
                                SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
                              }
                              Navigator.pop(context,"true");
                            }else{
                              provider.closedDialogl();
                              if(provider.ispreviewPage){
                                provider.ispreviewPage = false;
                                SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
                              }
                              Navigator.pop(context,"false");
                            }  },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
      ),
    ),);

  void _showToast(BuildContext context, String error) {
    print("showtoasterror");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  }
}