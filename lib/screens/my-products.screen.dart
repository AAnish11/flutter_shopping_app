import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoap_app/helpers/dialog-alert.helper.dart';
import '../providers/products.provider.dart';
import './add-product.screen.dart';

class MyProductsScreen extends StatelessWidget {
  static const path = '/my-products';
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).allProducts;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_outlined, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushNamed(AddProductScreen.path);
            },
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (_, i) {
          return Container(
            key: Key(products[i].id),
            height: 80,
            child: Card(
              elevation: 8,
              child: ListTile(
                title: Text(products[i].title),
                leading: CircleAvatar(
                  child: Image.network(
                    products[i].imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                trailing: Container(
                  width: 120,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.black),
                        onPressed: () {
                          Navigator.of(context).pushNamed(AddProductScreen.path,
                              arguments: products[i].id);
                        },
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          DialogAlertsHelper.showAlert(
                              context, 'Are you sure, you want to delete?',
                              (value) async {
                            if (value) {
                              try {
                                DialogAlertsHelper.showSpinner(context);
                                await Provider.of<ProductsProvider>(context,
                                        listen: false)
                                    .deleteItemById(products[i].id);
                                    Navigator.of(context).pop();
                                DialogAlertsHelper.showSnackBarMessage(context, 'Product successfully deleted!');
                              } catch (err) {
                                Navigator.of(context).pop();
                                DialogAlertsHelper.showSnackBarMessage(context, 'Something went wrong!');
                              }
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: products.length,
      ),
    );
  }
}
