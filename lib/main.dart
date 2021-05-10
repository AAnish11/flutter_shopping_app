import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:shoap_app/providers/auth.provider.dart';

import './screens/orders.screen.dart';
import './screens/product-detail.screen.dart';
import './screens/order-preview.scree.dart';
import './screens/products-overview.screen.dart';
import './screens/my-products.screen.dart';
import './screens/add-product.screen.dart';
import './screens/auth.screen.dart';
import './providers/orders.provider.dart';
import './providers/products.provider.dart';
import './providers/cart.provider.dart';

// void main() {
//   runApp(MyApp());
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          create: (ctx) => ProductsProvider([]),
          update: (ctx, authProvider, previousProductProviderDara) =>
              ProductsProvider(previousProductProviderDara.allProducts),
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
        home: Consumer<AuthProvider>(
          builder: (ctx, authProvider, _) {
            return authProvider.isLoggedIn
                ? ProductOverviewScreen()
                : (FutureBuilder<bool>(
                    future: authProvider.tryAutoLogin(),
                    builder: (ctx, asyncSnapshot) {
                      return asyncSnapshot.connectionState ==
                              ConnectionState.done
                          ? (asyncSnapshot.data == true ? ProductOverviewScreen() : AuthScreen())
                          : Scaffold(
                              body: Center(
                                child: Text(
                                  'My Shop App - Loading....',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            );
                    },
                  ));
          },
        ),
        routes: {
          // '/': (ctx) => ProductOverviewScreen(),
          OrderPreviewScreen.path: (ctx) => OrderPreviewScreen(),
          ProductDetailScreen.path: (ctx) => ProductDetailScreen(),
          OrdersScreen.path: (ctx) => OrdersScreen(),
          MyProductsScreen.path: (ctx) => MyProductsScreen(),
          AddProductScreen.path: (ctx) => AddProductScreen(),
        },
      ),
    );
  }
}
