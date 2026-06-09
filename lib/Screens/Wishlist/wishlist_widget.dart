import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Providers/product_provider.dart';
import 'package:grocery_app/Providers/wishlist_provider.dart';

import 'package:grocery_app/Services/global_methods.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/heart_button.dart';
import 'package:grocery_app/Widget/text_widget.dart';
import 'package:grocery_app/inner_screens/product_details_screen.dart';
import 'package:grocery_app/models/wishlist_model.dart';
import 'package:provider/provider.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final wishListModel = Provider.of<WishlistModel>(context);
    final wishListProvider = Provider.of<WishlistProvider>(context);

    final getCurrentProduct = productProvider.findProdById(
      wishListModel.prodId,
    );
    final Color color = Utils(context).color;
    double usedPrice =
        getCurrentProduct.isOnSale
            ? getCurrentProduct.salePrice
            : getCurrentProduct.price;
    Size size = Utils(context).screenSize;
    bool? isInWishList = wishListProvider.getWishlistItems.containsKey(
      getCurrentProduct.id,
    );

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            ProductDetailsScreen.routeName,
            arguments: wishListModel.prodId,
          );
        },
        child: Container(
          height: size.height * 0.15,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(left: 8),
                  // width: size.width * 0.2,
                  height: size.width * 0.25,
                  child: FancyShimmerImage(
                    imageUrl: getCurrentProduct.imageUrl,

                    // width: size.width * 0.22,
                    // height: size.width * 0.22,
                    boxFit: BoxFit.fill,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(IconlyLight.bag2, color: color),
                          ),

                          HeartButton(
                            prodId: getCurrentProduct.id,
                            isInWishList: isInWishList,
                          ),
                        ],
                      ),
                    ),
                    TextWidget(
                      title: getCurrentProduct.title,
                      color: color,
                      textSize: 20,
                      isTitle: true,
                      maxLines: 2,
                    ),
                    SizedBox(height: 5),
                    TextWidget(
                      title: '\$${usedPrice.toStringAsFixed(2)}',
                      color: color,
                      textSize: 18,
                      isTitle: true,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
