import 'package:flutter/widgets.dart';

class WishlistModel with ChangeNotifier {
  final String id, prodId;

  WishlistModel({required this.id, required this.prodId});
}
