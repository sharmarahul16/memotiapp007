
// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:memotiapp/provider/appaccess.dart';
import 'package:memotiapp/provider/statics.dart';

import 'package:memotiapp/localization/language/languages.dart';
import 'package:memotiapp/localization/locale_constant.dart';

class NotfoundPage extends StatefulWidget {
  NotfoundPage({Key? key}) : super(key: key);

  @override
  _NotfoundPageState createState() => _NotfoundPageState();
}

class _NotfoundPageState extends State<NotfoundPage> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);  

    return Scaffold(
      body:Container(child: Center(child: Center(
       child:Column(  
        children:[
        Text("404", style: TextStyle(color: Colors.blueGrey, fontSize: 25, height: 2 )),
        Text("Page not found", style: TextStyle(color: Colors.blueGrey, fontSize: 25, height: 2 ))
        ])
      ))
    ));
  }

}