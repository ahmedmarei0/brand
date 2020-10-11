import 'package:brand/constant/constant_element.dart';
import 'package:brand/provider/change_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  final String value;
  String _errorMessage(hint) {
    switch (hint) {
      case 'Enter Your Name':
        return "Name Is Emapty";
      case 'Enter Your Email':
        return "Email Is Emapty";
      case 'Enter Your Password':
        return "Password Is Emapty";
    }
    return "Field is Required";
  }

  const CustomTextField(
      {@required this.onClick,
      @required this.icon,
      @required this.hint,
      this.value});

  @override
  Widget build(BuildContext context) {
    MainColorApp mainColorApp = Provider.of<MainColorApp>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7),
      child: TextFormField(
        style: TextStyle(
            fontSize: 20,
            color: mainColorApp.color,
            fontWeight: FontWeight.bold,
            fontFamily: KLateef),
        obscureText:
            hint == "Enter your password" || hint == "ادخــل الرقم السرى"
                ? true
                : false,
        initialValue: value,
        onSaved: onClick,
        validator: (val) {
          if (val.isEmpty) {
            return _errorMessage(hint);
            // ignore: missing_return
          }
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          prefixIcon: Icon(
            icon,
            color: mainColorApp.color,
          ),
          hintText: hint,
          focusColor: KWhite,
          fillColor: KWhite,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.orange,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.orange,
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.orange,
              )),
        ),
      ),
    );
  }
}
