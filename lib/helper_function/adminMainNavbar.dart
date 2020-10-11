import 'package:brand/constant/constant_element.dart';
import 'package:brand/language/constants_word.dart';
import 'package:brand/localization/localization_constant.dart';
import 'package:brand/provider/change_color.dart';
import 'package:brand/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavBar extends StatelessWidget {
  final String title;
  CustomNavBar(
      {Key key, @required GlobalKey<ScaffoldState> scaffoldKey, this.title})
      : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    MainColorApp mainColorApp = Provider.of<MainColorApp>(context);
    return Material(
      child: Padding(
        padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 0),
        child: Container(
          height: MediaQuery.of(context).size.height * .1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 3),
                    child: IconButton(
                      onPressed: () {
                        if (_scaffoldKey.currentState.isDrawerOpen) {
                          Navigator.of(context).pop();
                        } else {
                          _scaffoldKey.currentState.openDrawer();
                        }
                      },
                      icon: Icon(
                        Icons.line_weight,
                        size: 22,
                        color: mainColorApp.color,
                      ),
                    ),
                  ),
                  Text(
                    trans(context, title == null ? KBrand : title),
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: KRakkas,
                      color: mainColorApp.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(showOrders);
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 40,
                    color: mainColorApp.color,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
