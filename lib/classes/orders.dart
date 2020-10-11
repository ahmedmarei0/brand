import 'package:flutter/cupertino.dart';

class Order{
  final String id;
  final String name;
  final String address;
  final String phone;
  final double totalPrice;

  Order({@required this.name,@required this.address,@required this.phone,@required this.totalPrice,@required this.id});
}