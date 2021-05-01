import 'package:flutter/material.dart';
import '../models/cart.model.dart';

class OrderItemListWidget extends StatelessWidget {
  final Map<String, CartModel> items;
  OrderItemListWidget(this.items);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
        itemBuilder: (ctx, i) {
          final itemData = items.values.toList()[i];
          return Card(
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: FittedBox(
                      child: Text(
                        itemData.price.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(itemData.title),
                subtitle: Text('Each price: ${itemData.price}'),
                trailing: Text('Qty: x ${itemData.qty} '),
              ),
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
