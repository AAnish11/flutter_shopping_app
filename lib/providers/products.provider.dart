import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product.model.dart';
import '../constants/product-dummy-data.constant.dart';
import '../config/http.config.dart';

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

  Future<void> addNewProduct(
      String title, String description, double price) async {
    final url = Uri.https(END_POINTS, ADD_PRODUCT);
    const bool isFavourite = false;
    const String imageUrl =
        'https://images-na.ssl-images-amazon.com/images/I/610irNyucGL._UL1500_.jpg';
    final postData = json.encode({
      title: title,
      description: description,
      price: price,
      isFavourite: isFavourite,
      imageUrl: imageUrl
    });
    try {
      final dynamic response = await http.post(url, body: postData);
      print(json.decode(response));
    } catch (error) {
      throw error;
    }
  }

  // Post: Http Request Submitting New Product Data

  Future<void> addNewItem(
      String title, String description, String img, double price) async {
    try {
      final url = Uri.https('$END_POINTS', '$ADD_PRODUCT');
      final body = json.encode({
        'title': title,
        'description': description,
        'price': price,
        'isFavourite': 0,
        'imageUrl': img
      });
      http.Response response = await http.post(url, body: body);
      Product localItem = Product(
        id: jsonDecode(response.body)['name'],
        title: title,
        description: description,
        isFavourite: false,
        imageUrl: img,
        price: price,
      );
      _products.insert(0, localItem);
      notifyListeners();
      Future.value();
    } catch (err) {
      print('Add Item: error block');
      throw err.toString();
    }
  }

  Future<void> updateItem(String productId, String title, String description,
      String img, double price) async {
    try {
      final url = Uri.https('$END_POINTS', '$EDIT_PRODUCT/${productId}.json');
      final body = json.encode({
        'title': title,
        'description': description,
        'price': price,
        'imageUrl': img
      });
      await http.patch(url, body: body);
      final oldProduct = _products.firstWhere((prod) => prod.id == productId);
      final index = _products.indexWhere((prod) => prod.id == productId);
      _products[index] = Product(
        id: oldProduct.id,
        title: title,
        description: description,
        imageUrl: img,
        isFavourite: oldProduct.isFavourite,
        price: price
      );
      notifyListeners();
      Future.value();
    } catch (err) {
      print('updateItem: error block');
      throw err.toString();
    }
  }

  Future<void> getProducts() async {
    try {
      final url = Uri.https('$END_POINTS', '$ADD_PRODUCT');
      http.Response response = await http.get(url);
      if (response.body.length > 0) {
        List<Product> fetchedProduct = [];
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        data.forEach((key, value) {
          final mappedValue = (value as Map);
          fetchedProduct.add(Product(
              id: key,
              title: mappedValue['title'],
              imageUrl: mappedValue['imageUrl'],
              description: mappedValue['description'],
              price: mappedValue['price'],
              isFavourite: mappedValue['isFavourite'] == 1));
        });
        _products = fetchedProduct;
      }
      Future.value();
      notifyListeners();
    } catch (err) {
      print('Get Items: error block');
      throw err;
    }
  }

  Future<void> updateProductLikeDislike(String productId, bool status) async {
    try {
      final url = Uri.https('$END_POINTS', '$EDIT_PRODUCT/${productId}.json');
      print(status);
      await http.patch(
        url,
        body: jsonEncode({'isFavourite': status == true ? 1 : 0}),
      );
      Future.value();
    } catch (err) {
      print('updateProductLikeDislike: error block');
      throw err;
    }
  }

  Future<void> deleteItemById(String productId) async {
    try {
      final url = Uri.https('$END_POINTS', '$EDIT_PRODUCT/${productId}.json');
      http.Response resp = await http.delete(url);
      print(jsonDecode(resp.body));
      _products.removeWhere((product) => product.id == productId);
      notifyListeners();
      Future.value();
    } catch (err) {
      print('deleteItemById: Error');
      throw err;
    }
  }
}
