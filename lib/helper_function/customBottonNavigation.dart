import 'package:brand/constant/constant_element.dart';
import 'package:brand/helper_function/helper_function.dart';
import 'package:brand/helper_function/savedData.dart';
import 'package:brand/helper_function/signout.dart';
import 'package:brand/language/constants_word.dart';
import 'package:brand/localization/localization_constant.dart';
import 'package:brand/provider/cart_items.dart';
import 'package:brand/provider/change_color.dart';
import 'package:brand/routes/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    Key key,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    MainColorApp mainColorApp = Provider.of<MainColorApp>(context);

    return BottomAppBar(
      child: Container(
        height: 15,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  mainColorApp.changeMyColor(Colors.teal);
                },
                child: Container(
                  color: Colors.teal,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  mainColorApp.changeMyColor(KMainColor1);
                },
                child: Container(
                  color: KMainColor1,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  mainColorApp.changeMyColor(KMainColor2);
                },
                child: Container(
                  color: KMainColor2,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  mainColorApp.changeMyColor(KMainColor3);
                },
                child: Container(
                  color: KMainColor3,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  mainColorApp.changeMyColor(KMainColor4);
                },
                child: Container(
                  color: KMainColor4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget bottomAppBar(context) {
  // User _user = FirebaseAuth.instance.currentUser;
  MainColorApp mainColorApp = Provider.of<MainColorApp>(context);
  CartItem cartItem = Provider.of<CartItem>(context);
  bool isUser;

  return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          bool isUser = snapshot.data.getBool(KUserType);
          return Container(
            color: mainColorApp.color,
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.only(top: 0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.person,
                          color: KWhite,
                        ),
                        Text(
                          trans(context, isUser ? KUser : KAdmin),
                          style: TextStyle(
                              color: KWhite, fontSize: 12, fontFamily: KLateef),
                        )
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.only(top: 5),
                    child: Column(
                      children: [
                        Icon(Icons.close),
                        Text(trans(context, KSignout),
                            style: TextStyle(fontFamily: KLateef, fontSize: 12))
                      ],
                    ),
                    onPressed: () async {
                      cartItem.clearItems();
                      signoutUser(context);
                    },
                  ),
                )
              ],
            ),
          );

        }
        else{
          return Container();
        }
      });
}
