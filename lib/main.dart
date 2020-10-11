import 'package:brand/constant/constant_element.dart';
import 'package:brand/provider/cart_items.dart';
import 'package:brand/provider/change_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:brand/localization/demo_localization.dart';
import 'package:brand/localization/localization_constant.dart';
import 'package:brand/routes/custom_router.dart';
import 'package:brand/routes/route_names.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  bool keepMeLogin = false;
  bool isUser = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    if (_locale == null) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MainColorApp()),
          ChangeNotifierProvider(create: (_) => CartItem()),
        ],
        child: Material(
          child: Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    } else {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MainColorApp()),
          ChangeNotifierProvider<CartItem>(
            create: (_) => CartItem(),
          ),
        ],
        child: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return MaterialApp(
                locale: _locale,
                supportedLocales: [
                  Locale('en', 'US'),
                  Locale('ar', 'SA'),
                ],
                localizationsDelegates: [
                  DemoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (deviceLocale, supportedLocales) {
                  for (var locale in supportedLocales) {
                    if (locale.languageCode == deviceLocale.languageCode &&
                        locale.countryCode == deviceLocale.countryCode) {
                      return deviceLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                debugShowCheckedModeBanner: false,
                title: 'Brand',
                theme: ThemeData(primarySwatch: Colors.blue),
                onGenerateRoute: CustomRouter.allRoutes,
                initialRoute: loginUpRoute,
              );
            } else {
              keepMeLogin = snapshot.data.getBool(KeepingMeLoginKey) ?? false;
              isUser = snapshot.data.getBool(KUserType) ?? true;
              String theInitialRoute = loginUpRoute;
              if (keepMeLogin && !isUser) {
                theInitialRoute = homePageAdmin;
              } else if (keepMeLogin && isUser) {
                theInitialRoute = homePageUser;
              }
              return MaterialApp(
                locale: _locale,
                supportedLocales: [
                  Locale('en', 'US'),
                  Locale('ar', 'SA'),
                ],
                localizationsDelegates: [
                  DemoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (deviceLocale, supportedLocales) {
                  for (var locale in supportedLocales) {
                    if (locale.languageCode == deviceLocale.languageCode &&
                        locale.countryCode == deviceLocale.countryCode) {
                      return deviceLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                debugShowCheckedModeBanner: false,
                title: 'Brand',
                theme: ThemeData(primarySwatch: Colors.blue),
                onGenerateRoute: CustomRouter.allRoutes,
                initialRoute: theInitialRoute,
              );
            }
          },
        ),
      );
    }
  }
}
