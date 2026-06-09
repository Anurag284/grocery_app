import 'package:flutter/material.dart';
import 'package:grocery_app/models/wishlist_model.dart';

class WishlistProvider with ChangeNotifier {
  Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getWishlistItems {
    return _wishlistItems;
  }

  void addRemoveProdFromWishlist({required String prodId}) {
    if (getWishlistItems.containsKey(prodId)) {
      removeOneItem(prodId);
    } else {
      _wishlistItems[prodId] = WishlistModel(
        id: DateTime.now().toString(),
        prodId: prodId,
      );
    }
    notifyListeners();
  }

  void removeOneItem(String prodId) {
    _wishlistItems.remove(prodId);
    notifyListeners();
  }

  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
