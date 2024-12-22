import 'package:flutter/material.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/product_model.dart';
import 'package:front/pages/edit_product_page.dart';
import 'package:front/styles/itam_page_styles.dart'; // Импорт стилей

class ItamPage extends StatefulWidget {
  const ItamPage({
    super.key,
    required this.flavor,
  });
  final Product flavor;

  @override
  State<ItamPage> createState() => _ItamPageState();
}

class _ItamPageState extends State<ItamPage> {
  late Future<Product> flavors;
  bool isFavourite = false;
  bool isInCart = false;
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    flavors = ApiService().getProductById(widget.flavor.id);
    ApiService().getProductById(widget.flavor.id).then((i) {
      setState(() {
        quantity = i.quantity;
        isFavourite = i.isFavourite;
        isInCart = i.isInCart;
      });
    });
  }

  Future<bool?> _showConfirmedDialog(BuildContext context, Product flavor) {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text(
                'Удалить автомобиль?',
                style: ItamPageStyles.alertTitleTextStyle,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(
                  flavor.imageUrl,
                  width: 150,
                  height: 150,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Ошибка загрузки изображения');
                  },
                ),
                const SizedBox(height: 10),
                Text(flavor.name),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  "Отмена",
                  style: ItamPageStyles.alertCancelButtonTextStyle,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  "Удалить",
                  style: ItamPageStyles.alertDeleteButtonTextStyle,
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product>(
      future: flavors,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Модели не добавлены'));
        }

        final items = snapshot.data!;
        return Scaffold(
          backgroundColor: ItamPageStyles.backgroundColor,
          appBar: AppBar(
            title: Text(
              widget.flavor.name,
              style: ItamPageStyles.appBarTextStyle,
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: ItamPageStyles.cardBackgroundColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isFavourite = !isFavourite;
                        });
                      },
                      icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: ItamPageStyles.iconColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isInCart = !isInCart;
                        });
                      },
                      icon: Icon(
                        isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                        color: ItamPageStyles.iconColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: Image.network(
                    widget.flavor.imageUrl,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Комплектация",
                  style: ItamPageStyles.sectionTitleTextStyle,
                ),
                Text(
                  widget.flavor.description,
                  style: ItamPageStyles.bodyTextStyle,
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Характеристики",
                  style: ItamPageStyles.sectionTitleTextStyle,
                ),
                Text(
                  widget.flavor.feature,
                  style: ItamPageStyles.bodyTextStyle,
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Цена",
                  style: ItamPageStyles.sectionTitleTextStyle,
                ),
                Text(
                  widget.flavor.price.toString(),
                  style: ItamPageStyles.bodyTextStyle,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
