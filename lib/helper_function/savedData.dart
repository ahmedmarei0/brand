
import 'package:brand/constant/constant_element.dart';
import 'package:shared_preferences/shared_preferences.dart';

setKeepMeLoginData(bool val) async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool(KeepingMeLoginKey, val);
}
Future<bool> getKeepMeLoginData() async{
   SharedPreferences ref = await SharedPreferences.getInstance();
    bool val = ref.getBool(KeepingMeLoginKey);
    return val;
}

setIsUserData(bool val) async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool(KUserType, val);
}
Future<bool> getIsUserData() async{
   SharedPreferences ref = await SharedPreferences.getInstance();
    bool val = ref.getBool(KUserType);
    return val;
}

bool getValueFromBoolPref(val){
  bool b = false;
   getIsUserData().then((bool value){
    b = value;
    
  });
  
  return b;
}