import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.model.dart';
import '../providers/products.provider.dart';
import './product-list-view-item.widget.dart';

class ProductListViewWidget extends StatelessWidget {
  final bool onlyFavourites;
  ProductListViewWidget(this.onlyFavourites);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final List<Product> products = onlyFavourites
        ? productsProvider.favouriteProducts
        : productsProvider.allProducts;
    return ListView.builder(
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductListViewItemWidget(),
      ),
      itemCount: products.length,
    );
  }
}
