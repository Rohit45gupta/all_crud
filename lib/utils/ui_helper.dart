import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiHelper{

  // TextField

  static Widget buildTextField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  TextInputType keyboardType = TextInputType.text,
  }) {
  return TextFormField(
  controller: controller,
  keyboardType: keyboardType,
  decoration: InputDecoration(
  labelText: label,
  prefixIcon: Icon(icon),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  ),
  );
  }


  // ShowToast

  static void showSnackBar(BuildContext context, String message,
      {Color backgroundColor = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }


  // Button

  static Widget buildButton({
    required double height,
    required double width,
    required VoidCallback onPressed,
    required String text,
    required Color background,
    Color textColor = Colors.white,
    double borderRadius = 12,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
