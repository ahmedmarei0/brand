import 'package:brand/language/language.dart';
import 'package:brand/localization/localization_constant.dart';
import 'package:flutter/material.dart';
import '../main.dart';

void changeLanguage(Language language, context) async {
  Locale _temp = await setLocale(language.languageCode);
  MyApp.setLocale(context, _temp);
}
