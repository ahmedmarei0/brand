import 'package:brand/classes/product.dart';
import 'package:brand/constant/constant_element.dart';
import 'package:brand/firebase/firebase_action.dart';
import 'package:brand/helper_function/customField.dart';
import 'package:brand/language/constants_word.dart';
import 'package:brand/localization/localization_constant.dart';
import 'package:brand/pages/user/editorderItem.dart';
import 'package:brand/provider/cart_items.dart';
import 'package:brand/provider/change_color.dart';
import 'package:brand/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemsUser extends StatefulWidget {
  @override
  _CartItemsUserState createState() => _CartItemsUserState();
}

class _CartItemsUserState extends State<CartItemsUser> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    CartItem cartItems = Provider.of<CartItem>(context);
    var products = cartItems.products;
    MainColorApp mainColorApp = Provider.of<MainColorApp>(context);
    double total = totalPrice(products);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 22, left: 3, right: 3),
            child: total > 0
                ? Text(
                    "${trans(context, KTotalPriceText)} $total \$",
                    style: TextStyle(fontSize: 14),
                  )
                : Text(''),
          )
        ],
        backgroundColor: mainColorApp.color,
        title: Text(
          trans(context, KBrand),
          style: TextStyle(fontFamily: KRakkas),
        ),
        // centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColorApp.color,
        child: Text(
          trans(context, KPay),
          style: TextStyle(
              fontFamily: KLateef, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            elevation: 10,
            builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                  color: KWhite,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(35))),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.grey[400], width: 1))),
                    child: Row(
                      children: [
                        FlatButton(
                          child: Text(
                            trans(context, KCancel),
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 24,
                                fontFamily: KLateef,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(trans(context, KSelect_payment),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontFamily: KLateef,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyBuilder(
                    url: "images/payment/paypal.jpg",
                    paymentName: KPaypal,
                  ),
                  SizedBox(height: 10),
                  MyBuilder(
                    url: "images/payment/master.png",
                    paymentName: KMaster_card,
                  ),
                  SizedBox(height: 10),
                  MyBuilder(
                    url: "images/payment/applepay.png",
                    paymentName: KApple_pay,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            if (products == null) {
              return Container(
                child: Center(
                  child: Text(trans(context, KLoading)),
                ),
              );
            } else {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: 170,
                child: Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 170,
                          child: Image.network(
                            products[index].plocation,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 15),
                                  child: Text(
                                    products[index].pname,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                    child: Text(
                                  trans(context, KDescriptionText) +
                                      ' ${products[index].pdescription}',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[700]),
                                )),
                                Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      trans(context, KSize) +
                                          ' ${products[index].pSize}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[700]),
                                    )),
                                Container(
                                    padding: EdgeInsets.only(top: 30),
                                    child: Text(
                                      trans(context, KQuantity) +
                                          ' ${products[index].pQuantity.toString()}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: mainColorApp.color),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 5),
                                child: Text(
                                  '\$ ${products[index].pprice}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: mainColorApp.color),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: mainColorApp.color,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      EditOrderProductUser(products[index]),
                                ));
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: mainColorApp.color,
                              ),
                              onPressed: () {
                                _showMyDialog(products[index]);
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  Future<void> _showMyDialog(Product product) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        MainColorApp mainColorApp = Provider.of<MainColorApp>(context);
        return AlertDialog(
          title: Text(
            trans(context, KConfimation_delete),
            style: TextStyle(
                color: mainColorApp.color,
                fontFamily: KLateef,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.delete,
                    color: mainColorApp.color,
                    size: 40,
                  ),
                  title: Text(trans(context, KMessage_confirm_delete)),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              textColor: mainColorApp.color,
              child: Text(trans(context, KDelete)),
              onPressed: () {
                Provider.of<CartItem>(context, listen: false)
                    .deleteItemCart(product);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              textColor: Colors.black,
              child: Text(trans(context, KCancel)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

double totalPrice(List<Product> products) {
  double total = 0;
  for (var p in products) {
    total += (double.parse(p.pprice) * p.pQuantity);
  }
  return total;
}

class MyBuilder extends StatelessWidget {
  final String url;
  final String paymentName;
  MyBuilder({@required this.url, @required this.paymentName});

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _name, _phone, _address;
    double _total = 0;
    MainColorApp mainColorApp = Provider.of<MainColorApp>(context);
    CartItem cartItem = Provider.of<CartItem>(context);
    List<Product> products = cartItem.products;
    _total = totalPrice(products);

    return Builder(
      builder: (context) => ListTile(
          onTap: () async {
            Navigator.pop(context);
            await showDialog(
                context: context,
                useRootNavigator: true,
                builder: (BuildContext context) => AlertDialog(
                      insetPadding: EdgeInsets.all(10),
                      contentPadding: EdgeInsets.all(0),
                      actionsOverflowButtonSpacing: 10,
                      backgroundColor: Colors.transparent,
                      scrollable: true,
                      content: Container(
                        height: MediaQuery.of(context).size.height * 0.55,
                        width: 3800,
                        decoration: BoxDecoration(
                            color: mainColorApp.color,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 20, left: 15, right: 15, bottom: 15),
                                child: Text(
                                  trans(context, KPersonal_information),
                                  style: TextStyle(
                                      color: KWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              CustomTextField(
                                hint: trans(context, KPay_hint_name),
                                icon: Icons.person,
                                onClick: (val) {
                                  _name = val;
                                },
                                value: _name,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                hint: trans(context, KPay_hint_phone),
                                icon: Icons.phone,
                                onClick: (val) {
                                  _phone = val;
                                },
                                value: _phone,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                hint: trans(context, KPay_hint_address),
                                icon: Icons.home,
                                onClick: (val) {
                                  _address = val;
                                },
                                value: _address,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    RaisedButton(
                                      color: KWhite,
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        trans(context, KConfirm_pay),
                                        style: TextStyle(
                                            color: mainColorApp.color,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          Map<String, dynamic> data =
                                              new Map<String, dynamic>();
                                          data.addAll({
                                            KFullName: _name,
                                            KAddress: _address,
                                            KPhone: _phone,
                                            KTotalPrice: _total,
                                          });

                                          Store _store = new Store();
                                          _store.addOrders(data, products);
                                          Navigator.pop(context);
                                        }
                                      },
                                    ),
                                    RaisedButton(
                                      color: KWhite,
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        trans(context, KCancel),
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ));
          },
          title: Text(trans(context, paymentName),
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontFamily: KLateef,
                fontWeight: FontWeight.bold,
              )),
          leading: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400], width: 2),
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(image: AssetImage(url))),
            height: 50,
            width: 90,
          )),
    );
  }
}
