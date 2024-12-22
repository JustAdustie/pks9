import 'package:flutter/material.dart';

class CartPageStyles {
  static const Color backgroundColor = Color(0xFFD6EAF8);
  static const Color cardColor = Color(0xFFBB8FCE);
  static const Color appBarColor = Color(0xFF5DADE2);

  static const appBarTitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );

  static const cartItemTitleStyle = TextStyle(
    fontSize: 16,
    color: Color(0xFF34495E),
    fontWeight: FontWeight.w500,
  );

  static const cartItemDescriptionStyle = TextStyle(
    fontSize: 14,
    color: Color(0xFF7D4B87),
  );

  static const priceTextStyle = TextStyle(
    fontSize: 14,
    color: Color(0xFF2C3E50),
    fontWeight: FontWeight.w700,
  );

  static const buttonTextStyle = TextStyle(
    fontSize: 18.0,
    color: Colors.white,
  );

  static final cartButtonStyle = TextButton.styleFrom(
    backgroundColor: Color(0xFF9B59B6),
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 60.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  );

  static const dialogTitleStyle = TextStyle(fontSize: 18.0, color: Colors.white);

  static const dialogTextStyle = TextStyle(
    fontSize: 16.0,
    color: Color(0xFF9B59B6),
  );

  static const dialogDeleteTextStyle = TextStyle(
    fontSize: 16.0,
    color: Color(0xFFE74C3C),
  );
}
