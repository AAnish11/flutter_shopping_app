import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.provider.dart';

class AddToCartItemWidget extends StatelessWidget {
  final String productId;
  final String productTitle;
  final double productPrice;
  AddToCartItemWidget(this.productId, this.productTitle, this.productPrice);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (_, cartData, __) {
        return IconButton(
          onPressed: () {
            cartData.addProductToCart(productId, productTitle, productPrice);
          },
          color: Theme.of(context).accentColor,
          icon: Icon(Icons.shopping_cart_outlined),
        );
      },
    );
  }
}
