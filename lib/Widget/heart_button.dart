import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Providers/wishlist_provider.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:provider/provider.dart' show Provider;

class HeartButton extends StatelessWidget {
  const HeartButton({
    super.key,
    required this.prodId,
    this.isInWishList = false,
  });
  final String prodId;
  final bool isInWishList;
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () {
        wishlistProvider.addRemoveProdFromWishlist(prodId: prodId);
      },
      child: Icon(
        isInWishList != null && isInWishList == true
            ? IconlyBold.heart
            : IconlyLight.heart,
        size: 22,
        color:
            isInWishList != null && isInWishList == true ? Colors.red : color,
      ),
    );
  }
}
