import 'package:flutter/material.dart';
import 'package:front/models/product_model.dart';
import 'package:front/models/api_service.dart';

class CartItem extends StatefulWidget {
  CartItem({
    super.key,
    required this.flavorId,
    required this.flavorName,
    required this.flavorImg,
    required this.flavorDesc,
    required this.flavorPrice,
    required this.flavorNum,
    //required this.onDelete,
    required this.navToItemPage,
    //required this.updateQuantity,
  });
  //final Function(Flavor) onDelete;
  final int flavorId;
  final String flavorName;
  final String flavorImg;
  final String flavorDesc;
  final double flavorPrice;
  int flavorNum;

  final Function(int i) navToItemPage;
  //final Function(int id, int num) updateQuantity;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late Future<List<Product>> _cartProducts;

  @override
  void initState() {
    super.initState();
    _cartProducts = ApiService().getCart();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {widget.navToItemPage(widget.flavorId)},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Image.network(
                  widget.flavorImg,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          widget.flavorName,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          widget.flavorDesc,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 65, 65, 65)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Цена: ${(widget.flavorPrice * widget.flavorNum).toString()} ₽",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 65, 65, 65),
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () => {
                          /*ApiService().updateProductQuantityInCart(
                              widget.flavorId, widget.flavorNum + 1),*/
                          print(ApiService().getProductById(widget.flavorId))
                        },
                    icon: const Icon(Icons.remove)),
                Text(''),
                IconButton(
                    onPressed: () {
                      if (widget.flavorNum > 1) {
                        /*ApiService().updateProductQuantityInCart(
                            widget.flavorId, widget.flavorNum - 1);*/
                        setState(() {
                          widget.flavorNum -= 1;
                        });
                      }
                    },
                    icon: const Icon(Icons.add)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
