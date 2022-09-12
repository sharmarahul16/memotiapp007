import 'package:flutter/material.dart';
import 'package:memotiapp/main.dart';
import 'package:memotiapp/pages/cart.dart';
import 'package:memotiapp/pages/creations.dart';
import 'package:memotiapp/pages/home.dart';
import 'package:memotiapp/pages/account.dart';
import 'package:provider/provider.dart';
import 'package:memotiapp/provider/statics.dart';
import 'package:memotiapp/provider/appaccess.dart';

import 'package:memotiapp/localization/language/languages.dart';
import 'package:memotiapp/localization/locale_constant.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPage createState() =>
      _TabsPage();
}

class _TabsPage
    extends State<TabsPage> {
  var currentTab = [
    HomePage(),
    CreationsPage(),
    CartPage(),
    AccountPage(),
  ];
  int count = 0;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    if(count == 0){
      count++;
      provider.updatecontext(context);
    }
    return Scaffold(
      body: currentTab[provider.currentIndex],
      bottomNavigationBar:
            BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: Colors.white,
          selectedItemColor: HexColor("52C5CB"),
          unselectedItemColor: HexColor("CDCFD3"),
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.currentIndex = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            // label: ""
            label: Languages
          .of(context)!
          .Home == null?"":Languages
          .of(context)!
          .Home
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mode_edit),
            // label: "",
            label: Languages
          .of(context)!
          .Creations ==  null?"":Languages
          .of(context)!
          .Creations
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            // label: "",
            label:Languages
          .of(context)!
          .Cart ==  null?"": Languages
          .of(context)!
          .Cart
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            // label: ""
            label:Languages
          .of(context)!
          .Account == null?"":Languages
          .of(context)!
          .Account
          )
        ],
      ),
      // ),
    );
  }
}