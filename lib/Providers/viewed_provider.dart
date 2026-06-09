import 'package:flutter/material.dart';
import 'package:grocery_app/models/viewed_model.dart';
import 'package:grocery_app/models/wishlist_model.dart';

class ViewedProvider with ChangeNotifier {
  Map<String, ViewedProductModel> _viewedProdListItems = {};

  Map<String, ViewedProductModel> get getViewedProdListItems {
    return _viewedProdListItems;
  }

  void addProdToViewed({required String prodId}) {
    _viewedProdListItems.putIfAbsent(
      prodId,
      () => ViewedProductModel(id: DateTime.now().toString(), prodId: prodId),
    );

    notifyListeners();
  }

  void clearViewed() {
    _viewedProdListItems.clear();
    notifyListeners();
  }
}
