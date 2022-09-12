
// import 'dart:ui';
import 'package:memotiapp/provider/appaccess.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:memotiapp/provider/statics.dart';
// import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
const String prefSelectedLanguageCode = "SelectedLanguageCode";

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}

String lang = "";
String langcode = "";
getcategoryTitle(NavigationProvider provider , int index){
  print(provider.datumList[index-1]["category"]["slovaktitle"]);
  return FutureBuilder(
    future: getStringLocale(),
    initialData: "Loading text..",
    builder: (BuildContext context, AsyncSnapshot<String> text) {
    if(text.data=="en"){
      return Text(
        provider.datumList[index-1]["category"]["title"],
        style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            color: Colors .white),
      );
    }else{
      return Text(
          provider.datumList[index-1]["category"]["slovaktitle"],
          style:TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
          color: Colors .white));
    }
  },

  );
}

getLocal() {
  return langcode;
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(prefSelectedLanguageCode) ?? "en";
  langcode = _locale(languageCode).toString();
  return _locale(languageCode);
}
Future<String> getStringLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  /*String languageCode = _prefs.getString(prefSelectedLanguageCode) ?? "en";*/
  return _prefs.getString(prefSelectedLanguageCode) ?? "en";
}

Locale _locale(String languageCode) {
  return languageCode != null && languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : Locale('sk', '');
}

 void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  var _locale = await setLocale(selectedLanguageCode);
  MyApp.setLocale(context, _locale);
  getStringLocale().then((value) {
    lang = value;
    langcode = value;
  });
}
class LanguageData {
  final String flag;
  final String name;
  final String languageCode;

  LanguageData(this.flag, this.name, this.languageCode);

  static List<LanguageData> languageList() {
    return <LanguageData>[
      LanguageData("🇺🇸", "English", 'en'),
      LanguageData("🇸🇦", "Slovak‎", "sk"),
    ];
  }
}