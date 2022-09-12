
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:memotiapp/main.dart';
import 'package:memotiapp/pages/login.dart';
import 'package:provider/provider.dart';
import 'package:memotiapp/provider/appaccess.dart';
import 'package:memotiapp/provider/statics.dart';

import 'package:memotiapp/localization/language/languages.dart';
import 'package:memotiapp/localization/locale_constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  String? edtPasswordError = null;
  String? edtFnameError = null;
  String?  edtlnameError = null;
  String? edtEmailrror = null;
  String? edtPhoneNumberError = null;
  TextEditingController edtFnameController = TextEditingController();
  TextEditingController edtlnameController = TextEditingController();
  TextEditingController edtEmailController = TextEditingController();
  TextEditingController edtPhoneNumberController = TextEditingController();
  TextEditingController edtPasswordController = TextEditingController();
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    edtFnameController.clear();
    edtlnameController.clear();
    edtEmailController.clear();
    edtPhoneNumberController.clear();
    edtPasswordController.clear();
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);  

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/account_bg.png'),
                fit: BoxFit.fill)),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    padding: EdgeInsets.all(16),
                    icon: Icon(Icons.clear, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 0),
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/white_logo.png'),
                      fit: BoxFit.fill))),
          Container(
              alignment: Alignment.center,
              margin:
                  EdgeInsets.only(top: SizeConfig.accountImagePlacementHeight),
              child: Image(
                width: 80,
                height: 80,
                image: AssetImage("assets/img/Icon_BigLock.png"),
              )),
          SizedBox(
            height: 10.0,
          ),
          Text(
            Languages.of(context)!.Createanewaccount,
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            Languages.of(context)!.SignUpHere,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ],
      ), 
            Container(
        margin: EdgeInsets.only(top: 30,left: 32,right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: edtFnameController,
              maxLines: 1,
              keyboardType: TextInputType.name,
              //expands: false,
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.white, height: 1, fontSize: 16),
              decoration: InputDecoration(errorText: edtFnameError, hintText: Languages.of(context)!.FirstName,
                  suffixIcon:  Icon(FontAwesomeIcons.user, size: 20, color: Colors.white),
                  errorStyle: TextStyle(color: Colors.red[400], wordSpacing: 5.0,),
                  hintStyle: TextStyle(color: Colors.white, height: 1, fontSize: 15),
                  contentPadding: EdgeInsets.all(20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  labelStyle: TextStyle(color: MyColors.primaryColor, letterSpacing: 1.3),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(40.0),
                  )
              ),
              onChanged: (value) {
                setState(() {
                  if (value.toString().trim().length<3) {
                    edtFnameError = "Please enter atleast three alphabet.";
                  }else{
                    edtFnameError = null;
                  }
                });
                print(value);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: edtlnameController, maxLines: 1, keyboardType: TextInputType.name, textAlign: TextAlign.left,
              style: TextStyle(color: Colors.white, height: 1, fontSize: 16),
              onChanged: (value) {
                setState(() {
                  if (value.toString().trim().length<3) {
                    edtlnameError = "Please enter atleast three alphabet.";
                  }else{
                    edtlnameError = null;
                  }
                });
                print(value);
              },
              decoration: InputDecoration(
                  errorText: edtlnameError,
                  hintText: Languages.of(context)!.LastName,
                  suffixIcon:  Icon(FontAwesomeIcons.user, size: 20, color: Colors.white),
                  errorStyle: TextStyle(color: Colors.red[400], wordSpacing: 5.0,),
                  hintStyle: TextStyle(color: Colors.white, height: 1, fontSize: 15),
                  contentPadding: EdgeInsets.all(20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0), borderSide: BorderSide(color: Colors.white, width: 2),),
                  labelStyle: TextStyle(color: MyColors.primaryColor, letterSpacing: 1.3),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2), borderRadius: BorderRadius.circular(40.0),),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2), borderRadius: BorderRadius.circular(40.0),)
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
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
                  hintText: Languages.of(context)!.EmailAddress,
                  suffixIcon:  Icon(Icons.email, size: 20, color: Colors.white),
                  errorStyle: TextStyle(color: Colors.red[400], wordSpacing: 5.0,),
                  hintStyle: TextStyle(color: Colors.white, height: 1, fontSize: 15),
                  contentPadding: EdgeInsets.all(20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0), borderSide: BorderSide(color: Colors.white, width: 2),),
                  labelStyle: TextStyle(color: MyColors.primaryColor, letterSpacing: 1.3),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2), borderRadius: BorderRadius.circular(40.0),),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2), borderRadius: BorderRadius.circular(40.0),)
              ),
            ),
            SizedBox(
              height: 20.0,
            ),

            TextFormField(
              controller: edtPhoneNumberController, maxLines: 1, keyboardType: TextInputType.phone, textAlign: TextAlign.left,
              style: TextStyle(color: Colors.white, height: 1, fontSize: 16),
              onChanged: (value) {
                setState(() {
                  if (value.toString().trim().length<8) {
                    edtPhoneNumberError = "Phone number should have 8 character.";
                  }else{
                    edtPhoneNumberError = null;
                  }
                });
                print(value);
              },
              decoration: InputDecoration(
                  errorText: edtPhoneNumberError,
                  hintText: Languages.of(context)!.PhoneNumber,
                  suffixIcon:  Icon(Icons.phone_iphone, size: 20, color: Colors.white),
                  errorStyle: TextStyle(color: Colors.red[400], wordSpacing: 5.0,),
                  hintStyle: TextStyle(color: Colors.white, height: 1, fontSize: 15),
                  contentPadding: EdgeInsets.all(20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0), borderSide: BorderSide(color: Colors.white, width: 2),),
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
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0), borderSide: BorderSide(color: Colors.white, width: 2),),
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
                  Languages.of(context)!.SignUp,
                  // '',
                  style: TextStyle(color: MyColors.primaryColor, fontSize: 20),
                ),
                color: Colors.white,
                onPressed: () {
                  if(edtFnameController.text.trim().length<3){
                    _showToast(context, "Please enter atleast three alphabet.");
                  }else if(edtlnameController.text.trim().length<3){
                    _showToast(context, "Please enter atleast three alphabet.");
                  }else if(edtPhoneNumberController.text.trim().length<8){
                    _showToast(context, "Phone number should have 8 number.");
                  }else if(edtPasswordController.text.trim().length<8){
                    _showToast(context, "Password length should be 8.");
                  }else if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(edtEmailController.text.trim())){
                    _showToast(context, "Please enter a valid Email.");
                  }else{
                    FocusScope.of(context).unfocus();
                    provider.registerUser(edtFnameController.text.toString().trim(),edtlnameController.text.toString().trim(),edtEmailController.text.toString().trim(),edtPhoneNumberController.text.toString().trim(),edtPasswordController.text.toString().trim(),context,context);
                  }
                },
              ),
            ),
          ],
        ),
      )
            ],
        ),
      )
                ],
              ),
              alignment: Alignment.topCenter,
          ),
            ),
            provider.showDialogs?
            Positioned(top: 0,bottom: 0,right: 0,left: 0,
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
                          if(provider.registered){
                            if(provider.IsloggedIn){
                              provider.closedDialog();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => MyApp()),
                                    (Route<dynamic> route) => false,
                              );

                             /* Navigator.popUntil(context, ModalRoute.withName('/'));*/
                            }else{
                              provider.closedDialog();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),);
                            }
                          }else{
                            provider.closedDialog();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    ),
  ),)
            :Container()
            ],
        ),
      ),
    );
  }

  void _showToast(BuildContext context, String error) {
    print("showtoasterror");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  }

}
