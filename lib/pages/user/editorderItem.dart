import 'package:brand/classes/product.dart';
import 'package:brand/constant/constant_element.dart';
import 'package:brand/helper_function/userCustomDrawer.dart';
import 'package:brand/helper_function/userMainNavbar.dart';
import 'package:brand/language/constants_word.dart';
import 'package:brand/localization/localization_constant.dart';
import 'package:brand/pages/user/cartItems.dart';
import 'package:brand/provider/cart_items.dart';
import 'package:brand/provider/change_color.dart';
import 'package:brand/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brand/routes/route_names.dart';

class EditOrderProductUser extends StatefulWidget {
  final Product _product;
  const EditOrderProductUser(this._product);

  @override
  _EditOrderProductUserState createState() => _EditOrderProductUserState();
}

class _EditOrderProductUserState extends State<EditOrderProductUser> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _s = false, _m = false, _l = false, _xl = false, _xxl = false;
  int orderQuentity = 1;
  @override
  void initState() {
    changes(widget._product);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MainColorApp mainColorApp = Provider.of<MainColorApp>(context);

    TextStyle style = TextStyle(
        color: mainColorApp.color,
        fontFamily: KLateef,
        fontWeight: FontWeight.bold,
        fontSize: 20);
    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          drawer: CustomDrawerUser(),
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Hero(
                  tag: widget._product.id,
                  child: Image.network(
                    widget._product.plocation,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 230,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(125, 125, 125, 0.4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                trans(context, KNameText),
                                style: style,
                              ),
                              Text(
                                widget._product.pname,
                                style: style,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                trans(context, KPriceText),
                                style: style,
                              ),
                              Text(
                                widget._product.pprice,
                                style: style,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                trans(context, KDescriptionText),
                                style: style,
                              ),
                              Text(
                                widget._product.pdescription,
                                style: style,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  trans(context, KSize),
                                  style: style,
                                ),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        'S',
                                        style: TextStyle(
                                            color: _s
                                                ? KWhite
                                                : mainColorApp.color),
                                      ),
                                      color: _s ? mainColorApp.color : KWhite,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _s = true;
                                        _m = false;
                                        _l = false;
                                        _xl = false;
                                        _xxl = false;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        'M',
                                        style: TextStyle(
                                            color: _m
                                                ? KWhite
                                                : mainColorApp.color),
                                      ),
                                      color: _m ? mainColorApp.color : KWhite,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _s = false;
                                        _m = true;
                                        _l = false;
                                        _xl = false;
                                        _xxl = false;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        'L',
                                        style: TextStyle(
                                            color: _l
                                                ? KWhite
                                                : mainColorApp.color),
                                      ),
                                      color: _l ? mainColorApp.color : KWhite,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _s = false;
                                        _m = false;
                                        _l = true;
                                        _xl = false;
                                        _xxl = false;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        'XL',
                                        style: TextStyle(
                                            color: _xl
                                                ? KWhite
                                                : mainColorApp.color),
                                      ),
                                      color: _xl ? mainColorApp.color : KWhite,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _s = false;
                                        _m = false;
                                        _l = false;
                                        _xl = true;
                                        _xxl = false;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        'XXL',
                                        style: TextStyle(
                                            color: _xxl
                                                ? KWhite
                                                : mainColorApp.color),
                                      ),
                                      color: _xxl ? mainColorApp.color : KWhite,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _s = false;
                                        _m = false;
                                        _l = false;
                                        _xl = false;
                                        _xxl = true;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        padding: EdgeInsets.all(7),
                        shape: CircleBorder(),
                        child: Text(
                          '+',
                          style: TextStyle(
                              fontSize: 26,
                              color: KWhite,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(() {
                            orderQuentity++;
                          });
                        },
                        color: mainColorApp.color,
                      ),
                      Text(orderQuentity.toString(),
                          style: TextStyle(
                              fontSize: 26,
                              color: KWhite,
                              fontWeight: FontWeight.bold)),
                      RaisedButton(
                        padding: EdgeInsets.all(7),
                        shape: CircleBorder(),
                        color: mainColorApp.color,
                        child: Text('-',
                            style: TextStyle(
                                fontSize: 26,
                                color: KWhite,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          setState(() {
                            if (orderQuentity > 1) {
                              orderQuentity--;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Builder(
                  builder: (context) => FlatButton(
                    onPressed: () async {
                      CartItem cartItem =
                          Provider.of<CartItem>(context, listen: false);
                      bool isAdd = false;
                      var productInCart = cartItem.products;
                      for (var p in productInCart) {
                        if (p.id == widget._product.id) {
                          isAdd = true;
                          break;
                        }
                      }
                      if (!isAdd) {
                        widget._product.pQuantity = orderQuentity;
                        if (_s) {
                          widget._product.pSize = "Small";
                        } else if (_m) {
                          widget._product.pSize = "Medium";
                        } else if (_l) {
                          widget._product.pSize = "Large";
                        } else if (_xl) {
                          widget._product.pSize = "X-Large";
                        } else if (_xxl) {
                          widget._product.pSize = "XX-Large";
                        }
                        cartItem.addToCart(widget._product);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(trans(context, KSuccessfullyEdit)),
                        ));
                      } else {
                        cartItem.deleteItemCart(widget._product);
                        widget._product.pQuantity = orderQuentity;
                        if (_s) {
                          widget._product.pSize = "Small";
                        } else if (_m) {
                          widget._product.pSize = "Medium";
                        } else if (_l) {
                          widget._product.pSize = "Large";
                        } else if (_xl) {
                          widget._product.pSize = "X-Large";
                        } else if (_xxl) {
                          widget._product.pSize = "XX-Large";
                        }
                        cartItem.addToCart(widget._product);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.white.withOpacity(0.8),
                          content: Text(
                            trans(context, KSuccessfullyEdit),
                            style: TextStyle(
                                color: mainColorApp.color,
                                fontSize: 20,
                                fontFamily: KLateef,
                                fontWeight: FontWeight.bold),
                          ),
                        ));
                        Future.delayed(Duration(milliseconds: 1250), () {
                          Navigator.pop(context);
                        });
                      }
                    },
                    padding: EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        trans(context, KUpdateCart),
                        style: TextStyle(
                            fontFamily: KLateef,
                            fontSize: 24,
                            color: KWhite,
                            fontWeight: FontWeight.bold),
                      ),
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: mainColorApp.color,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25))),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        CustomNavbarUser(
          scaffoldKey: _scaffoldKey,
        ),
      ],
    );
  }

  changes(Product product) {
    orderQuentity = product.pQuantity;
    if (product.pSize == "Small") {
      _s = true;
    } else if (product.pSize == "Medium") {
      _m = true;
    } else if (product.pSize == "Large") {
      _l = true;
    } else if (product.pSize == "X-Large") {
      _xl = true;
    } else if (product.pSize == "XX-Large") {
      _xxl = true;
    }
  }
}
