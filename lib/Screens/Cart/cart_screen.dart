import 'package:flutter/material.dart';
import 'package:grocery_app/Screens/Cart/cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return CartWidget();
        },
      ),
    );
  }
}
