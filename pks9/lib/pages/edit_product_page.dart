import 'package:flutter/material.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/product_model.dart';
import '../styles/edit_product_page_styles.dart';  // Importing the styles file

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key, required this.flavor});
  final Product flavor;

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late Future<Product> item;
  final TextEditingController _nameFlavorController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _dopController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void initState() {
    super.initState();
    ApiService().getProductById(widget.flavor.id).then((i) => {
      _nameFlavorController.text = i.name,
      _imageController.text = i.imageUrl,
      _descController.text = i.description,
      _dopController.text = i.feature,
      _priceController.text = i.price.toString(),
    });
  }

  void dispose() {
    _nameFlavorController.dispose();
    _imageController.dispose();
    _descController.dispose();
    _dopController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Изменение данных автомобиля",
          style: AppStyles.appBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLabelText('Название модели'),
              buildTextField(_nameFlavorController, 'Имя пользователя'),
              const SizedBox(height: 10),
              buildLabelText('фото автомобиля'),
              buildTextField(_imageController, 'ссылка на фото автомобиля'),
              const SizedBox(height: 10),
              buildLabelText('Комплектация'),
              buildTextField(_descController, 'Комплектация'),
              const SizedBox(height: 10),
              buildLabelText('Характеристики'),
              buildTextField(_dopController, 'Характеристики'),
              const SizedBox(height: 10),
              buildLabelText('Цена'),
              buildTextField(_priceController, 'Цена'),
              const SizedBox(height: 60),
              Center(
                child: ElevatedButton(
                  style: AppStyles.buttonStyle,
                  onPressed: () async {
                    double price = double.parse(_priceController.text);
                    if (_nameFlavorController.text.isNotEmpty &&
                        _imageController.text.isNotEmpty &&
                        _descController.text.isNotEmpty &&
                        _dopController.text.isNotEmpty &&
                        _priceController.text.isNotEmpty) {
                      await ApiService().changeProductStatus(Product(
                          id: widget.flavor.id,
                          name: _nameFlavorController.text,
                          imageUrl: _imageController.text,
                          description: _descController.text,
                          feature: _dopController.text,
                          price: price,
                          isFavourite: widget.flavor.isFavourite,
                          isInCart: widget.flavor.isInCart,
                          quantity: widget.flavor.quantity));
                      Navigator.pop(context);
                      print("Информация машины обновлена");
                    } else {
                      print("Информация машины НЕ обновлена");
                    }
                  },
                  child: const Text(
                    "Сохранить",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildLabelText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
      child: Text(
        text,
        style: AppStyles.labelTextStyle,
      ),
    );
  }

  TextField buildTextField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        hintText: hintText,
        hintStyle: AppStyles.hintTextStyle,
        contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 13.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: AppStyles.appBarColor, width: 1),
        ),
      ),
    );
  }
}
