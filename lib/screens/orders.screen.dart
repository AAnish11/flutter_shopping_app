import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoap_app/providers/orders.provider.dart';

class OrdersScreen extends StatelessWidget {
  static const path = '/my-orders';
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrdersProvider>(context).allOrders;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        elevation: 16,
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            child: Card(
              elevation: 16,
              child: Center(
                child: Text(
                  'Total orders: ${orders.length}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
              itemBuilder: (ctx, int index) {
                final orderData = orders[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FittedBox(
                            child: Text(
                              orderData.totalPrice.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      title: Text('Order Time'),
                      subtitle: Text('${orderData.orderTime}'),
                      trailing: Icon(Icons.keyboard_arrow_right_sharp, size: 38,),
                      
                    ),
                  ),
                );
              },
              itemCount: orders.length,
            ),
          )
        ],
      ),
    );
  }
}
