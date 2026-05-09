import 'package:flutter/material.dart';
import 'package:grocery_app/Widget/text_widget.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.fct,
    required this.buttonText,
    this.primary = Colors.white38,
  });
  final Function fct;
  final String buttonText;
  final Color primary;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: primary),
        onPressed: () {
          fct();
        },
        child: TextWidget(title: buttonText, color: Colors.white, textSize: 18),
      ),
    );
  }
}
