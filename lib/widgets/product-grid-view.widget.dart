import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product-grid-view-item.widget.dart';
import '../models/product.model.dart';
import '../providers/products.provider.dart';

class ProductGridView extends StatelessWidget {
  final bool onlyFavourites;
  ProductGridView(this.onlyFavourites);
  
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final List<Product> products = onlyFavourites ? productsProvider.favouriteProducts :  productsProvider.allProducts;
    return  GridView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3 / 2,
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (BuildContext ctx, int i) => ChangeNotifierProvider.value(
              value: products[i],
              child: ProductItemWidget(),
      ),
    );
  }
}
