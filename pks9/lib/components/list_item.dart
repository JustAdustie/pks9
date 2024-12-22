import 'package:flutter/material.dart';
//import 'package:front/models/info.dart';
import 'package:front/models/product_model.dart';
import 'package:front/models/api_service.dart';

class ListItem extends StatefulWidget {
  const ListItem(
      {super.key,
      required this.flavor,
      //required this.onDelete,
      required this.onAddToFavourites,
      required this.onAddToCart,
      required this.NavToItemPage});
  final Product flavor;
  //final Function(Flavor) onDelete;
  final Function(Product) onAddToFavourites;
  final Function(Product) onAddToCart;
  final Function(int i) NavToItemPage;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late Future<Product> _product;
  @override
  void initState() {
    super.initState();
    _product = ApiService().getProductById(widget.flavor.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {widget.NavToItemPage(widget.flavor.id)},
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Column(
          children: [
            Image.network(
              widget.flavor.imageUrl,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.flavor.name,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    widget.flavor.description,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 65, 65, 65)),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Цена: ${widget.flavor.price.toString()}",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 65, 65, 65),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 3.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    widget.onAddToFavourites(widget.flavor);
                  },
                  icon: widget.flavor.isFavourite
                      ? const Icon(Icons.favorite,
                          color: Color.fromRGBO(160, 149, 108, 1))
                      : const Icon(Icons.favorite_border,
                          color: Color.fromRGBO(160, 149, 108, 1)),
                ),
                const SizedBox(width: 20.0),
                IconButton(
                  onPressed: () {
                    widget.onAddToCart(widget.flavor);
                  },
                  icon: widget.flavor.isInCart
                      ? const Icon(Icons.shopping_cart,
                          color: Color.fromRGBO(160, 149, 108, 1))
                      : const Icon(Icons.add_shopping_cart,
                          color: Color.fromRGBO(160, 149, 108, 1)),
                ),
              ],
            ),
            const SizedBox(
              height: 3.0,
            ),
          ],
        ),
      ),
    );
  }
}
