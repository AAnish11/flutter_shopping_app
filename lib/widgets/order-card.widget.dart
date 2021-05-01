import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoap_app/models/cart.model.dart';
import 'package:shoap_app/providers/cart.provider.dart';
import 'package:shoap_app/providers/orders.provider.dart';

class OrderCardWidget extends StatelessWidget {
  final String amount;
  final Map<String, CartModel> items;

  OrderCardWidget(this.amount, this.items);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 16,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Total Price'),
              Spacer(),
              Chip(
                backgroundColor: Colors.purple,
                label: Text(
                  '$amount',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 6),
              if (double.parse(amount) > 0) Consumer<OrdersProvider>(
                builder: (_, orderProvider, child) => TextButton(
                onPressed: () {
                  orderProvider.submitNewOrder(items, double.parse(amount));
                  Provider.of<CartProvider>(context, listen: false).clearCart();
                  Navigator.of(context).pop();
                },
                child: child,
                ),
                child: const Text('Order Now'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
