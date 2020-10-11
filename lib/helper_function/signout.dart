import 'package:brand/constant/constant_element.dart';
import 'package:brand/helper_function/savedData.dart';
import 'package:brand/provider/cart_items.dart';
import 'package:brand/routes/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

signoutUser(context) async{
    
    await FirebaseAuth.instance.signOut();

    setKeepMeLoginData(false);
    setIsUserData(true);

    Navigator.of(context).pushNamedAndRemoveUntil(
        loginUpRoute, (Route<dynamic> route) => false);
}