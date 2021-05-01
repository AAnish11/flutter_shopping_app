import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.model.dart';
import './add-cart-button.widget.dart';
import './add-product-fav-btn.widget.dart';
import './navigate-product-detail.widget.dart';

class ProductListViewItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context);
    return Card(
      elevation: 16,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: NavigateProductDetailWidget(
            Container(
              width: 80,
              child: Image.network(
                productData.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            productData.id,
          ),
          title: Text(
            productData.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Text(
            productData.price.toString(),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                AddProductToFavouriteBtnWidget(),
                AddToCartItemWidget(
                    productData.id, productData.title, productData.price),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
