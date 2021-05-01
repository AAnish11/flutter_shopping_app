import 'package:flutter/material.dart';

import '../models/product.model.dart';
import '../constants/product-dummy-data.constant.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = DUMMY_PRODUCTS;

  List<Product> get allProducts {
    return [..._products];
  }

  List<Product> get favouriteProducts {
    return [..._products].where((prod) => prod.isFavourite == true).toList();
  }

  Product productById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }
}
