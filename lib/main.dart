import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/orders.screen.dart';
import './screens/product-detail.screen.dart';
import './screens/order-preview.scree.dart';
import './screens/products-overview.screen.dart';
import './providers/orders.provider.dart';
import './providers/products.provider.dart';
import './providers/cart.provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrdersProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Shop App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.orange,
        ),
        routes: {
          '/': (ctx) => ProductOverviewScreen(),
          OrderPreviewScreen.path: (ctx) => OrderPreviewScreen(),
          ProductDetailScreen.path: (ctx) => ProductDetailScreen(),
          OrdersScreen.path: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
