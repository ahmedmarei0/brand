import 'package:brand/constant/constant_element.dart';
import 'package:brand/language/language.dart';
import 'package:brand/language/language_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double getHeight(context){
  return MediaQuery.of(context).size.height;
}
double getWidth(context){
  return MediaQuery.of(context).size.width;
}
Widget buttonChangeLanguage( context){
  return           Padding(
    padding: EdgeInsets.only(top: 10, right: 10, left: 10),
    child: DropdownButton(
      onChanged: (Language language){
        changeLanguage(language, context);
      },
      underline: SizedBox(),
      icon: Icon(
        Icons.language,
        color: Colors.white,
        size: 30,
      ),
      items: Language.languageList()
          .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
        value: lang,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(lang.name , style: TextStyle(fontSize: 20, fontFamily: KRakkas),),
            Text(lang.flag , style: TextStyle(fontSize: 20, fontFamily: KRakkas),),
          ],),
      )
      ).toList(),
    ),
);
}