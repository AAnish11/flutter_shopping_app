import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoap_app/providers/products.provider.dart';
import '../models/product.model.dart';
import '../helpers/dialog-alert.helper.dart';

class AddProductScreen extends StatefulWidget {
  static const path = '/add-edit-product';

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final FocusNode _priceNode = FocusNode();
  final FocusNode _description = FocusNode();
  final FocusNode _image = FocusNode();
  final _imageContoller = TextEditingController(text: '');
  final _productNameController = TextEditingController(text: '');
  final _productPriceController = TextEditingController(text: '');
  final _productDescController = TextEditingController(text: '');
  String _prodId = '';

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((_) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        Product productData =
            Provider.of<ProductsProvider>(context, listen: false)
                .productById(productId);
        _prodId = productId;
        _productNameController.text = productData.title;
        _productPriceController.text = productData.price.toString();
        _productDescController.text = productData.description;
        _imageContoller.text = productData.imageUrl;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _priceNode.dispose();
    _description.dispose();
    super.dispose();
  }

  void _closeSpinner() {
    Navigator.of(context).pop();
  }

  Future<void> _submitForm() async {
    if (!_formState.currentState.validate()) {
      return;
    }
    FocusScope.of(context).unfocus(); // close keyboard programatically
    DialogAlertsHelper.showSpinner(context); // show loading indicator
    _formState.currentState.save();
    try {
      String msg = 'Product added successfully';
      if (_prodId != '') {
        msg = 'Product update successfully';
        await Provider.of<ProductsProvider>(context, listen: false).updateItem(
          _prodId,
          _productNameController.text,
          _productDescController.text,
          _imageContoller.text,
          double.parse(_productPriceController.text),
        );
      } else {
        await Provider.of<ProductsProvider>(context, listen: false).addNewItem(
          _productNameController.text,
          _productDescController.text,
          _imageContoller.text,
          double.parse(_productPriceController.text),
        );
      }
      _closeSpinner();
      DialogAlertsHelper.showSuccessMsg(context, msg,
          () {
        Navigator.of(context).pop();
      });
    } catch (err) {
      _closeSpinner();
      DialogAlertsHelper.showErrorMsg(context, 'Something went wrong', () {
        // TODO::
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final editId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(editId !=  null ? 'Edit Product' : 'Add Prodduct'),
        actions: [
          IconButton(
            icon: Icon(Icons.save_outlined),
            onPressed: _submitForm,
          ),
        ],
      ),
      body: Form(
        key: _formState,
        child: ListView(
          padding: EdgeInsets.all(2),
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              controller: _productNameController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8),
                labelText: 'Product Name',
                suffixIcon: const Icon(Icons.shopping_cart),
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter product name';
                }
                if (value.length < 3) {
                  return 'Product name must atleat 3 char or long';
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _productPriceController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8),
                labelText: 'Product Price',
                suffixIcon: const Icon(Icons.money),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter product price';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter valid price';
                }
                if (double.parse(value) <= 0) {
                  return 'Price must be greater than 0';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              focusNode: _priceNode,
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              controller: _productDescController,
              maxLines: 3,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8),
                labelText: 'Description',
                suffixIcon: const Icon(Icons.description),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter product description';
                }
                if (value.length < 10) {
                  return 'Description must be atleast 10 char or long';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              focusNode: _description,
              onFieldSubmitted: (_) {
                _submitForm();
              },
            ),
            TextFormField(
              keyboardType: TextInputType.url,
              controller: _imageContoller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  labelText: 'Image Url',
                  suffixIcon: const Icon(Icons.image)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter image URL';
                }
                if (!value.startsWith('http') && !value.startsWith('https')) {
                  return 'Please enter valid url';
                }
                return null;
              },
              focusNode: _image,
            ),
          ],
        ),
      ),
    );
  }
}
