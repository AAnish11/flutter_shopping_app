import 'dart:ui';

import 'package:flutter/material.dart';
import '../screens/orders.screen.dart';
import '../screens/my-products.screen.dart';

class AppDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 16,
        child: Column(
          children: [
            Container(
              height: 200,
              color: Colors.purple,
              padding: const EdgeInsets.all(16),
              child: Center(
                  child: const Text(
                'My Shopping App',
                style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              )),
            ),
            ListTile(
            leading: const Icon(Icons.list),
            title: const Text(
              'Products',
              style: (TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: const  Icon(Icons.shopping_bag_rounded),
            title: const Text(
              'Orders',
              style: (TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(OrdersScreen.path);
            },
          ),
          Divider(),
          ListTile(
            leading: const  Icon(Icons.shopping_bag_rounded),
            title: const Text(
              'My Products',
              style: (TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(MyProductsScreen.path);
            },
          )
          ],
        ));
  }
}
