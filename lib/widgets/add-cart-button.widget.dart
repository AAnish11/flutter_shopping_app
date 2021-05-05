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
            ScaffoldMessenger.of(context).removeCurrentSnackBar(); // If any exists snackbar remove it
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              elevation: 8,
              padding: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(),
              content: Row(
                children: [
                  Icon(Icons.thumb_up, color: Colors.white),
                  SizedBox(width: 8,),
                  Text(
                    'Product added to cart!',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              action: SnackBarAction(
                label: 'Done',
                onPressed: () {
                  print('undo');
                }
              ,),
            ));
            cartData.addProductToCart(productId, productTitle, productPrice);
          },
          color: Theme.of(context).accentColor,
          icon: Icon(Icons.shopping_cart_outlined),
        );
      },
    );
  }
}
