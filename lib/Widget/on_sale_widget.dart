import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/Providers/cart_provider.dart';
import 'package:grocery_app/Providers/wishlist_provider.dart';
import 'package:grocery_app/Services/global_methods.dart';
import 'package:grocery_app/Services/utils.dart';
import 'package:grocery_app/Widget/heart_button.dart';
import 'package:grocery_app/Widget/price_widget.dart';
import 'package:grocery_app/Widget/text_widget.dart';
import 'package:grocery_app/inner_screens/product_details_screen.dart';
import 'package:grocery_app/models/cart_model.dart';
import 'package:grocery_app/models/product_model.dart' show ProductModel;
import 'package:provider/provider.dart';

class OnSaleWidget extends StatelessWidget {
  const OnSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final Color color = Utils(context).color;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishListProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishList = wishListProvider.getWishlistItems.containsKey(
      productModel.id,
    );
    Size size = Utils(context).screenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductDetailsScreen.routeName,
              arguments: productModel.id,
            );
            // GlobalMethods.navigateTo(
            //   context: context,
            //   routeName: ProductDetailsScreen.routeName,
            // );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      imageUrl: productModel.imageUrl,
                      errorWidget: Image.asset('assets/images/cat/fruits.png'),
                      height: size.width * 0.22,
                      width: size.width * 0.22,
                      boxFit: BoxFit.fill,
                    ),
                    // Image.network(
                    //   'https://i.ibb.co/F0s3FHQ/Apricots.png',
                    //   // width: size.width * 0.22,
                    //   height: size.width * 0.22,
                    //   fit: BoxFit.fill,
                    // ),
                    Column(
                      children: [
                        TextWidget(
                          title: productModel.isPiece ? '1 Piece' : '1 KG',
                          color: color,
                          textSize: 22,
                          isTitle: true,
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                cartProvider.addProdToCart(
                                  prodId: productModel.id,
                                  quantity: 1,
                                );
                              },
                              child: Icon(
                                isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
                                size: 22,
                                color: isInCart ? Colors.green : color,
                              ),
                            ),
                            HeartButton(
                              prodId: productModel.id,
                              isInWishList: isInWishList,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                PriceWidget(
                  isOnSale: true,
                  price: productModel.price,
                  salePrice: productModel.salePrice,
                  textPrice: '1',
                ),
                SizedBox(height: 5),
                TextWidget(
                  title: productModel.title,
                  color: color,
                  textSize: 16,
                  isTitle: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
