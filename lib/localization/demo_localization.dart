
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class DemoLocalizations{
  final Locale locale;

  DemoLocalizations(this.locale);
  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  Map<String, String> _localizedValues;


  Future load() async{
    String jsonStringValues =
    await rootBundle.loadString('lib/lang/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));
 
  }

  String getTranslatedValue(String key){
    return _localizedValues[key];
  }

  //static 
  static const LocalizationsDelegate<DemoLocalizations> delegate = _DemoLocalizationDelegate();
}

class _DemoLocalizationDelegate extends  LocalizationsDelegate<DemoLocalizations>{  

  const _DemoLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'fa', 'ar' ,'hi'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalizations> load(Locale locale) async{
    DemoLocalizations localization = new DemoLocalizations(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_DemoLocalizationDelegate old) => false;
   
 }