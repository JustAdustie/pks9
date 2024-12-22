import 'package:flutter/material.dart';
import 'package:front/models/product_model.dart';

class FlavorCard extends StatelessWidget {
  final Product flavor;
  final VoidCallback onFavoritePressed;
  final VoidCallback onCartPressed;

  const FlavorCard({
    Key? key,
    required this.flavor,
    required this.onFavoritePressed,
    required this.onCartPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Image.network(flavor.imageUrl, width: 110, height: 110, fit: BoxFit.cover),
          const SizedBox(height: 20.0),
          Text(
            flavor.name,
            maxLines: 2,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            "Цена: ${flavor.price}",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onFavoritePressed,
                icon: Icon(
                  flavor.isFavourite ? Icons.favorite : Icons.favorite_border,
                ),
              ),
              IconButton(
                onPressed: onCartPressed,
                icon: Icon(
                  flavor.isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
