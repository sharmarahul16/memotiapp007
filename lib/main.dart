// @dart=2.9
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:memotiapp/pages/home.dart';
import 'package:memotiapp/pages/tabs.dart';
import 'package:provider/provider.dart';
import 'package:memotiapp/provider/appaccess.dart';
// Localization
import 'package:memotiapp/provider/statics.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization/localizations_delegate.dart';
import 'localization/locale_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  await Future.delayed(Duration(seconds: 2));
  runApp(MyApp());
}


var contexts;
class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    contexts = context;
    return ChangeNotifierProvider<NavigationProvider>(
          create: (_) => NavigationProvider(), child:  
          // StartPage()
          MaterialApp(
      // builder: (context, child) {
      //   return MediaQuery(
      //     child: MultilangualPage(),
      //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      //   );
      // },
      title: 'Multi Language',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      home: StartPage(),
      supportedLocales: [
        Locale('en', ''),
        Locale('sk', '')
      ],
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    )
    );
  }
}
class MultilangualPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: 
      ChangeNotifierProvider<NavigationProvider>(
          create: (_) => NavigationProvider(), child: StartPage()),
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with WidgetsBindingObserver {
  var navigation;
  @override
  Widget build(BuildContext context) {
    navigation = Provider.of<NavigationProvider>(context);
    return Scaffold(
          body: Consumer<NavigationProvider>(
              builder: (context, navigationProvider, _) =>
                  navigationProvider.getNavigation),
        );
  }
}












