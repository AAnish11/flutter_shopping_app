import 'package:flutter/material.dart';
import 'package:shoap_app/models/cart.model.dart';

class Orders {
  final String id;
  final double totalPrice;
  final List<CartModel> items;
  final DateTime orderTime;

  Orders({
    @required this.id,
    @required this.items,
    @required this.totalPrice,
    @required this.orderTime
  });

}