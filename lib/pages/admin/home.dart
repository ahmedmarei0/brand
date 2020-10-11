import 'package:brand/classes/product.dart';
import 'package:brand/constant/constant_element.dart';
import 'package:brand/helper_function/adminMainNavbar.dart';
import 'package:brand/helper_function/customBottonNavigation.dart';
import 'package:brand/helper_function/custom_drawer.dart';
import 'package:brand/language/constants_word.dart';
import 'package:brand/localization/localization_constant.dart';
import 'package:brand/pages/admin/edit.dart';
import 'package:brand/provider/change_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brand/firebase/firebase_action.dart';
import 'package:provider/provider.dart';

class HomePageAdmin extends StatefulWidget {
  @override
  _HomePageAdminState createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  Store _store = new Store();
  int _tabBarIndex = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    MainColorApp mainColorApp = Provider.of<MainColorApp>(context);

    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            key: _scaffoldKey,
            drawer: CustomDrawer(),
            bottomNavigationBar: bottomAppBar(context),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: mainColorApp.color,
                onTap: (val) {
                  setState(() {
                    _tabBarIndex = val;
                  });
                },
                tabs: <Widget>[
                  Text(
                    trans(context, KJackets),
                    style: TextStyle(
                      fontFamily: KLateef,
                      fontWeight: FontWeight.bold,
                      color:
                          _tabBarIndex == 0 ? Colors.black : mainColorApp.color,
                      fontSize: _tabBarIndex == 0 ? 22 : 20,
                    ),
                  ),
                  Text(
                    trans(context, KTrousers),
                    style: TextStyle(
                      fontFamily: KLateef,
                      fontWeight: FontWeight.bold,
                      color:
                          _tabBarIndex == 1 ? Colors.black : mainColorApp.color,
                      fontSize: _tabBarIndex == 1 ? 22 : 20,
                    ),
                  ),
                  Text(
                    trans(context, KTShirts),
                    style: TextStyle(
                      fontFamily: KLateef,
                      fontWeight: FontWeight.bold,
                      color:
                          _tabBarIndex == 2 ? Colors.black : mainColorApp.color,
                      fontSize: _tabBarIndex == 2 ? 22 : 20,
                    ),
                  ),
                  Text(
                    trans(context, KShoes),
                    style: TextStyle(
                      fontFamily: KLateef,
                      fontWeight: FontWeight.bold,
                      color:
                          _tabBarIndex == 3 ? Colors.black : mainColorApp.color,
                      fontSize: _tabBarIndex == 3 ? 22 : 20,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                streamBuilder('jackets'),
                streamBuilder('trousers'),
                streamBuilder('t-shirts'),
                streamBuilder('shoes'),
              ],
            ),
          ),
        ),
        CustomNavBar(scaffoldKey: _scaffoldKey),
      ],
    );
  }

  StreamBuilder streamBuilder(String search) {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProducts(),
      builder: (context, snapshots) {
        if (snapshots.hasData) {
          List<Product> products = [];
          for (var doc in snapshots.data.docs) {
            if (doc.get(KProductCategory) == search) {
              products.add(Product(
                  pname: doc.get(KProductName),
                  pprice: doc.get(KProductPrice),
                  pdescription: doc.get(KProductDescription),
                  pcategory: doc.get(KProductCategory),
                  plocation: doc.get(KProductLocation),
                  id: doc.id));
            }
          }
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .7,
                  mainAxisSpacing: 1.2),
              itemCount: products.length,
              itemBuilder: (context, index) {
                MainColorApp mainColorApp = Provider.of<MainColorApp>(context);
                return GestureDetector(
                  onTapUp: (details) {
                    double dx = details.globalPosition.dx;
                    double dy = details.globalPosition.dy;
                    double dx1 = MediaQuery.of(context).size.width - dx;
                    double dy1 = MediaQuery.of(context).size.width - dy;
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(dx, dy, dx1, dy1),
                        items: [
                          MyPopupMenuItem(
                            child: Text(trans(context, KEditProduct)),
                            onClick: () {
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditProduct(
                                        myproduct: products[index],
                                      )));
                            },
                          ),
                          MyPopupMenuItem(
                            onClick: () {
                              Navigator.pop(context);
                              _store.deleteProduct(products[index].id);
                            },
                            child: Text(trans(context, KDeleteProduct)),
                          )
                        ]);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Card(
                        color: Colors.grey[200],
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Image.network(
                                products[index].plocation,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height: 70,
                                color: Colors.white.withOpacity(0.6),
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 2),
                                      child: Text(
                                        products[index].pname.toUpperCase(),
                                        style: TextStyle(fontFamily: KRakkas),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: Text(
                                        products[index]
                                            .pdescription
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 10, fontFamily: KRakkas),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned.fill(
                              bottom: 0,
                              child: Container(
                                padding: EdgeInsets.only(bottom: 5),
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  '\$ ${products[index].pprice}',
                                  style: TextStyle(
                                      color: mainColorApp.color,
                                      fontSize: 18,
                                      fontFamily: KRakkas),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        } else {
          return Center(
            child: Text(trans(context, KLoading)),
          );
        }
      },
    );
  }
}

class MyPopupMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;
  MyPopupMenuItem({@required this.child, @required this.onClick})
      : super(child: child);
  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopupMenuItemState();
  }
}

class MyPopupMenuItemState<T, PopMenuItem>
    extends PopupMenuItemState<T, MyPopupMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
    // Navigator.pop(context);
  }
}
