import 'package:flutter/material.dart';
import 'package:grocery_app/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  void addProdToCart({required String prodId, required int quantity}) {
    _cartItems.putIfAbsent(
      prodId,
      () => CartModel(
        id: DateTime.now().toString(),
        prodId: prodId,
        quantity: quantity,
      ),
    );
    notifyListeners();
  }

  void reduceQuantityByOne(String prodId) {
    {
      _cartItems.update(
        prodId,
        (value) => CartModel(
          id: value.id,
          prodId: prodId,
          quantity: value.quantity - 1,
        ),
      );
      notifyListeners();
    }
  }

  void increaseQuantityByOne(String prodId) {
    {
      _cartItems.update(
        prodId,
        (value) => CartModel(
          id: value.id,
          prodId: prodId,
          quantity: value.quantity + 1,
        ),
      );
      notifyListeners();
    }
  }

  void removeOneItem(String prodId) {
    _cartItems.remove(prodId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
