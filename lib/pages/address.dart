
// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:memotiapp/provider/appaccess.dart';
import 'package:memotiapp/provider/statics.dart';

import 'package:memotiapp/localization/language/languages.dart';
import 'package:memotiapp/localization/locale_constant.dart';

class AddressListPage extends StatelessWidget {
  String token;
  String where;
  BuildContext? contextmain;
  AddressListPage(this.contextmain,this.token, this.where);

   @override
  Widget build(BuildContext context) {
    return _AddressListPageState(contextmain!,token,where);
  }
}

class _AddressListPageState extends StatelessWidget {
  BuildContext contextmain;
  String token;
  String where;
  _AddressListPageState(this.contextmain,this.token, this.where);
  int count = 0;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);  
    if (count == 0) {
      count++;
      provider.addData(provider.a_token);
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
        title: Text(Languages
            .of(context)!
            .Addresses,style:TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: HexColor("#F0F0F2"),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: provider.addresses.length,
                  itemBuilder: (BuildContext context, int index){
                    return AddressItem(index, provider.addresses[index]);
                  }),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 0.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddAddressPage(context, provider.a_token, where)),);
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
                           Text(Languages
                               .of(context)!
                               .AddNewAddress,
                               style: TextStyle(
                                   letterSpacing: 2,
                                   wordSpacing: 2,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.black, fontSize: 18)
                           ),
                         ],
                        ),
                      ),
                    ),
                  ),
                  /*{"code":200,"status":"success","data":[{"password":"2d0d1bcb4db52eaf3d8c3ae229cd5cc16059fa853637311d4822d8c9054e1c59015919598c843c79e273569ea9fc549d61f279b2289fb539920b825f2ff2d43f","mobile":"1234567890","situation":"Active","pt":"customer","pi":"customer732a6a10-28a0-11eb-abf1-d9887676d70e","address":["{\"title\":\"Office\",\"Country\":\"India--Slovensko\",\"address\":\"vv@vv.ff\",\"cityRegion\":\"mohali\",\"postCode\":\"160060\",\"PhoneNumber\":\"123456789\",\"pt\":\"customer\",\"pi\":\"customer732a6a10-28a0-11eb-abf1-d9887676d70e\",\"isSelected\":false}"],"email":"vishalmahajan802@gmail.com","title":"vishal mahajan"}],"message":"Updated Address"}*/
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    child: Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width*1.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: MyColors.primaryColor,
                        onPressed: ()  {
                          switch(where){
                            case "order":{
                              provider.gotopage(contextmain,context);
                              break;
                            }
                            case "cart":{
                              provider.gotopage(contextmain,context);
                              break;
                            }
                            case "account":{
                              Navigator.pop(context);
                              break;
                            }
                          }
                          },
                        child: Text(Languages
                            .of(context)!
                            .Done,
                            style: TextStyle(
                                letterSpacing: 2,
                                wordSpacing: 2,
                                color: Colors.white, fontSize: 18)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}


class AddressItem extends StatelessWidget {

  int index;
  Map address;
  AddressItem(this.index, this.address);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context); 
    return Container(
      child: Card(
        elevation: 6,
        shadowColor: Colors.black38,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => provider.changeAddress(index),
                child: Container(
                  padding: EdgeInsets.only(right: 24),
                  alignment: Alignment.centerLeft,
                  child: address["isSelected"]?
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
                        address["title"],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),),
                      Padding(padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                        child: Text(
                          address["address"],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                      Padding(padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                        child: Text(
                          address["cityRegion"]+", "+address["postCode"]+", "+address["Country"],
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
                    GestureDetector(
                      onTap: (){
                        provider.firstCall = false;
                        Navigator.push( context, MaterialPageRoute(builder: (context) => EditAddressPage(address,index,provider.addresses)));
                      },
                      child: Text(
                        Languages
                            .of(context)!
                            .Edit,
                        style: TextStyle(
                          color: MyColors.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: MyColors.primaryColor,
                        size: 20,
                      ),
                      onPressed: () {
                        provider.deleteaddress(index, provider.a_token, context, address["pi"], address["pt"]);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class EditAddressPage extends StatelessWidget {
  Map address;
  int index;
  List addresses = [];
  EditAddressPage(this.address, this.index, this.addresses);

  @override
  Widget build(BuildContext context) {
    return InnerEditAddressPage(address: address,index: index,addresses: addresses, where: '', token: '',);
  }
}
class InnerEditAddressPage extends StatelessWidget {
    InnerEditAddressPage({
    Key? key,
    required this.address,
    required this.index,
    required this.addresses,
    required this.where,
    required this.token
  }) : super(key: key);
  Map address;
  late int index;
  late List addresses = [];
  late String where ;
  late String token ;
  BuildContext? contextmain ;
  // InnerEditAddressPage(this.address, this.index, this.addresses);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    if(!provider.firstCall){
      provider.setData(address,index,addresses);
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
        title: Text(Languages
            .of(context)!
            .EditAddress,style:TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  Languages
                      .of(context)!
                      .Whereshouldwesendthosewonderfulphotos,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      letterSpacing: 2,
                      wordSpacing: 2,
                      color: MyColors.primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: getDecoration(),
                child: TextFormField(
                  initialValue: address["title"],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: Languages
                        .of(context)!
                        .Fullname,
                    errorText: provider.edtname.error,
                  ),
                  onChanged: (String value) {
                    provider.changeedtName(value);
                  },
                ),

              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: getDecoration(),
                child: TextFormField(
                  initialValue: address["address"],
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: Languages
                        .of(context)!
                        .EmailAddress,
                    errorText: provider.edtAddress.error,
                  ),
                  onChanged: (String value) {
                    provider.changedEmail(value);
                  },
                ),

              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: getDecoration(),
                child: TextFormField(
                  initialValue: address["cityRegion"],
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: Languages
                        .of(context)!
                        .CityStreet,
                    errorText: provider.edtCityStreet.error,
                  ),
                  onChanged: (String value) {
                    provider.changeedtCityStreet(value);
                  },
                ),

              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: getDecoration(),
                        child: TextFormField(
                          initialValue: address["postCode"],
                          maxLines: 1,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5),
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText:Languages
                                .of(context)!
                                .postCode,
                            errorText: provider.edtPostCode.error,
                          ),
                          onChanged: (String value) {
                            provider.changeedtpPostCode(value);
                          },
                        ),

                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 12),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: getDecoration(),
                        child: TextFormField(
                          initialValue: address["Country"].toString().split('--')[0],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText:  Languages
                                .of(context)!
                                .city,
                            errorText: provider.edtcity.error,
                          ),
                          onChanged: (String value) {
                            provider.changeedCity(value);
                          },
                        ),

                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: getDecoration(),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Slovensko",style: TextStyle(fontSize: 18),
                  ),
                ),

              ),
              /*Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.fromLTRB(10.0,4,10.0,4),
                decoration: getDecoration(),
                child:DropdownButtonHideUnderline(
                  child: DropdownButton(
                    items: provider.country
                        .map((value) => DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    )).toList(),
                    onChanged: (String value) {
                      provider.setaddresscountry(value);
                    },
                    isExpanded: true,
                    value:  provider.addresscountry,
                  ),
                ),
              ),*/
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: getDecoration(),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("+421",style: TextStyle(fontSize: 20),
                          ),
                        ),

                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.only(left: 12),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: getDecoration(),
                        child: TextFormField(
                          initialValue: address["PhoneNumber"],
                          maxLines: 1,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: Languages
                                .of(context)!
                                .PhoneNumber,
                            errorText: provider.edtPhoneNumber.error,
                          ),
                          onChanged: (String value) {
                            provider.changeedtpPhoneNumber(value);
                          },
                        ),

                      ),
                    )
                  ],
                ),
              ),

              /*Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: getDecoration(),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "+421",

                          ),
                          onChanged: (String value) {
                            provider.changedEmail(value);
                          },
                        ),

                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.only(left: 12),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: getDecoration(),
                        child: TextFormField(
                          initialValue: address["PhoneNumber"],
                          maxLines: 1,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText:Languages
                                .of(contextmain)
                                .PhoneNumber,
                            errorText: provider.edtPhoneNumber.error,
                          ),
                          onChanged: (String value) {
                            provider.changeedtpPhoneNumber(value);
                          },
                        ),

                      ),
                    )
                  ],
                ),
              ),*/
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 16.0),
                child: Container(
                  height: 45.0,
                  width: MediaQuery.of(context).size.width*1.0,
                  child: 
                  ElevatedButton(
                    child: Text(Languages.of(context)!.EditAddress),
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
                      setState()=>{
                        contextmain = context
                      };
                      provider.editaddress(context,context,where);
                      provider.saveaddress(where,token,context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddressListPage(contextmain,token,where),));
                    },
                  )
                  // RaisedButton(
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(20)),
                  //   color: MyColors.primaryColor,
                  //   onPressed: () {
                  //     provider.editaddress(context,context,where);
                  //    // provider.saveaddress(where,token, context);
                  //     // Navigator.push(
                  //     //   context,
                  //     //   MaterialPageRoute(builder: (context) => AddressListPage(token)),);
                  //   },
                  //   child: Text(Languages
                  //       .of(context)
                  //       .EditAddress,
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
      ),
    );
  }
  BoxDecoration getDecoration(){
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
          color: Colors.black, style: BorderStyle.solid, width: 1),
    );
  }
}


class AddAddressPage extends StatelessWidget {
  String token;
  BuildContext contextmain;
  String where;
  AddAddressPage(this.contextmain,this.token, this.where);
  @override
  Widget build(BuildContext context) {
    return InnerAddAddressPage(contextmain,token, this.where);
  }
}
class InnerAddAddressPage extends StatelessWidget {
  String token;
  String where;
  BuildContext contextmain;
  InnerAddAddressPage(this.contextmain,this.token, this.where);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
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
        title: Text(Languages
            .of(contextmain)!
            .AddAddress,
          style:TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(top: 16),
                child: Text(
                    Languages
                        .of(contextmain)!
                        .Whereshouldwesendthosewonderfulphotos,
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 2,
                  wordSpacing: 2,
                  color: MyColors.primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: getDecoration(),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: Languages
                        .of(contextmain)!
                        .Fullname,
                    errorText: provider.edtname.error,
                  ),
                  onChanged: (String value) {
                    provider.changeedtName(value);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: getDecoration(),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: Languages
                        .of(contextmain)!
                        .EmailAddress,
                    errorText: provider.edtAddress.error,
                  ),
                  onChanged: (String value) {
                    provider.changedEmail(value);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: getDecoration(),
                child: TextField(
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: Languages
                      .of(contextmain)!
                      .CityStreet,
                    errorText: provider.edtCityStreet.error,
                  ),
                  onChanged: (String value) {
                    provider.changeedtCityStreet(value);
                  },
                ),

              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: getDecoration(),
                        child: TextField(
                          maxLines: 1,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5),
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: Languages
                                .of(contextmain)!
                                .postCode,
                            errorText: provider.edtPostCode.error,
                          ),
                          onChanged: (String value) {;
                            provider.changeedtpPostCode(value);
                          },
                        ),

                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 12),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: getDecoration(),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText:Languages
                                .of(contextmain)!
                                .city,
                            errorText: provider.edtcity.error,
                          ),
                          onChanged: (String value) {
                            provider.changeedCity(value);
                          },
                        ),

                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: getDecoration(),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Slovensko",style: TextStyle(fontSize: 18),
                  ),
                ),

              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: getDecoration(),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("+421",style: TextStyle(fontSize: 20),
                          ),
                        ),

                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.only(left: 12),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: getDecoration(),
                        child: TextField(
                          maxLines: 1,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: Languages
                                .of(contextmain)!
                                .PhoneNumber,
                            errorText: provider.edtPhoneNumber.error,
                          ),
                          onChanged: (String value) {
                            provider.changeedtpPhoneNumber(value);
                          },
                        ),

                      ),
                    )
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 16.0),
                child: Container(
                  height: 45.0,
                  width: MediaQuery.of(context).size.width*1.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: MyColors.primaryColor,
                    onPressed: () {
                      provider.saveaddress(where,token,contextmain);
                    },


                    child: Text(Languages
                        .of(contextmain)!
                        .SaveAddress,
                        style: TextStyle(
                          letterSpacing: 2,
                            wordSpacing: 2,
                            color: Colors.white, fontSize: 18)
                    ), 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  BoxDecoration getDecoration(){
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
          color: Colors.black, style: BorderStyle.solid, width: 1),
    );
  }
}