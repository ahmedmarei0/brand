import 'package:brand/classes/product.dart';
import 'package:brand/constant/constant_element.dart';
import 'package:brand/firebase/firebase_action.dart';
import 'package:brand/helper_function/adminMainNavbar.dart';
import 'package:brand/helper_function/custom_drawer.dart';
import 'package:brand/language/constants_word.dart';
import 'package:brand/localization/localization_constant.dart';
import 'package:brand/provider/change_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowUserOrder extends StatefulWidget {
  @override
  _ShowUserOrderState createState() => _ShowUserOrderState();
}

class _ShowUserOrderState extends State<ShowUserOrder> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Store store = Store();
  @override
  Widget build(BuildContext context) {
    String docId = ModalRoute.of(context).settings.arguments;
    MainColorApp mainColorApp = Provider.of(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: mainColorApp.color,
          key: _scaffoldKey,
          drawer: CustomDrawer(),
          body: Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: store.loadOrderDetails(docId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Product> products = [];
                    for (var p in snapshot.data.docs) {
                      products.add(Product(
                          pname: p.get(KProductName),
                          pprice: p.get(KProductPrice),
                          pQuantity: p.get(KProductQuentity),
                          plocation: p.get(KProductLocation)));
                    }
                    return ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) => Card(
                              elevation: 10,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Image.network(
                                          products[index].plocation,
                                          fit: BoxFit.fill,
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            trans(context, KNameText) +
                                                products[index].pname,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            trans(context, KPriceText) +
                                                products[index].pprice,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            trans(context, KQuantity) +
                                                products[index]
                                                    .pQuantity
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                  }
                  return Container(
                    child: Center(
                      child: Text(trans(context, KLoading)),
                    ),
                  );
                }),
          ),
        ),
        CustomNavBar(
          scaffoldKey: _scaffoldKey,
          title: KUserOrder,
        )
      ],
    );
  }
}
