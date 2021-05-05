import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/dialog-alert.helper.dart';
import '../providers/products.provider.dart';
import '../models/product.model.dart';

class AddProductToFavouriteBtnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Product>(
      builder: (_, product, __) => IconButton(
        icon: Icon(
          product.isFavourite ? Icons.favorite_outlined : Icons.favorite_border,
        ),
        color: Theme.of(context).accentColor,
        onPressed: () async {
          DialogAlertsHelper.showSpinner(context);
          try {
            await Provider.of<ProductsProvider>(context, listen: false)
                .updateProductLikeDislike(product.id, !product.isFavourite);
            Navigator.of(context).pop();
            product.onToggleFaviouriteHandler();
          } catch (err) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
