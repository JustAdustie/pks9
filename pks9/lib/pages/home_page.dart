import 'package:flutter/material.dart';
import 'package:front/pages/add_item_page.dart';
import 'package:front/pages/itam_page.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/product_model.dart';
import 'package:front/styles/home_page_styles.dart';
import '../pages/flavor_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Product>> _products;
  late List<Product> _productsUpd;

  @override
  void initState() {
    super.initState();
    _products = ApiService().getProducts();
    ApiService().getProducts().then((el) {
      _productsUpd = el;
    });
  }

  void _setUpd() {
    setState(() {
      _products = ApiService().getProducts();
      ApiService().getProducts().then((el) {
        _productsUpd = el;
      });
    });
  }

  void _navigateToAddFlavorScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddFlavorScreen()),
    );
    _setUpd();
  }

  void _addToFavorites(Product i) {
    final updatedProduct = i.copyWith(isFavourite: !i.isFavourite);
    ApiService().changeProductStatus(updatedProduct);
    setState(() {
      final index = _productsUpd.indexWhere((j) => j.id == i.id);
      if (index != -1) {
        _productsUpd[index] = updatedProduct;
      }
    });
    _setUpd();
  }

  void addTOCart(Product i) {
    final updatedProduct = i.copyWith(
      isInCart: !i.isInCart,
      quantity: i.isInCart ? 0 : 1,
    );
    ApiService().changeProductStatus(updatedProduct);
    setState(() {
      final index = _productsUpd.indexWhere((j) => j.id == i.id);
      if (index != -1) {
        _productsUpd[index] = updatedProduct;
      }
    });
    _setUpd();
  }

  void _openItem(int id) async {
    final product = await ApiService().getProductById(id);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItamPage(flavor: product),
      ),
    );
    _setUpd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyHomePageStyles.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Модели машин",
          style: MyHomePageStyles.appBarTextStyle,
        ),
        backgroundColor: MyHomePageStyles.appBarBackgroundColor,
      ),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Модели не добавлены'));
          }

          final items = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.61,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final flavor = items[index];
              return GestureDetector(
                onTap: () => _openItem(flavor.id),
                child: FlavorCard(
                  flavor: flavor,
                  onFavoritePressed: () => _addToFavorites(flavor),
                  onCartPressed: () => addTOCart(flavor),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddFlavorScreen(context),
        tooltip: 'Добавить модель',
        child: const Icon(Icons.add),
      ),
    );
  }
}
