import 'package:flutter/Material.dart';

class MainColorApp extends ChangeNotifier {

  Color color = Colors.teal;
  changeMyColor(Color c){
    color = c;
    notifyListeners();
    
  }
}