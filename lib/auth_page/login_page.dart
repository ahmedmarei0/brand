import 'package:brand/constant/constant_element.dart';
import 'package:brand/firebase/store.dart';
import 'package:brand/helper_function/customBottonNavigation.dart';
import 'package:brand/helper_function/customField.dart';
import 'package:brand/helper_function/helper_function.dart';
import 'package:brand/helper_function/savedData.dart';
import 'package:brand/language/constants_word.dart';
import 'package:brand/language/language.dart';
import 'package:brand/localization/localization_constant.dart';
import 'package:brand/provider/change_color.dart';
import 'package:brand/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  List<Language> lang = Language.languageList();
  String _email, _password;
  bool keepMeLogin = false;
  bool isUser = true;
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
                          hint: trans(context, KHintEmail),
                          icon: Icons.email,
                          onClick: (val) {
                            _email = val;
                          },
                          value: 'asd@gmail.com',
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
                          value: '123456',
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      child: CheckboxListTile(
                        checkColor: mainColorApp.color,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (val) {
                          setState(() {
                            keepMeLogin = val;
                          });
                        },
                        activeColor: KWhite,
                        value: keepMeLogin,
                        title: Text(
                          trans(context, KKeepMeLoginConst),
                          style: TextStyle(
                              color: KWhite,
                              fontFamily: KLateef,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => RaisedButton(
                        onPressed: () async {
                          if (_globalKey.currentState.validate()) {
                            _globalKey.currentState.save();
                            if (isUser) {
                              Auth auth = new Auth();
                              try {
                                await auth.signIn(_email, _password);
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    homePageUser,
                                    (Route<dynamic> route) => false);
                                setKeepMeLoginData(keepMeLogin);
                                setIsUserData(isUser);
                              } catch (e) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(e.message),
                                ));
                              }
                            } else {
                              Auth auth = new Auth();
                              try {
                                await auth.signIn(_email, _password);
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    homePageAdmin,
                                    (Route<dynamic> route) => false);
                                setKeepMeLoginData(keepMeLogin);
                                setIsUserData(isUser);
                              } catch (e) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(e.message),
                                ));
                              }
                            }
                          }
                        },
                        child: Text(
                          trans(context, KLogin),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: KLateef),
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
                          Text(trans(context, KNotHaveAccount),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: KLateef)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    signUpRoute,
                                    (Route<dynamic> route) => false);
                              },
                              child: Text(
                                trans(context, KSignUp),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: KLateef,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isUser = !isUser;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            isUser ? '' : trans(context, KAdmin),
                            style: TextStyle(
                              color: KWhite,
                              fontStyle: FontStyle.italic,
                              fontSize: 20,
                              fontFamily: KLateef,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(isUser ? trans(context, KUser) : '',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: KWhite,
                                  fontFamily: KLateef,
                                  fontStyle: FontStyle.italic))
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
