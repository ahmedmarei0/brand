import 'package:brand/constant/constant_element.dart';
import 'package:brand/helper_function/customBottonNavigation.dart';
import 'package:brand/helper_function/customField.dart';
import 'package:brand/helper_function/helper_function.dart';
import 'package:brand/language/constants_word.dart';
import 'package:brand/language/language.dart';
import 'package:brand/localization/localization_constant.dart';
import 'package:brand/provider/change_color.dart';
import 'package:brand/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:brand/firebase/store.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  List<Language> lang = Language.languageList();
  String _email, _password;
  @override
  Widget build(BuildContext context) {
    double h = getHeight(context);
    double w = getWidth(context);
    MainColorApp mainColorApp = Provider.of<MainColorApp>(context);
    return Scaffold(
        bottomNavigationBar: CustomAppBar(),
        appBar: AppBar(
          title: Text(
            trans(context, KBrand),
            style: TextStyle(
                color: Colors.white, fontFamily: KRakkas, fontSize: 30),
          ),
          elevation: 0,
          backgroundColor: mainColorApp.color,
          actions: [
            buttonChangeLanguage(context),
          ],
        ),
        body: Container(
          height: h,
          width: w,
          color: mainColorApp.color,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: h * .05,
                ),
                height: 120,
                width: 120,
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(KBrandLogo),
                ),
              ),
              Form(
                key: _globalKey,
                child: Column(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: CustomTextField(
                          hint: trans(context, KHintName),
                          icon: Icons.person,
                          onClick: (val) {
                            // _email = val;
                          },
                          value: _email,
                        )),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: CustomTextField(
                          hint: trans(context, KHintEmail),
                          icon: Icons.email,
                          onClick: (val) {
                            _email = val;
                          },
                          value: _email,
                        )),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: CustomTextField(
                          hint: trans(context, KHintPassword),
                          icon: Icons.lock,
                          onClick: (val) {
                            _password = val;
                          },
                          value: _password,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Builder(
                      builder: (context) => RaisedButton(
                        onPressed: () async {
                          if (_globalKey.currentState.validate()) {
                            _globalKey.currentState.save();
                            Auth auth = new Auth();
                            try {
                              await auth.signUp(_email, _password);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  homePageUser,
                                  (Route<dynamic> route) => false);
                            } catch (e) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(e.message),
                              ));
                            }
                          }
                        },
                        child: Text(
                          trans(context, KSignUp),
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: KLateef,
                              fontWeight: FontWeight.bold),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(trans(context, KHaveAccount),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: KLateef,
                                  color: Colors.white)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    loginUpRoute,
                                    (Route<dynamic> route) => false);
                              },
                              child: Text(
                                trans(context, KLogin),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
