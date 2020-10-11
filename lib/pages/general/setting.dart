import 'package:brand/constant/constant_element.dart';
import 'package:brand/helper_function/helper_function.dart';
import 'package:brand/language/constants_word.dart';
import 'package:brand/localization/localization_constant.dart';
import 'package:brand/provider/change_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    MainColorApp mainColorApp = Provider.of<MainColorApp>(context);

    return Scaffold(
      backgroundColor: mainColorApp.color,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: mainColorApp.color,
        title: Text(
          trans(context, KSetting),
          style: TextStyle(fontFamily: KRakkas),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(trans(context, KChangeLaguage),
                      style: TextStyle(
                          color: KWhite, fontSize: 24, fontFamily: KLateef)),
                  Flexible(
                      child: Container(child: buttonChangeLanguage(context))),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 30, bottom: 15, left: 45, right: 45),
              child: Text(trans(context, KChangeColor),
                  style: TextStyle(
                      color: KWhite, fontSize: 24, fontFamily: KLateef)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    mainColorApp.changeMyColor(Colors.teal);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    color: Colors.teal,
                  ),
                ),
                InkWell(
                  onTap: () {
                    mainColorApp.changeMyColor(KMainColor1);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    color: KMainColor1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    mainColorApp.changeMyColor(KMainColor2);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    color: KMainColor2,
                  ),
                ),
                InkWell(
                  onTap: () {
                    mainColorApp.changeMyColor(KMainColor3);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    color: KMainColor3,
                  ),
                ),
                InkWell(
                  onTap: () {
                    mainColorApp.changeMyColor(KMainColor4);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    color: KMainColor4,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
