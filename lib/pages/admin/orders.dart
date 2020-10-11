import 'package:brand/classes/orders.dart';
import 'package:brand/constant/constant_element.dart';
import 'package:brand/firebase/firebase_action.dart';
import 'package:brand/helper_function/adminMainNavbar.dart';
import 'package:brand/helper_function/custom_drawer.dart';
import 'package:brand/language/constants_word.dart';
import 'package:brand/localization/localization_constant.dart';
import 'package:brand/pages/admin/showOrder.dart';
import 'package:brand/provider/change_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowOrders extends StatefulWidget {
  @override
  _ShowOrdersState createState() => _ShowOrdersState();
}

class _ShowOrdersState extends State<ShowOrders> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Store _store = new Store();

  @override
  Widget build(BuildContext context) {
    MainColorApp mainColorApp = Provider.of(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: mainColorApp.color,
          key: _scaffoldKey,
          drawer: CustomDrawer(),
          body: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: StreamBuilder<QuerySnapshot>(
              stream: _store.loadOrders(),
              builder: (context, snapshot) {
                List<Order> orders = [];
                if (snapshot.hasData) {
                  for (var p in snapshot.data.docs) {
                    Order order = new Order(
                        name: p.get(KFullName),
                        address: p.get(KAddress),
                        phone: p.get(KPhone),
                        totalPrice: p.get(KTotalPrice),
                        id: p.id);

                    orders.add(order);
                  }
                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ShowUserOrder(),
                                    settings: RouteSettings(
                                        arguments: orders[index].id)));
                              },
                              icon: Icon(
                                Icons.open_in_new,
                                color: mainColorApp.color,
                              )),
                          title: Text(
                            trans(context, KNameText) + orders[index].name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 5, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(
                                  height: 0,
                                ),
                                Text(
                                  trans(context, KAddress) +
                                      "    " +
                                      orders[index].address,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Divider(),
                                Text(
                                  trans(context, KPhone) +
                                      "       " +
                                      orders[index].phone,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Divider(),
                                Text(
                                  trans(context, KTotalPriceText) +
                                      orders[index].totalPrice.toString() +
                                      " \$",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          trailing: IconButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          size: 28,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            trans(context, KConfimation_delete),
                                            style: TextStyle(
                                                fontFamily: KLateef,
                                                fontSize: 28,
                                                color: mainColorApp.color,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    content: Text(
                                      trans(context,
                                          KMessage_confirm_delete_order),
                                      style: TextStyle(
                                          fontFamily: KLateef,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    actions: [
                                      FlatButton(
                                        child: Text(
                                          trans(context, KCancel),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text(
                                          trans(context, KDelete),
                                          style: TextStyle(
                                              color: mainColorApp.color,
                                              fontSize: 22),
                                        ),
                                        onPressed: () {
                                          Store store = Store();
                                          store.deleteOrder(orders[index].id);
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: mainColorApp.color,
                              )),
                        ),
                      );
                    },
                  );
                }
                return Container(
                  child: Center(
                    child: Text(trans(context, KLoading)),
                  ),
                );
              },
            ),
          ),
        ),
        CustomNavBar(
          scaffoldKey: _scaffoldKey,
          title: KOrders,
        ),
      ],
    );
  }
}
