import 'package:flutter/material.dart';

class CartModel {
  final String id;
  final String title;
  final double price;
  final int qty;

  CartModel({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.qty
  });

}