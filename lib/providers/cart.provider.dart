import 'package:flutter/foundation.dart';
import '../models/cart.model.dart';

class CartProvider with ChangeNotifier {
  // Map <String productId, CartModel> as List

  Map<String, CartModel> _cartItems = {};

  int get cartCount {
    return _cartItems == null ? 0 :  _cartItems.length;
  }

  String get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, value) { 
      total += value.price * value.qty;
    });
    return total.toStringAsFixed(2);
  }
  

  void addProductToCart(String pId, String pTitle, double pPrice) {
    if (_cartItems.containsKey(pId)) {
      _cartItems.update(
        pId,
        (oldValue) => CartModel(
            id: oldValue.id,
            price: oldValue.price,
            qty: oldValue.qty + 1,
            title: oldValue.title),
      );
    } else {
      _cartItems.putIfAbsent(
        pId,
        () => CartModel(
          id: DateTime.now().toString(),
          price: pPrice,
          qty: 1,
          title: pTitle,
        ),
      );
      notifyListeners();
    }
  }

  Map<String, CartModel> get allCartItem {
    return _cartItems;
  }
  void clearCart() {
    _cartItems = {};
    notifyListeners();
  }
}
