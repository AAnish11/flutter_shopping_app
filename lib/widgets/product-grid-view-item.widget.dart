import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoap_app/widgets/navigate-product-detail.widget.dart';
import '../models/product.model.dart';
import 'add-cart-button.widget.dart';
import 'add-product-fav-btn.widget.dart';

class ProductItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // fetch data only once time and avoid when next the data gets changed/updated
    final product = Provider.of<Product>(context, listen: false);
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(16),
      child: GridTile(
        child: NavigateProductDetailWidget(
          Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          product.id,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          leading: AddProductToFavouriteBtnWidget(),
          trailing:
              AddToCartItemWidget(product.id, product.title, product.price),
        ),
      ),
    );
  }
}
