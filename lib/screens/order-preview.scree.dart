import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/order-card.widget.dart';
import '../widgets/order-item-list.widget.dart';
import '../providers/cart.provider.dart';

class OrderPreviewScreen extends StatelessWidget {
  static const path = '/order-preview';
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      floatingActionButton: Consumer<CartProvider>(
        builder: (_, cartProvider, __) => FloatingActionButton(
          onPressed: () {
            cartProvider.clearCart();
          },
          elevation: 16,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          child: Icon(Icons.delete),
        ),
      ),
      appBar: AppBar(
        title: Text('Order Preview'),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            OrderCardWidget(cartProvider.totalAmount, cartProvider.allCartItem),
            OrderItemListWidget(cartProvider.allCartItem),
          ],
        ),
      ),
    );
  }
}
