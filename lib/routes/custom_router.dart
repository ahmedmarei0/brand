import 'package:brand/auth_page/login_page.dart';
import 'package:brand/auth_page/register.dart';
import 'package:brand/pages/admin/add.dart';
import 'package:brand/pages/admin/edit.dart';
import 'package:brand/pages/admin/home.dart';
import 'package:brand/pages/admin/orders.dart';
import 'package:brand/pages/general/setting.dart';
import 'package:brand/pages/user/cartItems.dart';
import 'package:brand/pages/user/home.dart';
import 'package:brand/routes/route_names.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case loginUpRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
        break;
      case signUpRoute:
        return MaterialPageRoute(builder: (_) => SignUpPage());
        break;
      case homePageAdmin:
        return MaterialPageRoute(builder: (_) => HomePageAdmin());
        break;
      case addRout:
        return MaterialPageRoute(builder: (_) => AddProduct());
        break;
      case editRout:
        return MaterialPageRoute(builder: (_) => EditProduct());
        break;
      case homePageUser:
        return MaterialPageRoute(builder: (_) => HomePageUser());
        break;
      case cartItems:
        return MaterialPageRoute(
          builder: (context) => CartItemsUser(),
        );
        break;
      case settingsRoute:
        return MaterialPageRoute(
          builder: (context) => SettingPage(),
        );
        break;
      case showOrders:
        return MaterialPageRoute(
          builder: (context) => ShowOrders(),
        );
        break;
    }
    return MaterialPageRoute(builder: (_) => LoginPage());
  }
}
