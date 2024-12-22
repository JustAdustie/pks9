import 'package:flutter/material.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/product_model.dart';
import '../styles/add_item_page_styles.dart';  // Import the new styles class

class AddFlavorScreen extends StatefulWidget {
  const AddFlavorScreen({super.key});
  @override
  _AddFlavorScreenState createState() => _AddFlavorScreenState();
}

class _AddFlavorScreenState extends State<AddFlavorScreen> {
  final TextEditingController _nameFlavorController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _dopController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AddItemPageStyles.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Добавить новый автомобиль",
          style: AddItemPageStyles.appBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            _buildTextField(_nameFlavorController, "Название автомобиля"),
            const SizedBox(height: 10),
            _buildTextField(_imageController, "Ссылка на картинку"),
            const SizedBox(height: 10),
            _buildTextField(_descController, "Описание"),
            const SizedBox(height: 10),
            _buildTextField(_dopController, "Дополнительная информация"),
            const SizedBox(height: 10),
            _buildTextField(_priceController, "Цена"),
            const SizedBox(height: 40),
            ElevatedButton(
              style: AddItemPageStyles.saveButtonStyle,
              onPressed: () async {
                double price = double.parse(_priceController.text);
                int newId = await ApiService().getCountShopCartProducts();

                if (_nameFlavorController.text.isNotEmpty &&
                    _imageController.text.isNotEmpty &&
                    _descController.text.isNotEmpty &&
                    _dopController.text.isNotEmpty &&
                    _priceController.text.isNotEmpty) {
                  await ApiService().createProduct(Product(
                      id: newId,
                      name: _nameFlavorController.text,
                      description: _descController.text,
                      price: price,
                      imageUrl: _imageController.text,
                      feature: _dopController.text,
                      isInCart: false,
                      quantity: 0,
                      isFavourite: false));
                  Navigator.pop(context);
                  print("новый автомобиль добавлен");
                } else {
                  print("не все поля заполнены");
                }
              },
              child: const Text(
                "Сохранить",
                style: AddItemPageStyles.saveButtonTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  // Helper method to avoid repeating code for text fields
  Widget _buildTextField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AddItemPageStyles.appBarColor,
        hintText: hintText,
        hintStyle: AddItemPageStyles.textFieldHintStyle,
        contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 13.0),
        enabledBorder: AddItemPageStyles.textFieldEnabledBorder,
        focusedBorder: AddItemPageStyles.textFieldFocusedBorder,
      ),
    );
  }
}
