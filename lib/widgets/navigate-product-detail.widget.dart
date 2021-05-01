import 'package:flutter/material.dart';
import '../screens/product-detail.screen.dart';

class NavigateProductDetailWidget extends StatelessWidget {
  final Widget widget;
  final String productId;
  NavigateProductDetailWidget(this.widget, this.productId);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetailScreen.path, arguments: productId);
      },
      child: widget,);
  }
}