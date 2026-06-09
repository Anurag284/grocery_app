import 'package:flutter/widgets.dart';

class ViewedProductModel with ChangeNotifier {
  final String id, prodId;

  ViewedProductModel({required this.id, required this.prodId});
}
