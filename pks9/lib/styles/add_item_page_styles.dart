import 'package:flutter/material.dart';

class AddItemPageStyles {
  static const Color backgroundColor = Color(0xFFD6EAF8);
  static const Color appBarColor = Color(0xFF5DADE2);
  static const TextStyle appBarTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 21.0,
    fontWeight: FontWeight.w700,
  );


  static const TextStyle textFieldHintStyle = TextStyle(
    color: Color(0xFF9B59B6),
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static final OutlineInputBorder textFieldEnabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    borderSide: BorderSide(color: Colors.transparent),
  );


  static final OutlineInputBorder textFieldFocusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    borderSide: BorderSide(
        color: Color(0xFF7D4B87), width: 1),
  );

  // ElevatedButton style
  static ButtonStyle saveButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: const Color(0xFFE74C3C),
    backgroundColor: const Color(0xFFBB8FCE),
    elevation: 0,
    padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: const BorderSide(width: 2, color: Color(0xFFE74C3C)),
    ),
  );

  // ElevatedButton text style
  static const TextStyle saveButtonTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
