import 'package:flutter/widgets.dart';

class CartModel with ChangeNotifier {
  final String id, prodId;
  final int quantity;

  CartModel({required this.id, required this.prodId, required this.quantity});
}
