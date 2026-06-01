import 'package:flutter/material.dart';
import 'package:grocery_app/Services/utils.dart';

class EmptyProductScreen extends StatelessWidget {
  const EmptyProductScreen({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset('assets/images/box.png'),
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
