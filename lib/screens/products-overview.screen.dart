import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.provider.dart';
import '../widgets/app-drawer.widget.dart';
import '../providers/cart.provider.dart';
import '../screens/order-preview.scree.dart';
import '../widgets/product-grid-view.widget.dart';
import '../widgets/product-list-view.widget.dart';
import '../widgets/badge.dart';

enum FilterOptions { OnlyFavourite, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool onleFavs = false;
  bool isGridView = true;
  bool isFetched = false;

  Future<void> _fetchProduct() async {
    try {
      await Provider.of<ProductsProvider>(context, listen: false).getProducts();
    } catch (err) {}
  }
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!isFetched) {
      _fetchProduct();
    }
    setState(() {
      isFetched = true;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          PopupMenuButton(
            elevation: 16,
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                onleFavs = selectedValue == FilterOptions.OnlyFavourite;
              });
            },
            icon: Icon(Icons.filter_alt_outlined),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: const Text('Only Favourite'),
                value: FilterOptions.OnlyFavourite,
              ),
              PopupMenuItem(
                child: const Text('All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<CartProvider>(
            builder: (_, cartProvider, widgetItem) => Badge(
              child: widgetItem,
              value: cartProvider.cartCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(OrderPreviewScreen.path);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 100,
                child: Card(
                  child: Center(
                    child: ListTile(
                      title: const Text(
                        'Change View',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          setState(() {
                            isGridView = !isGridView;
                          });
                        },
                        child: Icon(!isGridView ? Icons.grid_view : Icons.list),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                child: isGridView
                    ? ProductGridView(onleFavs)
                    : ProductListViewWidget(onleFavs),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
