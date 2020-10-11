import 'package:brand/constant/constant_element.dart';
import 'package:brand/helper_function/signout.dart';
import 'package:brand/language/constants_word.dart';
import 'package:brand/localization/localization_constant.dart';
import 'package:brand/provider/change_color.dart';
import 'package:brand/routes/route_names.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawerUser extends StatefulWidget {
  @override
  _CustomDrawerUserState createState() => _CustomDrawerUserState();
}

class _CustomDrawerUserState extends State<CustomDrawerUser> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: myDrawerColor(context))),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(0),
              color: Colors.transparent,
              child: Container(
                margin: EdgeInsets.only(
                  top: 60,
                ),
                height: 60,
                width: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(KBrandLogo),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).popAndPushNamed(homePageUser);
              },
              title: Text(
                trans(context, KShowProduct),
                style: TextStyle(
                  color: KWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: KLateef
                ),
              ),
              leading: Icon(
                Icons.tv,
                color: KWhite,
              ),
            ),
            ListTile(
              onTap: () {
                  Navigator.of(context).pushNamed(cartItems);
              },
              title: Text(
                trans(context, KCartItems),
                style: TextStyle(
                  color: KWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: KLateef
                ),
              ),
              leading: Icon(
                Icons.shopping_cart,
                color: KWhite,
              ),
            ),
            
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(settingsRoute);
              },
              title: Text(
                trans(context, KSetting),
                style: TextStyle(
                  color: KWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: KLateef
                ),
              ),
              leading: Icon(
                Icons.settings,
                color: KWhite,
              ),
            ),

            ListTile(
              onTap: () {
               signoutUser(context);
              },
              title: Text(
                trans(context, KSignout),
                style: TextStyle(
                  color: KWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: KLateef
                ),
              ),
              leading: Icon(
                Icons.close,
                color: KWhite,
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  List<Color> myDrawerColor(context) {
    MainColorApp mainColorApp = Provider.of<MainColorApp>(context);
    if (mainColorApp.color == KMainColor1) {
      return [
        Colors.grey[200],
        Colors.grey[400],
        Colors.grey[600],
        Colors.grey[900],
      ];
    } else if (mainColorApp.color == KMainColor2) {
      return [
        Colors.deepOrange[200],
        Colors.deepOrange[400],
        Colors.deepOrange[600],
        Colors.deepOrange[900],
      ];
    } else if (mainColorApp.color == KMainColor3) {
      return [
        Colors.blueGrey[200],
        Colors.blueGrey[400],
        Colors.blueGrey[600],
        Colors.blueGrey[900],
      ];
    } else if (mainColorApp.color == KMainColor4) {
      return [
        Colors.purple[200],
        Colors.purple[400],
        Colors.purple[600],
        Colors.purple[900],
      ];
    } else {
      return [
        Colors.teal[200],
        Colors.teal[400],
        Colors.teal[600],
        Colors.teal[900],
      ];
    }
  }
}
