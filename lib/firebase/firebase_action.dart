import 'package:brand/classes/product.dart';
import 'package:brand/constant/constant_element.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:brand/constant/constant_element.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(Product product) async {
    await _firestore.collection(KProductCollection).add({
      'productName': product.pname,
      'productPrice': product.pprice,
      'productDescription': product.pdescription,
      'productCategory': product.pcategory,
      'productLocation': product.plocation,
    }).catchError((e) {
      print(e);
    });
  }

  //from stream
  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(KProductCollection).snapshots();
  }

  deleteProduct(documentId) {
    _firestore.collection(KProductCollection).doc(documentId).delete();
  }

  editProduct(Product product) {
    _firestore.collection(KProductCollection).doc(product.id).update({
      'productName': product.pname,
      'productPrice': product.pprice,
      'productDescription': product.pdescription,
      'productCategory': product.pcategory,
      'productLocation': product.plocation,
    });
  }
  addOrders(Map<String , dynamic> data, List<Product> products){
    var documentRef = _firestore.collection(KOrdersCollection).doc();
    documentRef.set(data);
    for(var p in products){
      documentRef.collection(KOrderDetialsCollection).doc().set({
        KProductName : p.pname,
        KProductPrice : p.pprice,
        KProductQuentity :p.pQuantity,
        KProductLocation : p.plocation,
      });
    }
  }

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection(KOrdersCollection).snapshots();
  }
  Stream<QuerySnapshot> loadOrderDetails(docId) {
    return _firestore.collection(KOrdersCollection).doc(docId).collection(KOrderDetialsCollection).snapshots();
  }

  deleteOrder(documentId) {
    _firestore.collection(KOrderDetialsCollection).doc(documentId).delete();
    _firestore.collection(KOrdersCollection).doc(documentId).delete();
  }
  
}
