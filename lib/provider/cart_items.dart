import 'package:brand/classes/product.dart';
import 'package:flutter/Material.dart';

class CartItem extends ChangeNotifier {

  List<Product> products = [];
  double totalPrice =0;
  Color color = Colors.pink;
  addToCart(Product product) {
    products.add(product);
    notifyListeners();
  }

  deleteItemCart(Product p) {
    products.remove(p);
    notifyListeners();
  }
  changeMyColor(Color c){
    color = c;
    notifyListeners();
    
  }
  clearItems(){
    products.clear();
    notifyListeners();
  }
  
}
