import 'package:brand/classes/product.dart';
import 'package:brand/constant/constant_element.dart';
import 'package:brand/helper_function/customBottonNavigation.dart';
import 'package:brand/helper_function/userCustomDrawer.dart';
import 'package:brand/helper_function/userMainNavbar.dart';
import 'package:brand/language/constants_word.dart';
import 'package:brand/localization/localization_constant.dart';
import 'package:brand/pages/user/showProduct.dart';
import 'package:brand/provider/change_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brand/firebase/firebase_action.dart';
import 'package:provider/provider.dart';

class HomePageUser extends StatefulWidget {
  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
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
            drawer: CustomDrawerUser(),
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
        CustomNavbarUser(
          scaffoldKey: _scaffoldKey,
        ),
      ],
    );
  }

  StreamBuilder streamBuilder(String search) {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProducts(),
      builder: (context, snapshots) {
        MainColorApp mainColorApp = Provider.of<MainColorApp>(context);
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
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .7,
                    mainAxisSpacing: 1.2),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShowProductUser(
                                products[index],
                              )));
                    },
                    child: Hero(
                      tag: products[index].id,
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
                                  width: MediaQuery.of(context).size.width / 2,
                                  color: Colors.white.withOpacity(0.6),
                                  // alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                              fontSize: 10,
                                              fontFamily: KRakkas),
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
                }),
          );
        } else {
          return Center(
            child: Text(trans(context, KLoading)),
          );
        }
      },
    );
  }
}
