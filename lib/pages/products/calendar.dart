
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:memotiapp/provider/appaccess.dart';
import 'package:memotiapp/provider/statics.dart';

import 'package:memotiapp/localization/language/languages.dart';
import 'package:memotiapp/localization/locale_constant.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);  
    print(provider.currentIndex);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        centerTitle: true,
        title: Text(
          Languages
              .of(context)!
              .Cart == null? "": Languages
              .of(context)!
              .Cart,
          style:TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w600),
        ),
      ),
      body:Container(child: Center(child: Text("cart"))));
  }

}