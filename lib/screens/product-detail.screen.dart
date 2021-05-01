import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.model.dart';
import '../providers/products.provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const path = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final Product product =
        Provider.of<ProductsProvider>(context).productById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Card(
                elevation: 8,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              child: Card(
                elevation: 16,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('${product.title}'),
                      Text('${product.price}'),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
