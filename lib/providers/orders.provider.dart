import 'package:flutter/foundation.dart';
import 'package:shoap_app/models/cart.model.dart';
import '../models/orders.model.dart';

class OrdersProvider with ChangeNotifier {
  List<Orders> _orders = [];

  void submitNewOrder(Map<String, CartModel> orderItems, double totalPrice) {
    var orderTime = DateTime.now();
    final List<CartModel> tmpItems = [];
    orderItems.forEach((key, value) { 
      print(value.id);
      tmpItems.add(value);
    });
    _orders.insert(
      0,
      Orders(
        id: orderTime.toString(),
        totalPrice: totalPrice,
        orderTime: orderTime,
        items: tmpItems,
      ),
    );
    notifyListeners();
  }

  List<Orders> get allOrders {
    return [..._orders];
  }
}
